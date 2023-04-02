import "libjbc/private/utils"
import os
import macros
import posix
{.passl: "-ljbc".}

proc sudo_call*(cb: proc {.closure.}) =
  jbc_run_as_root(rawProc(cb), rawEnv(cb), CWD_KEEP)

template sudo*(body:untyped) {.dirty.} =
  sudo_call(proc() {.closure.} =
    body)

