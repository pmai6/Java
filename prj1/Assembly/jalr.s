            la $a0, stack
            lw $sp, 0($sp)
                                        
            la   $at, fibonacci	         
            addi $a0, $zero, 15
            sw   $a0, 1($sp)
            jalr $at, $ra				
            halt						


fibonacci:	lw $v0, 1($sp)
			beq $zero, $zero, return

return:     jalr $ra, $t0  
            
stack:	    .word 0x4000			           