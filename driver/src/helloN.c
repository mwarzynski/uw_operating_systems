#include <minix/drivers.h>
#include <minix/chardriver.h>
#include <stdio.h>
#include <stdlib.h>
#include <minix/ds.h>

#include "helloN.h"

char *buffer;

/*
 * Function prototypes for the hello driver.
 */
static int hello_open(devminor_t minor, int access, endpoint_t user_endpt);
static int hello_close(devminor_t minor);
static ssize_t hello_read(devminor_t minor, u64_t position, endpoint_t endpt,
    cp_grant_id_t grant, size_t size, int flags, cdev_id_t id);
static ssize_t hello_write(devminor_t minor, u64_t position, endpoint_t endpt,
    cp_grant_id_t grant, size_t size, int flags, cdev_id_t id);

/* SEF functions and variables. */
static void sef_local_startup(void);
static int sef_cb_init(int type, sef_init_info_t *info);
static int sef_cb_lu_state_save(int);
static int lu_state_restore(void);

/* Entry points to the hello driver. */
static struct chardriver hello_tab =
{
    .cdr_read	= hello_read,
    .cdr_write  = hello_write,
};

/** State variable to count the number of times the device has been opened.
 * Note that this is not the regular type of open counter: it never decreases.
 */
static int open_counter;

int allocate_buffer() {
    buffer = (char *)malloc(sizeof(char)*DEVICE_SIZE);
    if (buffer == NULL)
        return EXIT_FAILURE;
    return OK;
}

void initialize_buffer() {
    for (int i = 0; i < DEVICE_SIZE; i++)
        buffer[i] = 'a';
}

static ssize_t hello_read(devminor_t UNUSED(minor), u64_t position,
    endpoint_t endpt, cp_grant_id_t grant, size_t size, int UNUSED(flags),
    cdev_id_t UNUSED(id)) {
    u64_t dev_size;
    char *ptr;
    int ret;

    dev_size = DEVICE_SIZE;

    if (position >= dev_size)
        return 0;

    if (position + size > dev_size)
        size = (size_t)(dev_size - position);

    ptr = buffer + (size_t)position;
    if ((ret = sys_safecopyto(endpt, grant, 0, (vir_bytes) ptr, size)) != OK)
        return ret;

    return size;
}

static ssize_t hello_write(devminor_t UNUSED(minor), u64_t position,
    endpoint_t endpt, cp_grant_id_t grant, size_t size, int UNUSED(flags),
    cdev_id_t UNUSED(id)) {
    u64_t dev_size;
    char *ptr;
    int ret;

    dev_size = DEVICE_SIZE;

    if (position >= dev_size)
        return 0;

    if (position + size > dev_size)
        size = (size_t)(dev_size - position);

    ptr = buffer + (size_t)position;
    if ((ret = sys_safecopyfrom(endpt, grant, 0, (vir_bytes) ptr, size)) != OK)
        return ret;

    return size;
}

static int sef_cb_lu_state_save(int UNUSED(state)) {
    // Save the state.
    ds_publish_u32("open_counter", open_counter, DSF_OVERWRITE);
    ds_publish_mem("hello_buffer", buffer, DEVICE_SIZE, DSF_OVERWRITE);

    return OK;
}


static int lu_state_restore() {
    u32_t value;

    ds_retrieve_u32("open_counter", &value);
    ds_delete_u32("open_counter");
    open_counter = (int) value;

    return OK;
}

static int buffer_restore() {
    size_t length = DEVICE_SIZE;

    ds_retrieve_mem("hello_buffer", buffer, &length);
    if (length != DEVICE_SIZE)
        return EXIT_FAILURE;

    ds_delete_mem("hello_buffer");

    return OK;
}

static void sef_local_startup()
{
    /*
     * Register init callbacks. Use the same function for all event types
     */
    sef_setcb_init_fresh(sef_cb_init);
    sef_setcb_init_lu(sef_cb_init);
    sef_setcb_init_restart(sef_cb_init);

    /*
     * Register live update callbacks.
     */
    /* - Agree to update immediately when LU is requested in a valid state. */
    sef_setcb_lu_prepare(sef_cb_lu_prepare_always_ready);
    /* - Support live update starting from any standard state. */
    sef_setcb_lu_state_isvalid(sef_cb_lu_state_isvalid_standard);
    /* - Register a custom routine to save the state. */
    sef_setcb_lu_state_save(sef_cb_lu_state_save);

    /* Let SEF perform startup. */
    sef_startup();
}

static int sef_cb_init(int type, sef_init_info_t *UNUSED(info))
{
/* Initialize the hello driver. */
    int do_announce_driver = TRUE;

    open_counter = 0;
    switch(type) {
        case SEF_INIT_FRESH:
            initialize_buffer();
        break;

        case SEF_INIT_LU:
            do_announce_driver = FALSE;
            lu_state_restore();
            if (buffer_restore() != OK)
                return EXIT_FAILURE;
        break;

        case SEF_INIT_RESTART:
        break;
    }

    /* Announce we are up when necessary. */
    if (do_announce_driver) {
        chardriver_announce();
    }

    /* Initialization completed successfully. */
    return OK;
}

int main(void)
{
    int status = allocate_buffer();
    if (status != OK)
        return status;

    /*
     * Perform initialization.
     */
    sef_local_startup();

    /*
     * Run the main loop.
     */
    chardriver_task(&hello_tab);
    return OK;
}

