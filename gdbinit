set disassembly-flavor intel
set pagination off
set step-mode on

set history filename ~/.gdb_history
set history save

set print array on
set print array-indexes on
set print asm-demangle on
set print demangle on
set print object on
set print pretty on
set print static-members on
set print symbol-filename on
set print thread-events off
set print vtbl on

set prompt \001\033[1;31m\002\n(^q^) \001\033[0m\002

define hex
  printf "0x%x", $arg0
end

#source ~/peda/peda.py
