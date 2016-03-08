!============================================================
! CS-2200 Homework 1
!
! Please do not change mains functionality,
! except to change the argument for fibonacci or to meet your
! calling convention
!============================================================

main:       la $sp, stack				! load address of stack label into $sp
            lw $sp, 0($sp)              ! load desired value of the stack
                                        ! (defined at the label below) into $sp
            la $at, fibonacci	        ! load address of fibonacci label into $at
            addi $a0, $zero, 15 	        ! $a0 = 8, the fibonacci argument
            addi $a0, $a0, 5
            sw $a0, 0($sp)              ! store the argument on the stack
            jalr $at, $ra				! jump to fibonacci, set $ra to return addr
            halt						! when we return, just halt


fibonacci:
            sw $ra, -1($sp)             !save the return address to the stack
            sw $fp, -2($sp)             !save the old frame pointer to the stack
            addi $fp, $sp, -2           !create a new frame pointer, point it to the address of the old one in the stack
            sw $s0, -3($fp)             !save saved registers
            sw $s1, -2($fp)             !save saved registers
            sw $s2, -1($fp)             !save saved registers
            addi $sp, $fp, -3           !move the sp to the end of the stack, this method has no local variables

            !note that I'll be using the saved registers as local variables,
            !because it makes the code more reusable and I don't care about
            !efficiency- thats why I'm writing in assembly

            lw $s0, 2($fp)              !pull arg0 from the stack into register s0
            addi $v0, $zero, 0          !prepare to return 0 if the next check passes
            beq $s0, $v0, return        !check if n is 1, return 1 if so
            addi $v0, $zero, 1          !prepare to return 1 if the next check passes
            beq $s0, $v0, return        !check if n is 1, return 1 if so

            addi $s0, $s0, -1           !s0 now stores n-1
            sw $s0, -1($sp)             !store n-1 as an argument for a new subroutine call
            addi $sp, $sp, -1           !decrement the stack pointer
            jalr $at, $ra               !call fib(n-1)
            addi $s1, $v0, 0            !Save the result in s1
                                        !note that sp has been incremented by 1 since 3 lines ago
            addi $s0, $s0, -1           !s0 now stores n-2
            sw $s0, -1($sp)             !store n-2 as an argument for a new subroutine call
            addi $sp, $sp, -1           !decrement the stack pointer
            jalr $at, $ra               !call fib(n-2)
            add $v0, $s1, $v0           !store fib(n-1) + fib(n-2) as our return value
            beq $zero, $zero, return    !return


return:                                 !Universal return function for 1 arg subroutines
            lw $s0, -3($fp)             !Restore saved registers
            lw $s1, -2($fp)             !Restore saved registers
            lw $s2, -1($fp)             !Restore saved registers
            addi $sp, $fp, 3            !Point Stack Pointer to the end of the old frame (3 assumes 1 arg)
            lw $ra, 1($fp)              !Load return address from the stack
            lw $fp, 0($fp)              !Load old frame pointer
            jalr $ra, $t0               !Return back to the caller



stack:	    .word 0x4000				! the stack begins here
