import "libjbc/private/utils"
import os
import macros
import posix
{.passl: "-ljbc".}

proc sudo_call*(cb: proc {.closure.}) = 
  jbc_run_as_root(rawProc(cb), rawEnv(cb), CWD_KEEP)

proc sudo_call_sandbox*(cb: proc {.closure.}) =
  jbc_run_as_root_in_sandbox(rawProc(cb), rawEnv(cb))

template sudo*(body:untyped) {.dirty.} =
  sudo_call_sandbox(proc() {.closure.} =
    body)
proc sudo_mount*(system_path: string, local_path: string) : cint =
 jbc_mount_in_sandbox(system_path.cstring, local_path.cstring)

proc sudo_unmount*(local_path: string) : cint =
  jbc_unmount_in_sandbox(local_path.string)
