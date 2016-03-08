!============================================================
! CS-2200 Homework 1
!
! Please do not change mains functionality,
! except to change the argument for fibonacci or to meet your
! calling convention
!============================================================

main:       la    $sp, stack		        ! load address of stack label into $sp
            lw    $sp, 0($sp)           ! FIXME: load desired value of the stack
                                        ! (defined at the label below) into $sp
            la    $at, fibonacci        ! load address of fibonacci label into $at
            addi  $a0, $zero, 3         ! $a0 = 8, the fibonacci argument
            sw    $a0, 0($sp)            ! store $a0 = n = 8 in the stack
            jalr  $at, $ra			        ! jump to fibonacci, set $ra to return addr
            halt						            ! when we return, just halt


fibonacci:                              ! FIXME: change me to your fibonacci implementation
            !!! STACK SET UP !!!
            sw    $ra, -1($sp)           ! store the return address
            sw    $s0, -2($sp)           ! store the saved register
            sw    $s1, -3($sp)           ! store the saved register
            sw    $s2, -4($sp)           ! store the saved register
            addi  $s2, $sp, -4           ! save the old stack pointer
            addi  $sp, $s2, 0            ! move the stack pointer to the top of the stack
            lw    $s0, 4($sp)            ! retrieve n
            beq   $s0, $zero, RET0       ! if (n == 0) go to return 0
            addi  $v0, $zero, 1          ! $t0 = 1
            beq   $s0, $v0, RET1         ! if ( n == 1) go to return 1
            beq   $zero, $zero, ELSE     ! if (n > 1) go to ELSE case

RET0:       addi  $v0, $zero, 0          ! return value is 0
            beq   $zero, $zero, EXIT

RET1:       addi  $v0, $zero, 1          ! return value is 1
            beq   $zero, $zero, EXIT

ELSE:       addi  $s0, $s0, -1           ! $s0 = n -1 = 7
            addi  $sp, $sp, -1           ! move the stack pointer up (point to new stack frame)
            sw    $s0, 0($sp)            ! save argument n-1 on stack
            jalr  $at, $ra               ! recurse to find fib(n-1)
            addi  $s1, $v0, 0            ! save fib(n-1) in $s1; $s1 = fib(n-1)
            addi  $s0, $s0, -1           ! $a0 = n - 2 = 6
            addi  $sp, $sp, -1           ! move the stack pointer up (point to new stack frame)
            sw    $s0, 0($sp)            ! save argument n-2 on stack
            jalr  $at, $ra          ! recurse to find fib(n-2)
            !addi  $s0, $v0, 0       ! store fib(n-2) in $s1; $s1 = fib(n-2)
           ! add   $v0, $s0, $s1     ! $v0 = fib(n-1) + fib(n-2)
            add   $v0, $s1, $v0           !store fib(n-1) + fib(n-2) as our return value
            beq   $zero, $zero, EXIT ! unconditional jump --> go to deconstruct the stack lll

            !! DECOMPOSE THE STACK !!
EXIT:       addi  $sp, $s2, 0       ! make stack pointer points at the original stack frame
            lw    $s2, 0($sp)      ! restore the saved register
            lw    $s1, 1($sp)      ! restore the saved register
            lw    $s0, 2($sp)      ! restore the saved register
            lw    $ra, 3($sp)       ! restore return address
            jalr  $ra, $zero        ! return to caller


stack:	    .word 0x4000				! the stack begins here
