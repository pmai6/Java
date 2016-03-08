		addi $v0,$zero, 15
		addi $a0,$zero, 15
		beq	 $a0,$v0,RET0
		beq  $zero,$zero,EXIT

RET0:	addi $v0,$zero,3
		beq	 $zero,$zero,EXIT

EXIT:   halt


