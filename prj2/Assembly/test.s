			addi $a1, $zero, 10		;a1 = 10
			addi $a0, $zero, 0		;a0 = 0
            sw   $v0, $zero(0)      ;v0 = mem[zero +0] --> point zero

A0LOOP:     addi  $a0, $a0, 1		;a0 = a0 + 1
            beq	 $a0, $a1, MEMINCR
			beq  $zero, $zero, A0LOOP

MEMINCR:    lw   $t0, $v0(0)        ;t0 = 0
            add  $v0, $t0, $a2		;t0 = t0 + 1
            sw   $v0, $zero(0)      ;v0 = mem[zero +0] --> point zero
            beq	 $v0, $a1, HALT
			beq  $zero, $zero, MEMINCR

HALT:       addi $t0, $zero, 0
            addi $a1, $zero, 0
            beq  $zero, $zero, HALT ;halt


            //int a0 = 0;
            //int* v0 = 0;
           // *v0 = 10;
           // for (int i = 0; i < 10; i++){
             //       a0 = a0 + 1;
           // }
           // for (int i = 0; i < 10; i++){
           //         *v0 = *v0 + 1;
           // }