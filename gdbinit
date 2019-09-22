set disassembly-flavor intel
set disassemble-next-line auto

set pagination off
set step-mode on

set history filename ~/.gdb_history
set history save on
set history size unlimited
set history expansion on

set print array-indexes on
set print array on
set print asm-demangle on
set print demangle on
set print frame-arguments all
set print object on
set print pretty on
set print static-members on
set print symbol-filename on
set print thread-events off
set print vtbl on

set prompt \001\033[1;31m\002\n(^q^) \001\033[0m\002

# helpers
define chr
  printf "[%c]", $arg0
end

define hex
  printf "0x%x", $arg0
end

define ord
  printf "[%d]", $arg0
end

define bin
  p/t $arg0
end

# aliases
define px
  p/x $arg0
end
define ps
  p/s $arg0
end
define pu
  p/u $arg0
end
define pb
  p/t $arg0
end
define py
  python-interactive
end
define pc
  x/8i $pc-10
end

# https://github.com/longld/peda
# source ~/work/peda.py

# https://github.com/hugsy/gef
# source ~/work/gef/gef.py
