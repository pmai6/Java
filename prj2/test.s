			      addi $a1, $zero, 10		  ;a1 = 10
			      addi $a0, $zero, 0		  ;a0 = 0
            sw   $a4, 0($zero)      ;v0 = mem[zero + 0] --> point zero

A0LOOP:     addi $a0, $a0, 1		    ;a0 = a0 + 1
            beq	 $a0, $a1, MEMINCR
			      beq  $zero, $zero, A0LOOP

MEMINCR:    lw   $a3, 0($a4)        ;a3 = 0
            addi $a4, $a3, 1		    ;a4 = a3 + 1
            sw   $a4, 0($zero)      ;a4 = mem[zero +0] --> point to zero
            beq	 $a4, $a1, DONE
			      beq  $zero, $zero, MEMINCR

DONE:       addi $a3, $zero, 0
            addi $a1, $zero, 0
            beq  $zero, $zero, DONE ;halt
