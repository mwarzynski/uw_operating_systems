#include "pm.h"
#include "mproc.h"
#include <stdio.h>

int do_myps(void) {
    int message_uid = m_in.m1_i1;

    for (int i = 0; i < NR_PROCS; i++) {
        int pid = mproc[i].mp_pid;
        if (pid == 0)
            continue;

        int uid = mproc[i].mp_realuid;
        if (uid != message_uid)
            continue;

        int parent_i = mproc[i].mp_parent;
        int ppid = mproc[parent_i].mp_pid;
        
        printf("pid: %d,\tppid: %d,\tuid: %d\n", pid, ppid, uid);
    }

    return OK;
}
