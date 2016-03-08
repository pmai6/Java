      addi $a1,$zero, 15
      addi $a0,$zero, 15
      beq	 $a0,$a1,RET0
      beq  $zero,$zero,EXIT

RET0:	addi $a1,$zero, 3
EXIT:	beq	 $zero,$zero,EXIT
