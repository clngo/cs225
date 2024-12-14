# Test file Load any subrubtimes mark Load here
.text
li sp,0x7FFFF
li s0,-1
li s1,-1
li s2,-1
li s3,-1
li s4,-1
li s5,-1
li s6,-1
li s7,-1
li s8,-1
li s9,-1
li s10,-1
li s11,-1

la a0, myCharArray
jal strlen

#la a0, newArray
li a7, 1
ecall


li t0,-1
li t1,0x7FFFF
bne s0,t0,fail
bne s1,t0,fail
bne s2,t0,fail
bne s3,t0,fail
bne s4,t0,fail
bne s5,t0,fail
bne s6,t0,fail
bne s7,t0,fail
bne s8,t0,fail
bne s9,t0,fail
bne s10,t0,fail
bne s11,t0,fail
bne sp,t1,fail
la a0,testPass
li a7,4
ecall
b endProgram
fail:
la a0,testPass
li a7,4
ecall
endProgram:
li a7,10
ecall
.data
myCharArray: .string "G Brother Smoke House"
newArray: .space 45
testPass: .string "Test Passed!"
testFail: .string "How DARE YOU you tocuh my save registers!! "
