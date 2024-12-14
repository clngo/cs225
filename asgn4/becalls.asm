.text
.globl printInt
.globl printString
.globl printChar
.globl readChar
.globl readInt
.globl readString
.globl exitProgram

printInt:
  li a7, 1          # Load 1 into a7 for printing integer
  ecall             # Make ecall for printing integer
  ret               # Return from subroutine

printString:
  li a7, 4          # Load 4 into a7 for printing string
  ecall             # Make ecall for printing string
  ret               # Return from subroutine

printChar:
  li a7, 11         # Load 11 into a7 for printing character
  ecall             # Make ecall for printing character
  ret               # Return from subroutine

readChar:
  li a7, 12         # Load 12 into a7 for reading character
  ecall             # Make ecall for reading character
  ret               # Return from subroutine

readInt:
  li a7, 5          # Load 5 into a7 for reading integer
  ecall             # Make ecall for reading integer
  ret               # Return from subroutine

readString:
  li a7, 8          # Load 8 into a7 for reading string
  ecall             # Make ecall for reading string
  ret               # Return from subroutine

exitProgram:
  li a7, 10         # Load 10 into a7 for exiting program
  ecall             # Make ecall for exiting program
  ret               # Return from subroutine
