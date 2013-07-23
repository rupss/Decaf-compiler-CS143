	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
	# VTable for class Random
	  .data
	  .align 2
	  Random:		# label for class Random vtable
	  .word _Random.Init
	  .word _Random.GenRandom
	  .word _Random.RndInt
	  .text
  _Random.Init:
	# BeginFunc 8
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 8	# decrement sp to make space for locals/temps
	# _tmp0 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp1 = this + _tmp0
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# *(_tmp1) = seedVal
	  lw $t3, 8($fp)	# load seedVal from $fp+8 into $t3
	  sw $t3, 0($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.GenRandom:
	# BeginFunc 64
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 64	# decrement sp to make space for locals/temps
	# _tmp2 = 65536
	  li $t0, 65536		# load constant value 65536 into $t0
	# _tmp3 = 22221
	  li $t1, 22221		# load constant value 22221 into $t1
	# _tmp4 = 10000
	  li $t2, 10000		# load constant value 10000 into $t2
	# _tmp5 = 4
	  li $t3, 4		# load constant value 4 into $t3
	# _tmp6 = this + _tmp5
	  lw $t4, 4($fp)	# load this from $fp+4 into $t4
	  add $t5, $t4, $t3	
	# _tmp7 = *(_tmp6)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp8 = _tmp7 % _tmp4
	  rem $t7, $t6, $t2	
	# _tmp9 = 15625
	  li $s0, 15625		# load constant value 15625 into $s0
	# _tmp10 = _tmp9 * _tmp8
	  mul $s1, $s0, $t7	
	# _tmp11 = _tmp10 + _tmp3
	  add $s2, $s1, $t1	
	# _tmp12 = _tmp11 % _tmp2
	  rem $s3, $s2, $t0	
	# _tmp13 = 4
	  li $s4, 4		# load constant value 4 into $s4
	# _tmp14 = this + _tmp13
	  add $s5, $t4, $s4	
	# *(_tmp14) = _tmp12
	  sw $s3, 0($s5) 	# store with offset
	# _tmp15 = 4
	  li $s6, 4		# load constant value 4 into $s6
	# _tmp16 = this + _tmp15
	  add $s7, $t4, $s6	
	# _tmp17 = *(_tmp16)
	  lw $t8, 0($s7) 	# load with offset
	# Return _tmp17
	  move $v0, $t8		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.RndInt:
	# BeginFunc 24
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 24	# decrement sp to make space for locals/temps
	# _tmp18 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp19 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp20 = _tmp19 + _tmp18
	  add $t3, $t2, $t1	
	# _tmp21 = *(_tmp20)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp22 = ACall _tmp21
	# (save modified registers before flow of control change)
	  sw $t1, -8($fp)	# spill _tmp18 from $t1 to $fp-8
	  sw $t2, -12($fp)	# spill _tmp19 from $t2 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp20 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp21 from $t4 to $fp-20
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp23 = _tmp22 % max
	  lw $t1, 8($fp)	# load max from $fp+8 into $t1
	  rem $t2, $t0, $t1	
	# Return _tmp23
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Deck
	  .data
	  .align 2
	  Deck:		# label for class Deck vtable
	  .word _Deck.Init
	  .word _Deck.Shuffle
	  .word _Deck.GetCard
	  .text
  _Deck.Init:
	# BeginFunc 52
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 52	# decrement sp to make space for locals/temps
	# _tmp24 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp25 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp26 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp27 = _tmp26 + _tmp24
	  add $t3, $t2, $t0	
	# _tmp28 = 4
	  li $t4, 4		# load constant value 4 into $t4
	# _tmp29 = _tmp28 * _tmp27
	  mul $t5, $t4, $t3	
	# _tmp30 = _tmp24 < _tmp25
	  slt $t6, $t0, $t1	
	# _tmp31 = _tmp24 == _tmp25
	  seq $t7, $t0, $t1	
	# _tmp32 = _tmp31 || _tmp30
	  or $s0, $t7, $t6	
	# IfZ _tmp32 Goto _L0
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp24 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp25 from $t1 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp26 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill _tmp27 from $t3 to $fp-20
	  sw $t4, -24($fp)	# spill _tmp28 from $t4 to $fp-24
	  sw $t5, -28($fp)	# spill _tmp29 from $t5 to $fp-28
	  sw $t6, -32($fp)	# spill _tmp30 from $t6 to $fp-32
	  sw $t7, -36($fp)	# spill _tmp31 from $t7 to $fp-36
	  sw $s0, -40($fp)	# spill _tmp32 from $s0 to $fp-40
	  beqz $s0, _L0	# branch if _tmp32 is zero 
	# _tmp33 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp33
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -44($fp)	# spill _tmp33 from $t0 to $fp-44
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L0:
	# PushParam _tmp29
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# load _tmp29 from $fp-28 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp34 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp34) = _tmp24
	  lw $t1, -8($fp)	# load _tmp24 from $fp-8 into $t1
	  sw $t1, 0($t0) 	# store with offset
	# _tmp35 = 8
	  li $t2, 8		# load constant value 8 into $t2
	# _tmp36 = this + _tmp35
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# *(_tmp36) = _tmp34
	  sw $t0, 0($t4) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.Shuffle:
	# BeginFunc 552
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 552	# decrement sp to make space for locals/temps
	# _tmp37 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp38 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp39 = this + _tmp38
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp39) = _tmp37
	  sw $t0, 0($t3) 	# store with offset
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp37 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp38 from $t1 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp39 from $t3 to $fp-16
  _L1:
	# _tmp40 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp41 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp42 = this + _tmp41
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp43 = _tmp42 < _tmp40
	  slt $t4, $t3, $t0	
	# IfZ _tmp43 Goto _L2
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp40 from $t0 to $fp-20
	  sw $t1, -24($fp)	# spill _tmp41 from $t1 to $fp-24
	  sw $t3, -28($fp)	# spill _tmp42 from $t3 to $fp-28
	  sw $t4, -32($fp)	# spill _tmp43 from $t4 to $fp-32
	  beqz $t4, _L2	# branch if _tmp43 is zero 
	# _tmp44 = 13
	  li $t0, 13		# load constant value 13 into $t0
	# _tmp45 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp46 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp47 = this + _tmp46
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# _tmp48 = *(_tmp47)
	  lw $t5, 0($t4) 	# load with offset
	# _tmp49 = _tmp48 + _tmp45
	  add $t6, $t5, $t1	
	# _tmp50 = _tmp49 % _tmp44
	  rem $t7, $t6, $t0	
	# _tmp51 = 4
	  li $s0, 4		# load constant value 4 into $s0
	# _tmp52 = this + _tmp51
	  add $s1, $t3, $s0	
	# _tmp53 = *(_tmp52)
	  lw $s2, 0($s1) 	# load with offset
	# _tmp54 = 8
	  li $s3, 8		# load constant value 8 into $s3
	# _tmp55 = this + _tmp54
	  add $s4, $t3, $s3	
	# _tmp56 = *(_tmp55)
	  lw $s5, 0($s4) 	# load with offset
	# _tmp57 = *(_tmp56)
	  lw $s6, 0($s5) 	# load with offset
	# _tmp58 = *(_tmp55)
	  lw $s7, 0($s4) 	# load with offset
	# _tmp59 = _tmp57 < _tmp53
	  slt $t8, $s6, $s2	
	# _tmp60 = _tmp57 == _tmp53
	  seq $t9, $s6, $s2	
	# _tmp61 = _tmp60 || _tmp59
	  or $t3, $t9, $t8	
	# _tmp62 = 0
	  sw $t0, -36($fp)	# spill _tmp44 from $t0 to $fp-36
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp63 = _tmp53 < _tmp62
	  sw $t1, -40($fp)	# spill _tmp45 from $t1 to $fp-40
	  slt $t1, $s2, $t0	
	# _tmp64 = _tmp61 || _tmp63
	  sw $t2, -44($fp)	# spill _tmp46 from $t2 to $fp-44
	  or $t2, $t3, $t1	
	# IfZ _tmp64 Goto _L3
	# (save modified registers before flow of control change)
	  sw $t0, -108($fp)	# spill _tmp62 from $t0 to $fp-108
	  sw $t1, -112($fp)	# spill _tmp63 from $t1 to $fp-112
	  sw $t2, -116($fp)	# spill _tmp64 from $t2 to $fp-116
	  sw $t3, -104($fp)	# spill _tmp61 from $t3 to $fp-104
	  sw $t4, -48($fp)	# spill _tmp47 from $t4 to $fp-48
	  sw $t5, -52($fp)	# spill _tmp48 from $t5 to $fp-52
	  sw $t6, -56($fp)	# spill _tmp49 from $t6 to $fp-56
	  sw $t7, -60($fp)	# spill _tmp50 from $t7 to $fp-60
	  sw $s0, -64($fp)	# spill _tmp51 from $s0 to $fp-64
	  sw $s1, -68($fp)	# spill _tmp52 from $s1 to $fp-68
	  sw $s2, -72($fp)	# spill _tmp53 from $s2 to $fp-72
	  sw $s3, -76($fp)	# spill _tmp54 from $s3 to $fp-76
	  sw $s4, -80($fp)	# spill _tmp55 from $s4 to $fp-80
	  sw $s5, -84($fp)	# spill _tmp56 from $s5 to $fp-84
	  sw $s6, -88($fp)	# spill _tmp57 from $s6 to $fp-88
	  sw $s7, -92($fp)	# spill _tmp58 from $s7 to $fp-92
	  sw $t8, -96($fp)	# spill _tmp59 from $t8 to $fp-96
	  sw $t9, -100($fp)	# spill _tmp60 from $t9 to $fp-100
	  beqz $t2, _L3	# branch if _tmp64 is zero 
	# _tmp65 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp65
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -120($fp)	# spill _tmp65 from $t0 to $fp-120
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L3:
	# _tmp66 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp67 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp68 = _tmp67 + _tmp53
	  lw $t2, -72($fp)	# load _tmp53 from $fp-72 into $t2
	  add $t3, $t1, $t2	
	# _tmp69 = _tmp66 * _tmp68
	  mul $t4, $t0, $t3	
	# _tmp70 = _tmp58 + _tmp69
	  lw $t5, -92($fp)	# load _tmp58 from $fp-92 into $t5
	  add $t6, $t5, $t4	
	# *(_tmp70) = _tmp50
	  lw $t7, -60($fp)	# load _tmp50 from $fp-60 into $t7
	  sw $t7, 0($t6) 	# store with offset
	# _tmp71 = 1
	  li $s0, 1		# load constant value 1 into $s0
	# _tmp72 = 4
	  li $s1, 4		# load constant value 4 into $s1
	# _tmp73 = this + _tmp72
	  lw $s2, 4($fp)	# load this from $fp+4 into $s2
	  add $s3, $s2, $s1	
	# _tmp74 = *(_tmp73)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp75 = _tmp74 + _tmp71
	  add $s5, $s4, $s0	
	# _tmp76 = 4
	  li $s6, 4		# load constant value 4 into $s6
	# _tmp77 = this + _tmp76
	  add $s7, $s2, $s6	
	# *(_tmp77) = _tmp75
	  sw $s5, 0($s7) 	# store with offset
	# Goto _L1
	# (save modified registers before flow of control change)
	  sw $t0, -124($fp)	# spill _tmp66 from $t0 to $fp-124
	  sw $t1, -128($fp)	# spill _tmp67 from $t1 to $fp-128
	  sw $t3, -132($fp)	# spill _tmp68 from $t3 to $fp-132
	  sw $t4, -136($fp)	# spill _tmp69 from $t4 to $fp-136
	  sw $t6, -140($fp)	# spill _tmp70 from $t6 to $fp-140
	  sw $s0, -144($fp)	# spill _tmp71 from $s0 to $fp-144
	  sw $s1, -148($fp)	# spill _tmp72 from $s1 to $fp-148
	  sw $s3, -152($fp)	# spill _tmp73 from $s3 to $fp-152
	  sw $s4, -156($fp)	# spill _tmp74 from $s4 to $fp-156
	  sw $s5, -160($fp)	# spill _tmp75 from $s5 to $fp-160
	  sw $s6, -164($fp)	# spill _tmp76 from $s6 to $fp-164
	  sw $s7, -168($fp)	# spill _tmp77 from $s7 to $fp-168
	  b _L1		# unconditional branch
  _L2:
  _L4:
	# _tmp78 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp79 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp80 = this + _tmp79
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp81 = _tmp78 < _tmp80
	  slt $t4, $t0, $t3	
	# IfZ _tmp81 Goto _L5
	# (save modified registers before flow of control change)
	  sw $t0, -172($fp)	# spill _tmp78 from $t0 to $fp-172
	  sw $t1, -176($fp)	# spill _tmp79 from $t1 to $fp-176
	  sw $t3, -180($fp)	# spill _tmp80 from $t3 to $fp-180
	  sw $t4, -184($fp)	# spill _tmp81 from $t4 to $fp-184
	  beqz $t4, _L5	# branch if _tmp81 is zero 
	# _tmp82 = *(gRnd)
	  lw $t0, -188($fp)	# load gRnd from $fp-188 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp83 = 8
	  li $t2, 8		# load constant value 8 into $t2
	# _tmp84 = _tmp83 + _tmp82
	  add $t3, $t2, $t1	
	# _tmp85 = *(_tmp84)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp86 = 4
	  li $t5, 4		# load constant value 4 into $t5
	# _tmp87 = this + _tmp86
	  lw $t6, 4($fp)	# load this from $fp+4 into $t6
	  add $t7, $t6, $t5	
	# PushParam _tmp87
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t7, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp88 = ACall _tmp85
	# (save modified registers before flow of control change)
	  sw $t1, -192($fp)	# spill _tmp82 from $t1 to $fp-192
	  sw $t2, -196($fp)	# spill _tmp83 from $t2 to $fp-196
	  sw $t3, -200($fp)	# spill _tmp84 from $t3 to $fp-200
	  sw $t4, -204($fp)	# spill _tmp85 from $t4 to $fp-204
	  sw $t5, -208($fp)	# spill _tmp86 from $t5 to $fp-208
	  sw $t7, -212($fp)	# spill _tmp87 from $t7 to $fp-212
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# r = _tmp88
	  move $t1, $t0		# copy value
	# _tmp89 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp90 = 4
	  li $t3, 4		# load constant value 4 into $t3
	# _tmp91 = this + _tmp90
	  lw $t4, 4($fp)	# load this from $fp+4 into $t4
	  add $t5, $t4, $t3	
	# _tmp92 = *(_tmp91)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp93 = _tmp92 - _tmp89
	  sub $t7, $t6, $t2	
	# _tmp94 = 4
	  li $s0, 4		# load constant value 4 into $s0
	# _tmp95 = this + _tmp94
	  add $s1, $t4, $s0	
	# *(_tmp95) = _tmp93
	  sw $t7, 0($s1) 	# store with offset
	# _tmp96 = 4
	  li $s2, 4		# load constant value 4 into $s2
	# _tmp97 = this + _tmp96
	  add $s3, $t4, $s2	
	# _tmp98 = *(_tmp97)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp99 = 8
	  li $s5, 8		# load constant value 8 into $s5
	# _tmp100 = this + _tmp99
	  add $s6, $t4, $s5	
	# _tmp101 = *(_tmp100)
	  lw $s7, 0($s6) 	# load with offset
	# _tmp102 = *(_tmp101)
	  lw $t8, 0($s7) 	# load with offset
	# _tmp103 = *(_tmp100)
	  lw $t9, 0($s6) 	# load with offset
	# _tmp104 = _tmp102 < _tmp98
	  slt $t4, $t8, $s4	
	# _tmp105 = _tmp102 == _tmp98
	  sw $t3, -228($fp)	# spill _tmp90 from $t3 to $fp-228
	  seq $t3, $t8, $s4	
	# _tmp106 = _tmp105 || _tmp104
	  sw $t5, -232($fp)	# spill _tmp91 from $t5 to $fp-232
	  or $t5, $t3, $t4	
	# _tmp107 = 0
	  sw $t6, -236($fp)	# spill _tmp92 from $t6 to $fp-236
	  li $t6, 0		# load constant value 0 into $t6
	# _tmp108 = _tmp98 < _tmp107
	  sw $t7, -240($fp)	# spill _tmp93 from $t7 to $fp-240
	  slt $t7, $s4, $t6	
	# _tmp109 = _tmp106 || _tmp108
	  sw $s0, -244($fp)	# spill _tmp94 from $s0 to $fp-244
	  or $s0, $t5, $t7	
	# IfZ _tmp109 Goto _L6
	# (save modified registers before flow of control change)
	  sw $t0, -216($fp)	# spill _tmp88 from $t0 to $fp-216
	  sw $t1, -220($fp)	# spill r from $t1 to $fp-220
	  sw $t2, -224($fp)	# spill _tmp89 from $t2 to $fp-224
	  sw $t3, -288($fp)	# spill _tmp105 from $t3 to $fp-288
	  sw $t4, -284($fp)	# spill _tmp104 from $t4 to $fp-284
	  sw $t5, -292($fp)	# spill _tmp106 from $t5 to $fp-292
	  sw $t6, -296($fp)	# spill _tmp107 from $t6 to $fp-296
	  sw $t7, -300($fp)	# spill _tmp108 from $t7 to $fp-300
	  sw $s0, -304($fp)	# spill _tmp109 from $s0 to $fp-304
	  sw $s1, -248($fp)	# spill _tmp95 from $s1 to $fp-248
	  sw $s2, -252($fp)	# spill _tmp96 from $s2 to $fp-252
	  sw $s3, -256($fp)	# spill _tmp97 from $s3 to $fp-256
	  sw $s4, -260($fp)	# spill _tmp98 from $s4 to $fp-260
	  sw $s5, -264($fp)	# spill _tmp99 from $s5 to $fp-264
	  sw $s6, -268($fp)	# spill _tmp100 from $s6 to $fp-268
	  sw $s7, -272($fp)	# spill _tmp101 from $s7 to $fp-272
	  sw $t8, -276($fp)	# spill _tmp102 from $t8 to $fp-276
	  sw $t9, -280($fp)	# spill _tmp103 from $t9 to $fp-280
	  beqz $s0, _L6	# branch if _tmp109 is zero 
	# _tmp110 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp110
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -308($fp)	# spill _tmp110 from $t0 to $fp-308
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L6:
	# _tmp111 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp112 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp113 = _tmp112 + _tmp98
	  lw $t2, -260($fp)	# load _tmp98 from $fp-260 into $t2
	  add $t3, $t1, $t2	
	# _tmp114 = _tmp111 * _tmp113
	  mul $t4, $t0, $t3	
	# _tmp115 = _tmp103 + _tmp114
	  lw $t5, -280($fp)	# load _tmp103 from $fp-280 into $t5
	  add $t6, $t5, $t4	
	# _tmp116 = *(_tmp115)
	  lw $t7, 0($t6) 	# load with offset
	# temp = _tmp116
	  move $s0, $t7		# copy value
	# _tmp117 = 8
	  li $s1, 8		# load constant value 8 into $s1
	# _tmp118 = this + _tmp117
	  lw $s2, 4($fp)	# load this from $fp+4 into $s2
	  add $s3, $s2, $s1	
	# _tmp119 = *(_tmp118)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp120 = *(_tmp119)
	  lw $s5, 0($s4) 	# load with offset
	# _tmp121 = *(_tmp118)
	  lw $s6, 0($s3) 	# load with offset
	# _tmp122 = _tmp120 < r
	  lw $s7, -220($fp)	# load r from $fp-220 into $s7
	  slt $t8, $s5, $s7	
	# _tmp123 = _tmp120 == r
	  seq $t9, $s5, $s7	
	# _tmp124 = _tmp123 || _tmp122
	  or $t2, $t9, $t8	
	# _tmp125 = 0
	  li $t5, 0		# load constant value 0 into $t5
	# _tmp126 = r < _tmp125
	  slt $s2, $s7, $t5	
	# _tmp127 = _tmp124 || _tmp126
	  or $s7, $t2, $s2	
	# IfZ _tmp127 Goto _L7
	# (save modified registers before flow of control change)
	  sw $t0, -312($fp)	# spill _tmp111 from $t0 to $fp-312
	  sw $t1, -316($fp)	# spill _tmp112 from $t1 to $fp-316
	  sw $t2, -368($fp)	# spill _tmp124 from $t2 to $fp-368
	  sw $t3, -320($fp)	# spill _tmp113 from $t3 to $fp-320
	  sw $t4, -324($fp)	# spill _tmp114 from $t4 to $fp-324
	  sw $t5, -372($fp)	# spill _tmp125 from $t5 to $fp-372
	  sw $t6, -328($fp)	# spill _tmp115 from $t6 to $fp-328
	  sw $t7, -332($fp)	# spill _tmp116 from $t7 to $fp-332
	  sw $s0, -336($fp)	# spill temp from $s0 to $fp-336
	  sw $s1, -340($fp)	# spill _tmp117 from $s1 to $fp-340
	  sw $s2, -376($fp)	# spill _tmp126 from $s2 to $fp-376
	  sw $s3, -344($fp)	# spill _tmp118 from $s3 to $fp-344
	  sw $s4, -348($fp)	# spill _tmp119 from $s4 to $fp-348
	  sw $s5, -352($fp)	# spill _tmp120 from $s5 to $fp-352
	  sw $s6, -356($fp)	# spill _tmp121 from $s6 to $fp-356
	  sw $s7, -380($fp)	# spill _tmp127 from $s7 to $fp-380
	  sw $t8, -360($fp)	# spill _tmp122 from $t8 to $fp-360
	  sw $t9, -364($fp)	# spill _tmp123 from $t9 to $fp-364
	  beqz $s7, _L7	# branch if _tmp127 is zero 
	# _tmp128 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp128
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -384($fp)	# spill _tmp128 from $t0 to $fp-384
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L7:
	# _tmp129 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp130 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp131 = _tmp130 + r
	  lw $t2, -220($fp)	# load r from $fp-220 into $t2
	  add $t3, $t1, $t2	
	# _tmp132 = _tmp129 * _tmp131
	  mul $t4, $t0, $t3	
	# _tmp133 = _tmp121 + _tmp132
	  lw $t5, -356($fp)	# load _tmp121 from $fp-356 into $t5
	  add $t6, $t5, $t4	
	# _tmp134 = *(_tmp133)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp135 = 4
	  li $s0, 4		# load constant value 4 into $s0
	# _tmp136 = this + _tmp135
	  lw $s1, 4($fp)	# load this from $fp+4 into $s1
	  add $s2, $s1, $s0	
	# _tmp137 = *(_tmp136)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp138 = 8
	  li $s4, 8		# load constant value 8 into $s4
	# _tmp139 = this + _tmp138
	  add $s5, $s1, $s4	
	# _tmp140 = *(_tmp139)
	  lw $s6, 0($s5) 	# load with offset
	# _tmp141 = *(_tmp140)
	  lw $s7, 0($s6) 	# load with offset
	# _tmp142 = *(_tmp139)
	  lw $t8, 0($s5) 	# load with offset
	# _tmp143 = _tmp141 < _tmp137
	  slt $t9, $s7, $s3	
	# _tmp144 = _tmp141 == _tmp137
	  seq $t2, $s7, $s3	
	# _tmp145 = _tmp144 || _tmp143
	  or $t5, $t2, $t9	
	# _tmp146 = 0
	  li $s1, 0		# load constant value 0 into $s1
	# _tmp147 = _tmp137 < _tmp146
	  sw $s2, -416($fp)	# spill _tmp136 from $s2 to $fp-416
	  slt $s2, $s3, $s1	
	# _tmp148 = _tmp145 || _tmp147
	  sw $s3, -420($fp)	# spill _tmp137 from $s3 to $fp-420
	  or $s3, $t5, $s2	
	# IfZ _tmp148 Goto _L8
	# (save modified registers before flow of control change)
	  sw $t0, -388($fp)	# spill _tmp129 from $t0 to $fp-388
	  sw $t1, -392($fp)	# spill _tmp130 from $t1 to $fp-392
	  sw $t2, -448($fp)	# spill _tmp144 from $t2 to $fp-448
	  sw $t3, -396($fp)	# spill _tmp131 from $t3 to $fp-396
	  sw $t4, -400($fp)	# spill _tmp132 from $t4 to $fp-400
	  sw $t5, -452($fp)	# spill _tmp145 from $t5 to $fp-452
	  sw $t6, -404($fp)	# spill _tmp133 from $t6 to $fp-404
	  sw $t7, -408($fp)	# spill _tmp134 from $t7 to $fp-408
	  sw $s0, -412($fp)	# spill _tmp135 from $s0 to $fp-412
	  sw $s1, -456($fp)	# spill _tmp146 from $s1 to $fp-456
	  sw $s2, -460($fp)	# spill _tmp147 from $s2 to $fp-460
	  sw $s3, -464($fp)	# spill _tmp148 from $s3 to $fp-464
	  sw $s4, -424($fp)	# spill _tmp138 from $s4 to $fp-424
	  sw $s5, -428($fp)	# spill _tmp139 from $s5 to $fp-428
	  sw $s6, -432($fp)	# spill _tmp140 from $s6 to $fp-432
	  sw $s7, -436($fp)	# spill _tmp141 from $s7 to $fp-436
	  sw $t8, -440($fp)	# spill _tmp142 from $t8 to $fp-440
	  sw $t9, -444($fp)	# spill _tmp143 from $t9 to $fp-444
	  beqz $s3, _L8	# branch if _tmp148 is zero 
	# _tmp149 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp149
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -468($fp)	# spill _tmp149 from $t0 to $fp-468
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L8:
	# _tmp150 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp151 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp152 = _tmp151 + _tmp137
	  lw $t2, -420($fp)	# load _tmp137 from $fp-420 into $t2
	  add $t3, $t1, $t2	
	# _tmp153 = _tmp150 * _tmp152
	  mul $t4, $t0, $t3	
	# _tmp154 = _tmp142 + _tmp153
	  lw $t5, -440($fp)	# load _tmp142 from $fp-440 into $t5
	  add $t6, $t5, $t4	
	# *(_tmp154) = _tmp134
	  lw $t7, -408($fp)	# load _tmp134 from $fp-408 into $t7
	  sw $t7, 0($t6) 	# store with offset
	# _tmp155 = 8
	  li $s0, 8		# load constant value 8 into $s0
	# _tmp156 = this + _tmp155
	  lw $s1, 4($fp)	# load this from $fp+4 into $s1
	  add $s2, $s1, $s0	
	# _tmp157 = *(_tmp156)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp158 = *(_tmp157)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp159 = *(_tmp156)
	  lw $s5, 0($s2) 	# load with offset
	# _tmp160 = _tmp158 < r
	  lw $s6, -220($fp)	# load r from $fp-220 into $s6
	  slt $s7, $s4, $s6	
	# _tmp161 = _tmp158 == r
	  seq $t8, $s4, $s6	
	# _tmp162 = _tmp161 || _tmp160
	  or $t9, $t8, $s7	
	# _tmp163 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp164 = r < _tmp163
	  slt $t5, $s6, $t2	
	# _tmp165 = _tmp162 || _tmp164
	  or $t7, $t9, $t5	
	# IfZ _tmp165 Goto _L9
	# (save modified registers before flow of control change)
	  sw $t0, -472($fp)	# spill _tmp150 from $t0 to $fp-472
	  sw $t1, -476($fp)	# spill _tmp151 from $t1 to $fp-476
	  sw $t2, -524($fp)	# spill _tmp163 from $t2 to $fp-524
	  sw $t3, -480($fp)	# spill _tmp152 from $t3 to $fp-480
	  sw $t4, -484($fp)	# spill _tmp153 from $t4 to $fp-484
	  sw $t5, -528($fp)	# spill _tmp164 from $t5 to $fp-528
	  sw $t6, -488($fp)	# spill _tmp154 from $t6 to $fp-488
	  sw $t7, -532($fp)	# spill _tmp165 from $t7 to $fp-532
	  sw $s0, -492($fp)	# spill _tmp155 from $s0 to $fp-492
	  sw $s2, -496($fp)	# spill _tmp156 from $s2 to $fp-496
	  sw $s3, -500($fp)	# spill _tmp157 from $s3 to $fp-500
	  sw $s4, -504($fp)	# spill _tmp158 from $s4 to $fp-504
	  sw $s5, -508($fp)	# spill _tmp159 from $s5 to $fp-508
	  sw $s7, -512($fp)	# spill _tmp160 from $s7 to $fp-512
	  sw $t8, -516($fp)	# spill _tmp161 from $t8 to $fp-516
	  sw $t9, -520($fp)	# spill _tmp162 from $t9 to $fp-520
	  beqz $t7, _L9	# branch if _tmp165 is zero 
	# _tmp166 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp166
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -536($fp)	# spill _tmp166 from $t0 to $fp-536
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L9:
	# _tmp167 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp168 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp169 = _tmp168 + r
	  lw $t2, -220($fp)	# load r from $fp-220 into $t2
	  add $t3, $t1, $t2	
	# _tmp170 = _tmp167 * _tmp169
	  mul $t4, $t0, $t3	
	# _tmp171 = _tmp159 + _tmp170
	  lw $t5, -508($fp)	# load _tmp159 from $fp-508 into $t5
	  add $t6, $t5, $t4	
	# *(_tmp171) = temp
	  lw $t7, -336($fp)	# load temp from $fp-336 into $t7
	  sw $t7, 0($t6) 	# store with offset
	# Goto _L4
	# (save modified registers before flow of control change)
	  sw $t0, -540($fp)	# spill _tmp167 from $t0 to $fp-540
	  sw $t1, -544($fp)	# spill _tmp168 from $t1 to $fp-544
	  sw $t3, -548($fp)	# spill _tmp169 from $t3 to $fp-548
	  sw $t4, -552($fp)	# spill _tmp170 from $t4 to $fp-552
	  sw $t6, -556($fp)	# spill _tmp171 from $t6 to $fp-556
	  b _L4		# unconditional branch
  _L5:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.GetCard:
	# BeginFunc 144
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 144	# decrement sp to make space for locals/temps
	# _tmp172 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp173 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp174 = this + _tmp173
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp175 = _tmp172 < _tmp174
	  slt $t4, $t0, $t3	
	# _tmp176 = _tmp172 == _tmp174
	  seq $t5, $t0, $t3	
	# _tmp177 = _tmp175 || _tmp176
	  or $t6, $t4, $t5	
	# IfZ _tmp177 Goto _L10
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp172 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp173 from $t1 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp174 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp175 from $t4 to $fp-20
	  sw $t5, -24($fp)	# spill _tmp176 from $t5 to $fp-24
	  sw $t6, -28($fp)	# spill _tmp177 from $t6 to $fp-28
	  beqz $t6, _L10	# branch if _tmp177 is zero 
	# _tmp178 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp178
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L10
	  b _L10		# unconditional branch
  _L10:
	# _tmp179 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp180 = this + _tmp179
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp181 = *(_tmp180)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp182 = 8
	  li $t4, 8		# load constant value 8 into $t4
	# _tmp183 = this + _tmp182
	  add $t5, $t1, $t4	
	# _tmp184 = *(_tmp183)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp185 = *(_tmp184)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp186 = *(_tmp183)
	  lw $s0, 0($t5) 	# load with offset
	# _tmp187 = _tmp185 < _tmp181
	  slt $s1, $t7, $t3	
	# _tmp188 = _tmp185 == _tmp181
	  seq $s2, $t7, $t3	
	# _tmp189 = _tmp188 || _tmp187
	  or $s3, $s2, $s1	
	# _tmp190 = 0
	  li $s4, 0		# load constant value 0 into $s4
	# _tmp191 = _tmp181 < _tmp190
	  slt $s5, $t3, $s4	
	# _tmp192 = _tmp189 || _tmp191
	  or $s6, $s3, $s5	
	# IfZ _tmp192 Goto _L12
	# (save modified registers before flow of control change)
	  sw $t0, -36($fp)	# spill _tmp179 from $t0 to $fp-36
	  sw $t2, -40($fp)	# spill _tmp180 from $t2 to $fp-40
	  sw $t3, -44($fp)	# spill _tmp181 from $t3 to $fp-44
	  sw $t4, -48($fp)	# spill _tmp182 from $t4 to $fp-48
	  sw $t5, -52($fp)	# spill _tmp183 from $t5 to $fp-52
	  sw $t6, -56($fp)	# spill _tmp184 from $t6 to $fp-56
	  sw $t7, -60($fp)	# spill _tmp185 from $t7 to $fp-60
	  sw $s0, -64($fp)	# spill _tmp186 from $s0 to $fp-64
	  sw $s1, -68($fp)	# spill _tmp187 from $s1 to $fp-68
	  sw $s2, -72($fp)	# spill _tmp188 from $s2 to $fp-72
	  sw $s3, -76($fp)	# spill _tmp189 from $s3 to $fp-76
	  sw $s4, -80($fp)	# spill _tmp190 from $s4 to $fp-80
	  sw $s5, -84($fp)	# spill _tmp191 from $s5 to $fp-84
	  sw $s6, -88($fp)	# spill _tmp192 from $s6 to $fp-88
	  beqz $s6, _L12	# branch if _tmp192 is zero 
	# _tmp193 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp193
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -92($fp)	# spill _tmp193 from $t0 to $fp-92
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L12:
	# _tmp194 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp195 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp196 = _tmp195 + _tmp181
	  lw $t2, -44($fp)	# load _tmp181 from $fp-44 into $t2
	  add $t3, $t1, $t2	
	# _tmp197 = _tmp194 * _tmp196
	  mul $t4, $t0, $t3	
	# _tmp198 = _tmp186 + _tmp197
	  lw $t5, -64($fp)	# load _tmp186 from $fp-64 into $t5
	  add $t6, $t5, $t4	
	# _tmp199 = *(_tmp198)
	  lw $t7, 0($t6) 	# load with offset
	# result = _tmp199
	  move $s0, $t7		# copy value
	# _tmp200 = 1
	  li $s1, 1		# load constant value 1 into $s1
	# _tmp201 = 4
	  li $s2, 4		# load constant value 4 into $s2
	# _tmp202 = this + _tmp201
	  lw $s3, 4($fp)	# load this from $fp+4 into $s3
	  add $s4, $s3, $s2	
	# _tmp203 = *(_tmp202)
	  lw $s5, 0($s4) 	# load with offset
	# _tmp204 = _tmp203 + _tmp200
	  add $s6, $s5, $s1	
	# _tmp205 = 4
	  li $s7, 4		# load constant value 4 into $s7
	# _tmp206 = this + _tmp205
	  add $t8, $s3, $s7	
	# *(_tmp206) = _tmp204
	  sw $s6, 0($t8) 	# store with offset
	# Return result
	  move $v0, $s0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class BJDeck
	  .data
	  .align 2
	  BJDeck:		# label for class BJDeck vtable
	  .word _BJDeck.Init
	  .word _BJDeck.DealCard
	  .word _BJDeck.Shuffle
	  .word _BJDeck.NumCardsRemaining
	  .text
  _BJDeck.Init:
	# BeginFunc 248
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 248	# decrement sp to make space for locals/temps
	# _tmp207 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp208 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp209 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp210 = _tmp209 + _tmp207
	  add $t3, $t2, $t0	
	# _tmp211 = 4
	  li $t4, 4		# load constant value 4 into $t4
	# _tmp212 = _tmp211 * _tmp210
	  mul $t5, $t4, $t3	
	# _tmp213 = _tmp207 < _tmp208
	  slt $t6, $t0, $t1	
	# _tmp214 = _tmp207 == _tmp208
	  seq $t7, $t0, $t1	
	# _tmp215 = _tmp214 || _tmp213
	  or $s0, $t7, $t6	
	# IfZ _tmp215 Goto _L13
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp207 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp208 from $t1 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp209 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill _tmp210 from $t3 to $fp-20
	  sw $t4, -24($fp)	# spill _tmp211 from $t4 to $fp-24
	  sw $t5, -28($fp)	# spill _tmp212 from $t5 to $fp-28
	  sw $t6, -32($fp)	# spill _tmp213 from $t6 to $fp-32
	  sw $t7, -36($fp)	# spill _tmp214 from $t7 to $fp-36
	  sw $s0, -40($fp)	# spill _tmp215 from $s0 to $fp-40
	  beqz $s0, _L13	# branch if _tmp215 is zero 
	# _tmp216 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp216
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -44($fp)	# spill _tmp216 from $t0 to $fp-44
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L13:
	# PushParam _tmp212
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# load _tmp212 from $fp-28 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp217 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp217) = _tmp207
	  lw $t1, -8($fp)	# load _tmp207 from $fp-8 into $t1
	  sw $t1, 0($t0) 	# store with offset
	# _tmp218 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp219 = this + _tmp218
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# *(_tmp219) = _tmp217
	  sw $t0, 0($t4) 	# store with offset
	# _tmp220 = 0
	  li $t5, 0		# load constant value 0 into $t5
	# i = _tmp220
	  move $t6, $t5		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -48($fp)	# spill _tmp217 from $t0 to $fp-48
	  sw $t2, -52($fp)	# spill _tmp218 from $t2 to $fp-52
	  sw $t4, -56($fp)	# spill _tmp219 from $t4 to $fp-56
	  sw $t5, -60($fp)	# spill _tmp220 from $t5 to $fp-60
	  sw $t6, -64($fp)	# spill i from $t6 to $fp-64
  _L14:
	# _tmp221 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp222 = i < _tmp221
	  lw $t1, -64($fp)	# load i from $fp-64 into $t1
	  slt $t2, $t1, $t0	
	# IfZ _tmp222 Goto _L15
	# (save modified registers before flow of control change)
	  sw $t0, -68($fp)	# spill _tmp221 from $t0 to $fp-68
	  sw $t2, -72($fp)	# spill _tmp222 from $t2 to $fp-72
	  beqz $t2, _L15	# branch if _tmp222 is zero 
	# _tmp223 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp223
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp224 = LCall _Alloc
	# (save modified registers before flow of control change)
	  sw $t0, -76($fp)	# spill _tmp223 from $t0 to $fp-76
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp225 = Deck
	  la $t1, Deck	# load label
	# *(_tmp224) = _tmp225
	  sw $t1, 0($t0) 	# store with offset
	# _tmp226 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp227 = this + _tmp226
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# _tmp228 = *(_tmp227)
	  lw $t5, 0($t4) 	# load with offset
	# _tmp229 = *(_tmp228)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp230 = *(_tmp227)
	  lw $t7, 0($t4) 	# load with offset
	# _tmp231 = _tmp229 < i
	  lw $s0, -64($fp)	# load i from $fp-64 into $s0
	  slt $s1, $t6, $s0	
	# _tmp232 = _tmp229 == i
	  seq $s2, $t6, $s0	
	# _tmp233 = _tmp232 || _tmp231
	  or $s3, $s2, $s1	
	# _tmp234 = 0
	  li $s4, 0		# load constant value 0 into $s4
	# _tmp235 = i < _tmp234
	  slt $s5, $s0, $s4	
	# _tmp236 = _tmp233 || _tmp235
	  or $s6, $s3, $s5	
	# IfZ _tmp236 Goto _L16
	# (save modified registers before flow of control change)
	  sw $t0, -80($fp)	# spill _tmp224 from $t0 to $fp-80
	  sw $t1, -84($fp)	# spill _tmp225 from $t1 to $fp-84
	  sw $t2, -88($fp)	# spill _tmp226 from $t2 to $fp-88
	  sw $t4, -92($fp)	# spill _tmp227 from $t4 to $fp-92
	  sw $t5, -96($fp)	# spill _tmp228 from $t5 to $fp-96
	  sw $t6, -100($fp)	# spill _tmp229 from $t6 to $fp-100
	  sw $t7, -104($fp)	# spill _tmp230 from $t7 to $fp-104
	  sw $s1, -108($fp)	# spill _tmp231 from $s1 to $fp-108
	  sw $s2, -112($fp)	# spill _tmp232 from $s2 to $fp-112
	  sw $s3, -116($fp)	# spill _tmp233 from $s3 to $fp-116
	  sw $s4, -120($fp)	# spill _tmp234 from $s4 to $fp-120
	  sw $s5, -124($fp)	# spill _tmp235 from $s5 to $fp-124
	  sw $s6, -128($fp)	# spill _tmp236 from $s6 to $fp-128
	  beqz $s6, _L16	# branch if _tmp236 is zero 
	# _tmp237 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp237
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp237 from $t0 to $fp-132
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L16:
	# _tmp238 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp239 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp240 = _tmp239 + i
	  lw $t2, -64($fp)	# load i from $fp-64 into $t2
	  add $t3, $t1, $t2	
	# _tmp241 = _tmp238 * _tmp240
	  mul $t4, $t0, $t3	
	# _tmp242 = _tmp230 + _tmp241
	  lw $t5, -104($fp)	# load _tmp230 from $fp-104 into $t5
	  add $t6, $t5, $t4	
	# *(_tmp242) = _tmp224
	  lw $t7, -80($fp)	# load _tmp224 from $fp-80 into $t7
	  sw $t7, 0($t6) 	# store with offset
	# _tmp243 = 4
	  li $s0, 4		# load constant value 4 into $s0
	# _tmp244 = this + _tmp243
	  lw $s1, 4($fp)	# load this from $fp+4 into $s1
	  add $s2, $s1, $s0	
	# _tmp245 = *(_tmp244)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp246 = *(_tmp245)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp247 = *(_tmp244)
	  lw $s5, 0($s2) 	# load with offset
	# _tmp248 = _tmp246 < i
	  slt $s6, $s4, $t2	
	# _tmp249 = _tmp246 == i
	  seq $s7, $s4, $t2	
	# _tmp250 = _tmp249 || _tmp248
	  or $t8, $s7, $s6	
	# _tmp251 = 0
	  li $t9, 0		# load constant value 0 into $t9
	# _tmp252 = i < _tmp251
	  slt $t5, $t2, $t9	
	# _tmp253 = _tmp250 || _tmp252
	  or $t2, $t8, $t5	
	# IfZ _tmp253 Goto _L17
	# (save modified registers before flow of control change)
	  sw $t0, -136($fp)	# spill _tmp238 from $t0 to $fp-136
	  sw $t1, -140($fp)	# spill _tmp239 from $t1 to $fp-140
	  sw $t2, -196($fp)	# spill _tmp253 from $t2 to $fp-196
	  sw $t3, -144($fp)	# spill _tmp240 from $t3 to $fp-144
	  sw $t4, -148($fp)	# spill _tmp241 from $t4 to $fp-148
	  sw $t5, -192($fp)	# spill _tmp252 from $t5 to $fp-192
	  sw $t6, -152($fp)	# spill _tmp242 from $t6 to $fp-152
	  sw $s0, -156($fp)	# spill _tmp243 from $s0 to $fp-156
	  sw $s2, -160($fp)	# spill _tmp244 from $s2 to $fp-160
	  sw $s3, -164($fp)	# spill _tmp245 from $s3 to $fp-164
	  sw $s4, -168($fp)	# spill _tmp246 from $s4 to $fp-168
	  sw $s5, -172($fp)	# spill _tmp247 from $s5 to $fp-172
	  sw $s6, -176($fp)	# spill _tmp248 from $s6 to $fp-176
	  sw $s7, -180($fp)	# spill _tmp249 from $s7 to $fp-180
	  sw $t8, -184($fp)	# spill _tmp250 from $t8 to $fp-184
	  sw $t9, -188($fp)	# spill _tmp251 from $t9 to $fp-188
	  beqz $t2, _L17	# branch if _tmp253 is zero 
	# _tmp254 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp254
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -200($fp)	# spill _tmp254 from $t0 to $fp-200
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L17:
	# _tmp255 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp256 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp257 = _tmp256 + i
	  lw $t2, -64($fp)	# load i from $fp-64 into $t2
	  add $t3, $t1, $t2	
	# _tmp258 = _tmp255 * _tmp257
	  mul $t4, $t0, $t3	
	# _tmp259 = _tmp247 + _tmp258
	  lw $t5, -172($fp)	# load _tmp247 from $fp-172 into $t5
	  add $t6, $t5, $t4	
	# _tmp260 = *(_tmp259)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp261 = *(_tmp260)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp262 = 0
	  li $s1, 0		# load constant value 0 into $s1
	# _tmp263 = _tmp262 + _tmp261
	  add $s2, $s1, $s0	
	# _tmp264 = *(_tmp263)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp265 = *(_tmp259)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp265
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# ACall _tmp264
	# (save modified registers before flow of control change)
	  sw $t0, -204($fp)	# spill _tmp255 from $t0 to $fp-204
	  sw $t1, -208($fp)	# spill _tmp256 from $t1 to $fp-208
	  sw $t3, -212($fp)	# spill _tmp257 from $t3 to $fp-212
	  sw $t4, -216($fp)	# spill _tmp258 from $t4 to $fp-216
	  sw $t6, -220($fp)	# spill _tmp259 from $t6 to $fp-220
	  sw $t7, -224($fp)	# spill _tmp260 from $t7 to $fp-224
	  sw $s0, -228($fp)	# spill _tmp261 from $s0 to $fp-228
	  sw $s1, -232($fp)	# spill _tmp262 from $s1 to $fp-232
	  sw $s2, -236($fp)	# spill _tmp263 from $s2 to $fp-236
	  sw $s3, -240($fp)	# spill _tmp264 from $s3 to $fp-240
	  sw $s4, -244($fp)	# spill _tmp265 from $s4 to $fp-244
	  jalr $s3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp266 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp267 = i + _tmp266
	  lw $t1, -64($fp)	# load i from $fp-64 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp267
	  move $t1, $t2		# copy value
	# Goto _L14
	# (save modified registers before flow of control change)
	  sw $t0, -248($fp)	# spill _tmp266 from $t0 to $fp-248
	  sw $t1, -64($fp)	# spill i from $t1 to $fp-64
	  sw $t2, -252($fp)	# spill _tmp267 from $t2 to $fp-252
	  b _L14		# unconditional branch
  _L15:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.DealCard:
	# BeginFunc 228
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 228	# decrement sp to make space for locals/temps
	# _tmp268 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# c = _tmp268
	  move $t1, $t0		# copy value
	# _tmp269 = 52
	  li $t2, 52		# load constant value 52 into $t2
	# _tmp270 = 8
	  li $t3, 8		# load constant value 8 into $t3
	# _tmp271 = _tmp270 * _tmp269
	  mul $t4, $t3, $t2	
	# _tmp272 = 8
	  li $t5, 8		# load constant value 8 into $t5
	# _tmp273 = this + _tmp272
	  lw $t6, 4($fp)	# load this from $fp+4 into $t6
	  add $t7, $t6, $t5	
	# _tmp274 = _tmp271 < _tmp273
	  slt $s0, $t4, $t7	
	# _tmp275 = _tmp271 == _tmp273
	  seq $s1, $t4, $t7	
	# _tmp276 = _tmp274 || _tmp275
	  or $s2, $s0, $s1	
	# IfZ _tmp276 Goto _L18
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp268 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill c from $t1 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp269 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill _tmp270 from $t3 to $fp-20
	  sw $t4, -24($fp)	# spill _tmp271 from $t4 to $fp-24
	  sw $t5, -28($fp)	# spill _tmp272 from $t5 to $fp-28
	  sw $t7, -32($fp)	# spill _tmp273 from $t7 to $fp-32
	  sw $s0, -36($fp)	# spill _tmp274 from $s0 to $fp-36
	  sw $s1, -40($fp)	# spill _tmp275 from $s1 to $fp-40
	  sw $s2, -44($fp)	# spill _tmp276 from $s2 to $fp-44
	  beqz $s2, _L18	# branch if _tmp276 is zero 
	# _tmp277 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# Return _tmp277
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L18
	  b _L18		# unconditional branch
  _L18:
  _L20:
	# _tmp278 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp279 = c == _tmp278
	  lw $t1, -12($fp)	# load c from $fp-12 into $t1
	  seq $t2, $t1, $t0	
	# IfZ _tmp279 Goto _L21
	# (save modified registers before flow of control change)
	  sw $t0, -52($fp)	# spill _tmp278 from $t0 to $fp-52
	  sw $t2, -56($fp)	# spill _tmp279 from $t2 to $fp-56
	  beqz $t2, _L21	# branch if _tmp279 is zero 
	# _tmp280 = *(gRnd)
	  lw $t0, -188($fp)	# load gRnd from $fp-188 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp281 = 8
	  li $t2, 8		# load constant value 8 into $t2
	# _tmp282 = _tmp281 + _tmp280
	  add $t3, $t2, $t1	
	# _tmp283 = *(_tmp282)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp284 = 8
	  li $t5, 8		# load constant value 8 into $t5
	# PushParam _tmp284
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp285 = ACall _tmp283
	# (save modified registers before flow of control change)
	  sw $t1, -60($fp)	# spill _tmp280 from $t1 to $fp-60
	  sw $t2, -64($fp)	# spill _tmp281 from $t2 to $fp-64
	  sw $t3, -68($fp)	# spill _tmp282 from $t3 to $fp-68
	  sw $t4, -72($fp)	# spill _tmp283 from $t4 to $fp-72
	  sw $t5, -76($fp)	# spill _tmp284 from $t5 to $fp-76
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# d = _tmp285
	  move $t1, $t0		# copy value
	# _tmp286 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp287 = this + _tmp286
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# _tmp288 = *(_tmp287)
	  lw $t5, 0($t4) 	# load with offset
	# _tmp289 = *(_tmp288)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp290 = *(_tmp287)
	  lw $t7, 0($t4) 	# load with offset
	# _tmp291 = _tmp289 < d
	  slt $s0, $t6, $t1	
	# _tmp292 = _tmp289 == d
	  seq $s1, $t6, $t1	
	# _tmp293 = _tmp292 || _tmp291
	  or $s2, $s1, $s0	
	# _tmp294 = 0
	  li $s3, 0		# load constant value 0 into $s3
	# _tmp295 = d < _tmp294
	  slt $s4, $t1, $s3	
	# _tmp296 = _tmp293 || _tmp295
	  or $s5, $s2, $s4	
	# IfZ _tmp296 Goto _L22
	# (save modified registers before flow of control change)
	  sw $t0, -80($fp)	# spill _tmp285 from $t0 to $fp-80
	  sw $t1, -84($fp)	# spill d from $t1 to $fp-84
	  sw $t2, -88($fp)	# spill _tmp286 from $t2 to $fp-88
	  sw $t4, -92($fp)	# spill _tmp287 from $t4 to $fp-92
	  sw $t5, -96($fp)	# spill _tmp288 from $t5 to $fp-96
	  sw $t6, -100($fp)	# spill _tmp289 from $t6 to $fp-100
	  sw $t7, -104($fp)	# spill _tmp290 from $t7 to $fp-104
	  sw $s0, -108($fp)	# spill _tmp291 from $s0 to $fp-108
	  sw $s1, -112($fp)	# spill _tmp292 from $s1 to $fp-112
	  sw $s2, -116($fp)	# spill _tmp293 from $s2 to $fp-116
	  sw $s3, -120($fp)	# spill _tmp294 from $s3 to $fp-120
	  sw $s4, -124($fp)	# spill _tmp295 from $s4 to $fp-124
	  sw $s5, -128($fp)	# spill _tmp296 from $s5 to $fp-128
	  beqz $s5, _L22	# branch if _tmp296 is zero 
	# _tmp297 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp297
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp297 from $t0 to $fp-132
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L22:
	# _tmp298 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp299 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp300 = _tmp299 + d
	  lw $t2, -84($fp)	# load d from $fp-84 into $t2
	  add $t3, $t1, $t2	
	# _tmp301 = _tmp298 * _tmp300
	  mul $t4, $t0, $t3	
	# _tmp302 = _tmp290 + _tmp301
	  lw $t5, -104($fp)	# load _tmp290 from $fp-104 into $t5
	  add $t6, $t5, $t4	
	# _tmp303 = *(_tmp302)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp304 = *(_tmp303)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp305 = 8
	  li $s1, 8		# load constant value 8 into $s1
	# _tmp306 = _tmp305 + _tmp304
	  add $s2, $s1, $s0	
	# _tmp307 = *(_tmp306)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp308 = *(_tmp302)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp308
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# _tmp309 = ACall _tmp307
	# (save modified registers before flow of control change)
	  sw $t0, -136($fp)	# spill _tmp298 from $t0 to $fp-136
	  sw $t1, -140($fp)	# spill _tmp299 from $t1 to $fp-140
	  sw $t3, -144($fp)	# spill _tmp300 from $t3 to $fp-144
	  sw $t4, -148($fp)	# spill _tmp301 from $t4 to $fp-148
	  sw $t6, -152($fp)	# spill _tmp302 from $t6 to $fp-152
	  sw $t7, -156($fp)	# spill _tmp303 from $t7 to $fp-156
	  sw $s0, -160($fp)	# spill _tmp304 from $s0 to $fp-160
	  sw $s1, -164($fp)	# spill _tmp305 from $s1 to $fp-164
	  sw $s2, -168($fp)	# spill _tmp306 from $s2 to $fp-168
	  sw $s3, -172($fp)	# spill _tmp307 from $s3 to $fp-172
	  sw $s4, -176($fp)	# spill _tmp308 from $s4 to $fp-176
	  jalr $s3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# c = _tmp309
	  move $t1, $t0		# copy value
	# Goto _L20
	# (save modified registers before flow of control change)
	  sw $t0, -180($fp)	# spill _tmp309 from $t0 to $fp-180
	  sw $t1, -12($fp)	# spill c from $t1 to $fp-12
	  b _L20		# unconditional branch
  _L21:
	# _tmp310 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp311 = _tmp310 < c
	  lw $t1, -12($fp)	# load c from $fp-12 into $t1
	  slt $t2, $t0, $t1	
	# IfZ _tmp311 Goto _L24
	# (save modified registers before flow of control change)
	  sw $t0, -184($fp)	# spill _tmp310 from $t0 to $fp-184
	  sw $t2, -188($fp)	# spill _tmp311 from $t2 to $fp-188
	  beqz $t2, _L24	# branch if _tmp311 is zero 
	# _tmp312 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# c = _tmp312
	  move $t1, $t0		# copy value
	# Goto _L23
	# (save modified registers before flow of control change)
	  sw $t0, -192($fp)	# spill _tmp312 from $t0 to $fp-192
	  sw $t1, -12($fp)	# spill c from $t1 to $fp-12
	  b _L23		# unconditional branch
  _L24:
	# _tmp313 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp314 = c == _tmp313
	  lw $t1, -12($fp)	# load c from $fp-12 into $t1
	  seq $t2, $t1, $t0	
	# IfZ _tmp314 Goto _L25
	# (save modified registers before flow of control change)
	  sw $t0, -196($fp)	# spill _tmp313 from $t0 to $fp-196
	  sw $t2, -200($fp)	# spill _tmp314 from $t2 to $fp-200
	  beqz $t2, _L25	# branch if _tmp314 is zero 
	# _tmp315 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# c = _tmp315
	  move $t1, $t0		# copy value
	# Goto _L25
	# (save modified registers before flow of control change)
	  sw $t0, -204($fp)	# spill _tmp315 from $t0 to $fp-204
	  sw $t1, -12($fp)	# spill c from $t1 to $fp-12
	  b _L25		# unconditional branch
  _L25:
  _L23:
	# _tmp316 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp317 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp318 = this + _tmp317
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp319 = *(_tmp318)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp320 = _tmp319 + _tmp316
	  add $t5, $t4, $t0	
	# _tmp321 = 8
	  li $t6, 8		# load constant value 8 into $t6
	# _tmp322 = this + _tmp321
	  add $t7, $t2, $t6	
	# *(_tmp322) = _tmp320
	  sw $t5, 0($t7) 	# store with offset
	# Return c
	  lw $s0, -12($fp)	# load c from $fp-12 into $s0
	  move $v0, $s0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.Shuffle:
	# BeginFunc 136
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 136	# decrement sp to make space for locals/temps
	# _tmp323 = "Shuffling..."
	  .data			# create string constant marked with label
	  _string12: .asciiz "Shuffling..."
	  .text
	  la $t0, _string12	# load label
	# PushParam _tmp323
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp323 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp324 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp324
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp324 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
  _L27:
	# _tmp325 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp326 = i < _tmp325
	  lw $t1, -16($fp)	# load i from $fp-16 into $t1
	  slt $t2, $t1, $t0	
	# IfZ _tmp326 Goto _L28
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp325 from $t0 to $fp-20
	  sw $t2, -24($fp)	# spill _tmp326 from $t2 to $fp-24
	  beqz $t2, _L28	# branch if _tmp326 is zero 
	# _tmp327 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp328 = this + _tmp327
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp329 = *(_tmp328)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp330 = *(_tmp329)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp331 = *(_tmp328)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp332 = _tmp330 < i
	  lw $t6, -16($fp)	# load i from $fp-16 into $t6
	  slt $t7, $t4, $t6	
	# _tmp333 = _tmp330 == i
	  seq $s0, $t4, $t6	
	# _tmp334 = _tmp333 || _tmp332
	  or $s1, $s0, $t7	
	# _tmp335 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp336 = i < _tmp335
	  slt $s3, $t6, $s2	
	# _tmp337 = _tmp334 || _tmp336
	  or $s4, $s1, $s3	
	# IfZ _tmp337 Goto _L29
	# (save modified registers before flow of control change)
	  sw $t0, -28($fp)	# spill _tmp327 from $t0 to $fp-28
	  sw $t2, -32($fp)	# spill _tmp328 from $t2 to $fp-32
	  sw $t3, -36($fp)	# spill _tmp329 from $t3 to $fp-36
	  sw $t4, -40($fp)	# spill _tmp330 from $t4 to $fp-40
	  sw $t5, -44($fp)	# spill _tmp331 from $t5 to $fp-44
	  sw $t7, -48($fp)	# spill _tmp332 from $t7 to $fp-48
	  sw $s0, -52($fp)	# spill _tmp333 from $s0 to $fp-52
	  sw $s1, -56($fp)	# spill _tmp334 from $s1 to $fp-56
	  sw $s2, -60($fp)	# spill _tmp335 from $s2 to $fp-60
	  sw $s3, -64($fp)	# spill _tmp336 from $s3 to $fp-64
	  sw $s4, -68($fp)	# spill _tmp337 from $s4 to $fp-68
	  beqz $s4, _L29	# branch if _tmp337 is zero 
	# _tmp338 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string13	# load label
	# PushParam _tmp338
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -72($fp)	# spill _tmp338 from $t0 to $fp-72
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L29:
	# _tmp339 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp340 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp341 = _tmp340 + i
	  lw $t2, -16($fp)	# load i from $fp-16 into $t2
	  add $t3, $t1, $t2	
	# _tmp342 = _tmp339 * _tmp341
	  mul $t4, $t0, $t3	
	# _tmp343 = _tmp331 + _tmp342
	  lw $t5, -44($fp)	# load _tmp331 from $fp-44 into $t5
	  add $t6, $t5, $t4	
	# _tmp344 = *(_tmp343)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp345 = *(_tmp344)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp346 = 4
	  li $s1, 4		# load constant value 4 into $s1
	# _tmp347 = _tmp346 + _tmp345
	  add $s2, $s1, $s0	
	# _tmp348 = *(_tmp347)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp349 = *(_tmp343)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp349
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# ACall _tmp348
	# (save modified registers before flow of control change)
	  sw $t0, -76($fp)	# spill _tmp339 from $t0 to $fp-76
	  sw $t1, -80($fp)	# spill _tmp340 from $t1 to $fp-80
	  sw $t3, -84($fp)	# spill _tmp341 from $t3 to $fp-84
	  sw $t4, -88($fp)	# spill _tmp342 from $t4 to $fp-88
	  sw $t6, -92($fp)	# spill _tmp343 from $t6 to $fp-92
	  sw $t7, -96($fp)	# spill _tmp344 from $t7 to $fp-96
	  sw $s0, -100($fp)	# spill _tmp345 from $s0 to $fp-100
	  sw $s1, -104($fp)	# spill _tmp346 from $s1 to $fp-104
	  sw $s2, -108($fp)	# spill _tmp347 from $s2 to $fp-108
	  sw $s3, -112($fp)	# spill _tmp348 from $s3 to $fp-112
	  sw $s4, -116($fp)	# spill _tmp349 from $s4 to $fp-116
	  jalr $s3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp350 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp351 = i + _tmp350
	  lw $t1, -16($fp)	# load i from $fp-16 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp351
	  move $t1, $t2		# copy value
	# Goto _L27
	# (save modified registers before flow of control change)
	  sw $t0, -120($fp)	# spill _tmp350 from $t0 to $fp-120
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
	  sw $t2, -124($fp)	# spill _tmp351 from $t2 to $fp-124
	  b _L27		# unconditional branch
  _L28:
	# _tmp352 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp353 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp354 = this + _tmp353
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp354) = _tmp352
	  sw $t0, 0($t3) 	# store with offset
	# _tmp355 = "done.\n"
	  .data			# create string constant marked with label
	  _string14: .asciiz "done.\n"
	  .text
	  la $t4, _string14	# load label
	# PushParam _tmp355
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -128($fp)	# spill _tmp352 from $t0 to $fp-128
	  sw $t1, -132($fp)	# spill _tmp353 from $t1 to $fp-132
	  sw $t3, -136($fp)	# spill _tmp354 from $t3 to $fp-136
	  sw $t4, -140($fp)	# spill _tmp355 from $t4 to $fp-140
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.NumCardsRemaining:
	# BeginFunc 24
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 24	# decrement sp to make space for locals/temps
	# _tmp356 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp357 = this + _tmp356
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp358 = 52
	  li $t3, 52		# load constant value 52 into $t3
	# _tmp359 = 8
	  li $t4, 8		# load constant value 8 into $t4
	# _tmp360 = _tmp359 * _tmp358
	  mul $t5, $t4, $t3	
	# _tmp361 = _tmp360 - _tmp357
	  sub $t6, $t5, $t2	
	# Return _tmp361
	  move $v0, $t6		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Player
	  .data
	  .align 2
	  Player:		# label for class Player vtable
	  .word _Player.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Player.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _Player.Init:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# _tmp362 = 1000
	  li $t0, 1000		# load constant value 1000 into $t0
	# _tmp363 = 20
	  li $t1, 20		# load constant value 20 into $t1
	# _tmp364 = this + _tmp363
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp364) = _tmp362
	  sw $t0, 0($t3) 	# store with offset
	# _tmp365 = "What is the name of player #"
	  .data			# create string constant marked with label
	  _string15: .asciiz "What is the name of player #"
	  .text
	  la $t4, _string15	# load label
	# PushParam _tmp365
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp362 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp363 from $t1 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp364 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp365 from $t4 to $fp-20
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam num
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# load num from $fp+8 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp366 = "? "
	  .data			# create string constant marked with label
	  _string16: .asciiz "? "
	  .text
	  la $t0, _string16	# load label
	# PushParam _tmp366
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp366 from $t0 to $fp-24
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp367 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# _tmp368 = 24
	  li $t1, 24		# load constant value 24 into $t1
	# _tmp369 = this + _tmp368
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp369) = _tmp367
	  sw $t0, 0($t3) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Hit:
	# BeginFunc 224
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 224	# decrement sp to make space for locals/temps
	# _tmp370 = *(deck)
	  lw $t0, 8($fp)	# load deck from $fp+8 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp371 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp372 = _tmp371 + _tmp370
	  add $t3, $t2, $t1	
	# _tmp373 = *(_tmp372)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp374 = ACall _tmp373
	# (save modified registers before flow of control change)
	  sw $t1, -8($fp)	# spill _tmp370 from $t1 to $fp-8
	  sw $t2, -12($fp)	# spill _tmp371 from $t2 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp372 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp373 from $t4 to $fp-20
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# card = _tmp374
	  move $t1, $t0		# copy value
	# _tmp375 = 24
	  li $t2, 24		# load constant value 24 into $t2
	# _tmp376 = this + _tmp375
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# _tmp377 = *(_tmp376)
	  lw $t5, 0($t4) 	# load with offset
	# PushParam _tmp377
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp374 from $t0 to $fp-24
	  sw $t1, -28($fp)	# spill card from $t1 to $fp-28
	  sw $t2, -32($fp)	# spill _tmp375 from $t2 to $fp-32
	  sw $t4, -36($fp)	# spill _tmp376 from $t4 to $fp-36
	  sw $t5, -40($fp)	# spill _tmp377 from $t5 to $fp-40
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp378 = " was dealt a "
	  .data			# create string constant marked with label
	  _string17: .asciiz " was dealt a "
	  .text
	  la $t0, _string17	# load label
	# PushParam _tmp378
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -44($fp)	# spill _tmp378 from $t0 to $fp-44
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam card
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -28($fp)	# load card from $fp-28 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp379 = ".\n"
	  .data			# create string constant marked with label
	  _string18: .asciiz ".\n"
	  .text
	  la $t0, _string18	# load label
	# PushParam _tmp379
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -48($fp)	# spill _tmp379 from $t0 to $fp-48
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp380 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp381 = this + _tmp380
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp382 = *(_tmp381)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp383 = _tmp382 + card
	  lw $t4, -28($fp)	# load card from $fp-28 into $t4
	  add $t5, $t3, $t4	
	# _tmp384 = 4
	  li $t6, 4		# load constant value 4 into $t6
	# _tmp385 = this + _tmp384
	  add $t7, $t1, $t6	
	# *(_tmp385) = _tmp383
	  sw $t5, 0($t7) 	# store with offset
	# _tmp386 = 1
	  li $s0, 1		# load constant value 1 into $s0
	# _tmp387 = 12
	  li $s1, 12		# load constant value 12 into $s1
	# _tmp388 = this + _tmp387
	  add $s2, $t1, $s1	
	# _tmp389 = *(_tmp388)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp390 = _tmp389 + _tmp386
	  add $s4, $s3, $s0	
	# _tmp391 = 12
	  li $s5, 12		# load constant value 12 into $s5
	# _tmp392 = this + _tmp391
	  add $s6, $t1, $s5	
	# *(_tmp392) = _tmp390
	  sw $s4, 0($s6) 	# store with offset
	# _tmp393 = 11
	  li $s7, 11		# load constant value 11 into $s7
	# _tmp394 = card == _tmp393
	  seq $t8, $t4, $s7	
	# IfZ _tmp394 Goto _L30
	# (save modified registers before flow of control change)
	  sw $t0, -52($fp)	# spill _tmp380 from $t0 to $fp-52
	  sw $t2, -56($fp)	# spill _tmp381 from $t2 to $fp-56
	  sw $t3, -60($fp)	# spill _tmp382 from $t3 to $fp-60
	  sw $t5, -64($fp)	# spill _tmp383 from $t5 to $fp-64
	  sw $t6, -68($fp)	# spill _tmp384 from $t6 to $fp-68
	  sw $t7, -72($fp)	# spill _tmp385 from $t7 to $fp-72
	  sw $s0, -76($fp)	# spill _tmp386 from $s0 to $fp-76
	  sw $s1, -80($fp)	# spill _tmp387 from $s1 to $fp-80
	  sw $s2, -84($fp)	# spill _tmp388 from $s2 to $fp-84
	  sw $s3, -88($fp)	# spill _tmp389 from $s3 to $fp-88
	  sw $s4, -92($fp)	# spill _tmp390 from $s4 to $fp-92
	  sw $s5, -96($fp)	# spill _tmp391 from $s5 to $fp-96
	  sw $s6, -100($fp)	# spill _tmp392 from $s6 to $fp-100
	  sw $s7, -104($fp)	# spill _tmp393 from $s7 to $fp-104
	  sw $t8, -108($fp)	# spill _tmp394 from $t8 to $fp-108
	  beqz $t8, _L30	# branch if _tmp394 is zero 
	# _tmp395 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp396 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp397 = this + _tmp396
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp398 = *(_tmp397)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp399 = _tmp398 + _tmp395
	  add $t5, $t4, $t0	
	# _tmp400 = 8
	  li $t6, 8		# load constant value 8 into $t6
	# _tmp401 = this + _tmp400
	  add $t7, $t2, $t6	
	# *(_tmp401) = _tmp399
	  sw $t5, 0($t7) 	# store with offset
	# Goto _L30
	# (save modified registers before flow of control change)
	  sw $t0, -112($fp)	# spill _tmp395 from $t0 to $fp-112
	  sw $t1, -116($fp)	# spill _tmp396 from $t1 to $fp-116
	  sw $t3, -120($fp)	# spill _tmp397 from $t3 to $fp-120
	  sw $t4, -124($fp)	# spill _tmp398 from $t4 to $fp-124
	  sw $t5, -128($fp)	# spill _tmp399 from $t5 to $fp-128
	  sw $t6, -132($fp)	# spill _tmp400 from $t6 to $fp-132
	  sw $t7, -136($fp)	# spill _tmp401 from $t7 to $fp-136
	  b _L30		# unconditional branch
  _L30:
  _L32:
	# _tmp402 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp403 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp404 = this + _tmp403
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp405 = _tmp402 < _tmp404
	  slt $t4, $t0, $t3	
	# _tmp406 = 21
	  li $t5, 21		# load constant value 21 into $t5
	# _tmp407 = 4
	  li $t6, 4		# load constant value 4 into $t6
	# _tmp408 = this + _tmp407
	  add $t7, $t2, $t6	
	# _tmp409 = _tmp406 < _tmp408
	  slt $s0, $t5, $t7	
	# _tmp410 = _tmp405 && _tmp409
	  and $s1, $t4, $s0	
	# IfZ _tmp410 Goto _L33
	# (save modified registers before flow of control change)
	  sw $t0, -140($fp)	# spill _tmp402 from $t0 to $fp-140
	  sw $t1, -144($fp)	# spill _tmp403 from $t1 to $fp-144
	  sw $t3, -148($fp)	# spill _tmp404 from $t3 to $fp-148
	  sw $t4, -152($fp)	# spill _tmp405 from $t4 to $fp-152
	  sw $t5, -156($fp)	# spill _tmp406 from $t5 to $fp-156
	  sw $t6, -160($fp)	# spill _tmp407 from $t6 to $fp-160
	  sw $t7, -164($fp)	# spill _tmp408 from $t7 to $fp-164
	  sw $s0, -168($fp)	# spill _tmp409 from $s0 to $fp-168
	  sw $s1, -172($fp)	# spill _tmp410 from $s1 to $fp-172
	  beqz $s1, _L33	# branch if _tmp410 is zero 
	# _tmp411 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp412 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp413 = this + _tmp412
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp414 = *(_tmp413)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp415 = _tmp414 - _tmp411
	  sub $t5, $t4, $t0	
	# _tmp416 = 4
	  li $t6, 4		# load constant value 4 into $t6
	# _tmp417 = this + _tmp416
	  add $t7, $t2, $t6	
	# *(_tmp417) = _tmp415
	  sw $t5, 0($t7) 	# store with offset
	# _tmp418 = 1
	  li $s0, 1		# load constant value 1 into $s0
	# _tmp419 = 8
	  li $s1, 8		# load constant value 8 into $s1
	# _tmp420 = this + _tmp419
	  add $s2, $t2, $s1	
	# _tmp421 = *(_tmp420)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp422 = _tmp421 - _tmp418
	  sub $s4, $s3, $s0	
	# _tmp423 = 8
	  li $s5, 8		# load constant value 8 into $s5
	# _tmp424 = this + _tmp423
	  add $s6, $t2, $s5	
	# *(_tmp424) = _tmp422
	  sw $s4, 0($s6) 	# store with offset
	# Goto _L32
	# (save modified registers before flow of control change)
	  sw $t0, -176($fp)	# spill _tmp411 from $t0 to $fp-176
	  sw $t1, -180($fp)	# spill _tmp412 from $t1 to $fp-180
	  sw $t3, -184($fp)	# spill _tmp413 from $t3 to $fp-184
	  sw $t4, -188($fp)	# spill _tmp414 from $t4 to $fp-188
	  sw $t5, -192($fp)	# spill _tmp415 from $t5 to $fp-192
	  sw $t6, -196($fp)	# spill _tmp416 from $t6 to $fp-196
	  sw $t7, -200($fp)	# spill _tmp417 from $t7 to $fp-200
	  sw $s0, -204($fp)	# spill _tmp418 from $s0 to $fp-204
	  sw $s1, -208($fp)	# spill _tmp419 from $s1 to $fp-208
	  sw $s2, -212($fp)	# spill _tmp420 from $s2 to $fp-212
	  sw $s3, -216($fp)	# spill _tmp421 from $s3 to $fp-216
	  sw $s4, -220($fp)	# spill _tmp422 from $s4 to $fp-220
	  sw $s5, -224($fp)	# spill _tmp423 from $s5 to $fp-224
	  sw $s6, -228($fp)	# spill _tmp424 from $s6 to $fp-228
	  b _L32		# unconditional branch
  _L33:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.DoubleDown:
	# BeginFunc 172
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 172	# decrement sp to make space for locals/temps
	# _tmp425 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# _tmp426 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp427 = this + _tmp426
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp428 = *(_tmp427)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp429 = _tmp428 == _tmp425
	  seq $t5, $t4, $t0	
	# _tmp430 = -1
	  li $t6, -1		# load constant value -1 into $t6
	# _tmp431 = 1
	  li $t7, 1		# load constant value 1 into $t7
	# _tmp432 = _tmp429 - _tmp431
	  sub $s0, $t5, $t7	
	# _tmp433 = _tmp432 * _tmp430
	  mul $s1, $s0, $t6	
	# _tmp434 = 10
	  li $s2, 10		# load constant value 10 into $s2
	# _tmp435 = 4
	  li $s3, 4		# load constant value 4 into $s3
	# _tmp436 = this + _tmp435
	  add $s4, $t2, $s3	
	# _tmp437 = *(_tmp436)
	  lw $s5, 0($s4) 	# load with offset
	# _tmp438 = _tmp437 == _tmp434
	  seq $s6, $s5, $s2	
	# _tmp439 = -1
	  li $s7, -1		# load constant value -1 into $s7
	# _tmp440 = 1
	  li $t8, 1		# load constant value 1 into $t8
	# _tmp441 = _tmp438 - _tmp440
	  sub $t9, $s6, $t8	
	# _tmp442 = _tmp441 * _tmp439
	  mul $t2, $t9, $s7	
	# _tmp443 = _tmp433 && _tmp442
	  sw $s4, -52($fp)	# spill _tmp436 from $s4 to $fp-52
	  and $s4, $s1, $t2	
	# IfZ _tmp443 Goto _L34
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp425 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp426 from $t1 to $fp-12
	  sw $t2, -76($fp)	# spill _tmp442 from $t2 to $fp-76
	  sw $t3, -16($fp)	# spill _tmp427 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp428 from $t4 to $fp-20
	  sw $t5, -24($fp)	# spill _tmp429 from $t5 to $fp-24
	  sw $t6, -28($fp)	# spill _tmp430 from $t6 to $fp-28
	  sw $t7, -32($fp)	# spill _tmp431 from $t7 to $fp-32
	  sw $s0, -36($fp)	# spill _tmp432 from $s0 to $fp-36
	  sw $s1, -40($fp)	# spill _tmp433 from $s1 to $fp-40
	  sw $s2, -44($fp)	# spill _tmp434 from $s2 to $fp-44
	  sw $s3, -48($fp)	# spill _tmp435 from $s3 to $fp-48
	  sw $s4, -80($fp)	# spill _tmp443 from $s4 to $fp-80
	  sw $s5, -56($fp)	# spill _tmp437 from $s5 to $fp-56
	  sw $s6, -60($fp)	# spill _tmp438 from $s6 to $fp-60
	  sw $s7, -64($fp)	# spill _tmp439 from $s7 to $fp-64
	  sw $t8, -68($fp)	# spill _tmp440 from $t8 to $fp-68
	  sw $t9, -72($fp)	# spill _tmp441 from $t9 to $fp-72
	  beqz $s4, _L34	# branch if _tmp443 is zero 
	# _tmp444 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp444
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L34
	  b _L34		# unconditional branch
  _L34:
	# _tmp445 = "Would you like to double down?"
	  .data			# create string constant marked with label
	  _string19: .asciiz "Would you like to double down?"
	  .text
	  la $t0, _string19	# load label
	# PushParam _tmp445
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp446 = LCall _GetYesOrNo
	# (save modified registers before flow of control change)
	  sw $t0, -88($fp)	# spill _tmp445 from $t0 to $fp-88
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp446 Goto _L36
	# (save modified registers before flow of control change)
	  sw $t0, -92($fp)	# spill _tmp446 from $t0 to $fp-92
	  beqz $t0, _L36	# branch if _tmp446 is zero 
	# _tmp447 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# _tmp448 = 16
	  li $t1, 16		# load constant value 16 into $t1
	# _tmp449 = this + _tmp448
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp450 = *(_tmp449)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp451 = _tmp450 * _tmp447
	  mul $t5, $t4, $t0	
	# _tmp452 = 16
	  li $t6, 16		# load constant value 16 into $t6
	# _tmp453 = this + _tmp452
	  add $t7, $t2, $t6	
	# *(_tmp453) = _tmp451
	  sw $t5, 0($t7) 	# store with offset
	# _tmp454 = *(this)
	  lw $s0, 0($t2) 	# load with offset
	# _tmp455 = 4
	  li $s1, 4		# load constant value 4 into $s1
	# _tmp456 = _tmp455 + _tmp454
	  add $s2, $s1, $s0	
	# _tmp457 = *(_tmp456)
	  lw $s3, 0($s2) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $s4, 8($fp)	# load deck from $fp+8 into $s4
	  sw $s4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp457
	# (save modified registers before flow of control change)
	  sw $t0, -96($fp)	# spill _tmp447 from $t0 to $fp-96
	  sw $t1, -100($fp)	# spill _tmp448 from $t1 to $fp-100
	  sw $t3, -104($fp)	# spill _tmp449 from $t3 to $fp-104
	  sw $t4, -108($fp)	# spill _tmp450 from $t4 to $fp-108
	  sw $t5, -112($fp)	# spill _tmp451 from $t5 to $fp-112
	  sw $t6, -116($fp)	# spill _tmp452 from $t6 to $fp-116
	  sw $t7, -120($fp)	# spill _tmp453 from $t7 to $fp-120
	  sw $s0, -124($fp)	# spill _tmp454 from $s0 to $fp-124
	  sw $s1, -128($fp)	# spill _tmp455 from $s1 to $fp-128
	  sw $s2, -132($fp)	# spill _tmp456 from $s2 to $fp-132
	  sw $s3, -136($fp)	# spill _tmp457 from $s3 to $fp-136
	  jalr $s3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp458 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp459 = this + _tmp458
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp460 = *(_tmp459)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp460
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -140($fp)	# spill _tmp458 from $t0 to $fp-140
	  sw $t2, -144($fp)	# spill _tmp459 from $t2 to $fp-144
	  sw $t3, -148($fp)	# spill _tmp460 from $t3 to $fp-148
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp461 = ", your total is "
	  .data			# create string constant marked with label
	  _string20: .asciiz ", your total is "
	  .text
	  la $t0, _string20	# load label
	# PushParam _tmp461
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -152($fp)	# spill _tmp461 from $t0 to $fp-152
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp462 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp463 = this + _tmp462
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp464 = *(_tmp463)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp464
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -156($fp)	# spill _tmp462 from $t0 to $fp-156
	  sw $t2, -160($fp)	# spill _tmp463 from $t2 to $fp-160
	  sw $t3, -164($fp)	# spill _tmp464 from $t3 to $fp-164
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp465 = ".\n"
	  .data			# create string constant marked with label
	  _string21: .asciiz ".\n"
	  .text
	  la $t0, _string21	# load label
	# PushParam _tmp465
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -168($fp)	# spill _tmp465 from $t0 to $fp-168
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp466 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# Return _tmp466
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# Goto _L36
	  b _L36		# unconditional branch
  _L36:
	# _tmp467 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp467
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.TakeTurn:
	# BeginFunc 296
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 296	# decrement sp to make space for locals/temps
	# _tmp468 = "\n"
	  .data			# create string constant marked with label
	  _string22: .asciiz "\n"
	  .text
	  la $t0, _string22	# load label
	# PushParam _tmp468
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp468 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp469 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp470 = this + _tmp469
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp471 = *(_tmp470)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp471
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp469 from $t0 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp470 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill _tmp471 from $t3 to $fp-20
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp472 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string23: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string23	# load label
	# PushParam _tmp472
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp472 from $t0 to $fp-24
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp473 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp474 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp475 = this + _tmp474
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp475) = _tmp473
	  sw $t0, 0($t3) 	# store with offset
	# _tmp476 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp477 = 8
	  li $t5, 8		# load constant value 8 into $t5
	# _tmp478 = this + _tmp477
	  add $t6, $t2, $t5	
	# *(_tmp478) = _tmp476
	  sw $t4, 0($t6) 	# store with offset
	# _tmp479 = 0
	  li $t7, 0		# load constant value 0 into $t7
	# _tmp480 = 12
	  li $s0, 12		# load constant value 12 into $s0
	# _tmp481 = this + _tmp480
	  add $s1, $t2, $s0	
	# *(_tmp481) = _tmp479
	  sw $t7, 0($s1) 	# store with offset
	# _tmp482 = *(this)
	  lw $s2, 0($t2) 	# load with offset
	# _tmp483 = 4
	  li $s3, 4		# load constant value 4 into $s3
	# _tmp484 = _tmp483 + _tmp482
	  add $s4, $s3, $s2	
	# _tmp485 = *(_tmp484)
	  lw $s5, 0($s4) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $s6, 8($fp)	# load deck from $fp+8 into $s6
	  sw $s6, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp485
	# (save modified registers before flow of control change)
	  sw $t0, -28($fp)	# spill _tmp473 from $t0 to $fp-28
	  sw $t1, -32($fp)	# spill _tmp474 from $t1 to $fp-32
	  sw $t3, -36($fp)	# spill _tmp475 from $t3 to $fp-36
	  sw $t4, -40($fp)	# spill _tmp476 from $t4 to $fp-40
	  sw $t5, -44($fp)	# spill _tmp477 from $t5 to $fp-44
	  sw $t6, -48($fp)	# spill _tmp478 from $t6 to $fp-48
	  sw $t7, -52($fp)	# spill _tmp479 from $t7 to $fp-52
	  sw $s0, -56($fp)	# spill _tmp480 from $s0 to $fp-56
	  sw $s1, -60($fp)	# spill _tmp481 from $s1 to $fp-60
	  sw $s2, -64($fp)	# spill _tmp482 from $s2 to $fp-64
	  sw $s3, -68($fp)	# spill _tmp483 from $s3 to $fp-68
	  sw $s4, -72($fp)	# spill _tmp484 from $s4 to $fp-72
	  sw $s5, -76($fp)	# spill _tmp485 from $s5 to $fp-76
	  jalr $s5            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp486 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp487 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp488 = _tmp487 + _tmp486
	  add $t3, $t2, $t1	
	# _tmp489 = *(_tmp488)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t5, 8($fp)	# load deck from $fp+8 into $t5
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp489
	# (save modified registers before flow of control change)
	  sw $t1, -80($fp)	# spill _tmp486 from $t1 to $fp-80
	  sw $t2, -84($fp)	# spill _tmp487 from $t2 to $fp-84
	  sw $t3, -88($fp)	# spill _tmp488 from $t3 to $fp-88
	  sw $t4, -92($fp)	# spill _tmp489 from $t4 to $fp-92
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp490 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp491 = 8
	  li $t2, 8		# load constant value 8 into $t2
	# _tmp492 = _tmp491 + _tmp490
	  add $t3, $t2, $t1	
	# _tmp493 = *(_tmp492)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t5, 8($fp)	# load deck from $fp+8 into $t5
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp494 = ACall _tmp493
	# (save modified registers before flow of control change)
	  sw $t1, -96($fp)	# spill _tmp490 from $t1 to $fp-96
	  sw $t2, -100($fp)	# spill _tmp491 from $t2 to $fp-100
	  sw $t3, -104($fp)	# spill _tmp492 from $t3 to $fp-104
	  sw $t4, -108($fp)	# spill _tmp493 from $t4 to $fp-108
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp495 = -1
	  li $t1, -1		# load constant value -1 into $t1
	# _tmp496 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp497 = _tmp494 - _tmp496
	  sub $t3, $t0, $t2	
	# _tmp498 = _tmp497 * _tmp495
	  mul $t4, $t3, $t1	
	# IfZ _tmp498 Goto _L38
	# (save modified registers before flow of control change)
	  sw $t0, -112($fp)	# spill _tmp494 from $t0 to $fp-112
	  sw $t1, -116($fp)	# spill _tmp495 from $t1 to $fp-116
	  sw $t2, -120($fp)	# spill _tmp496 from $t2 to $fp-120
	  sw $t3, -124($fp)	# spill _tmp497 from $t3 to $fp-124
	  sw $t4, -128($fp)	# spill _tmp498 from $t4 to $fp-128
	  beqz $t4, _L38	# branch if _tmp498 is zero 
	# _tmp499 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# stillGoing = _tmp499
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp499 from $t0 to $fp-132
	  sw $t1, -136($fp)	# spill stillGoing from $t1 to $fp-136
  _L40:
	# _tmp500 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp501 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp502 = this + _tmp501
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp503 = _tmp502 < _tmp500
	  slt $t4, $t3, $t0	
	# _tmp504 = _tmp500 == _tmp502
	  seq $t5, $t0, $t3	
	# _tmp505 = _tmp503 || _tmp504
	  or $t6, $t4, $t5	
	# _tmp506 = stillGoing && _tmp505
	  lw $t7, -136($fp)	# load stillGoing from $fp-136 into $t7
	  and $s0, $t7, $t6	
	# IfZ _tmp506 Goto _L41
	# (save modified registers before flow of control change)
	  sw $t0, -140($fp)	# spill _tmp500 from $t0 to $fp-140
	  sw $t1, -144($fp)	# spill _tmp501 from $t1 to $fp-144
	  sw $t3, -148($fp)	# spill _tmp502 from $t3 to $fp-148
	  sw $t4, -152($fp)	# spill _tmp503 from $t4 to $fp-152
	  sw $t5, -156($fp)	# spill _tmp504 from $t5 to $fp-156
	  sw $t6, -160($fp)	# spill _tmp505 from $t6 to $fp-160
	  sw $s0, -164($fp)	# spill _tmp506 from $s0 to $fp-164
	  beqz $s0, _L41	# branch if _tmp506 is zero 
	# _tmp507 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp508 = this + _tmp507
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp509 = *(_tmp508)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp509
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -168($fp)	# spill _tmp507 from $t0 to $fp-168
	  sw $t2, -172($fp)	# spill _tmp508 from $t2 to $fp-172
	  sw $t3, -176($fp)	# spill _tmp509 from $t3 to $fp-176
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp510 = ", your total is "
	  .data			# create string constant marked with label
	  _string24: .asciiz ", your total is "
	  .text
	  la $t0, _string24	# load label
	# PushParam _tmp510
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -180($fp)	# spill _tmp510 from $t0 to $fp-180
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp511 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp512 = this + _tmp511
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp513 = *(_tmp512)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp513
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -184($fp)	# spill _tmp511 from $t0 to $fp-184
	  sw $t2, -188($fp)	# spill _tmp512 from $t2 to $fp-188
	  sw $t3, -192($fp)	# spill _tmp513 from $t3 to $fp-192
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp514 = ".\n"
	  .data			# create string constant marked with label
	  _string25: .asciiz ".\n"
	  .text
	  la $t0, _string25	# load label
	# PushParam _tmp514
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -196($fp)	# spill _tmp514 from $t0 to $fp-196
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp515 = "Would you like a hit?"
	  .data			# create string constant marked with label
	  _string26: .asciiz "Would you like a hit?"
	  .text
	  la $t0, _string26	# load label
	# PushParam _tmp515
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp516 = LCall _GetYesOrNo
	# (save modified registers before flow of control change)
	  sw $t0, -200($fp)	# spill _tmp515 from $t0 to $fp-200
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# stillGoing = _tmp516
	  move $t1, $t0		# copy value
	# IfZ stillGoing Goto _L42
	# (save modified registers before flow of control change)
	  sw $t0, -204($fp)	# spill _tmp516 from $t0 to $fp-204
	  sw $t1, -136($fp)	# spill stillGoing from $t1 to $fp-136
	  beqz $t1, _L42	# branch if stillGoing is zero 
	# _tmp517 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp518 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp519 = _tmp518 + _tmp517
	  add $t3, $t2, $t1	
	# _tmp520 = *(_tmp519)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t5, 8($fp)	# load deck from $fp+8 into $t5
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp520
	# (save modified registers before flow of control change)
	  sw $t1, -208($fp)	# spill _tmp517 from $t1 to $fp-208
	  sw $t2, -212($fp)	# spill _tmp518 from $t2 to $fp-212
	  sw $t3, -216($fp)	# spill _tmp519 from $t3 to $fp-216
	  sw $t4, -220($fp)	# spill _tmp520 from $t4 to $fp-220
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L42
	  b _L42		# unconditional branch
  _L42:
	# Goto _L40
	  b _L40		# unconditional branch
  _L41:
	# Goto _L38
	  b _L38		# unconditional branch
  _L38:
	# _tmp521 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp522 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp523 = this + _tmp522
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp524 = _tmp521 < _tmp523
	  slt $t4, $t0, $t3	
	# IfZ _tmp524 Goto _L45
	# (save modified registers before flow of control change)
	  sw $t0, -224($fp)	# spill _tmp521 from $t0 to $fp-224
	  sw $t1, -228($fp)	# spill _tmp522 from $t1 to $fp-228
	  sw $t3, -232($fp)	# spill _tmp523 from $t3 to $fp-232
	  sw $t4, -236($fp)	# spill _tmp524 from $t4 to $fp-236
	  beqz $t4, _L45	# branch if _tmp524 is zero 
	# _tmp525 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp526 = this + _tmp525
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp527 = *(_tmp526)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp527
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -240($fp)	# spill _tmp525 from $t0 to $fp-240
	  sw $t2, -244($fp)	# spill _tmp526 from $t2 to $fp-244
	  sw $t3, -248($fp)	# spill _tmp527 from $t3 to $fp-248
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp528 = " busts with the big "
	  .data			# create string constant marked with label
	  _string27: .asciiz " busts with the big "
	  .text
	  la $t0, _string27	# load label
	# PushParam _tmp528
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -252($fp)	# spill _tmp528 from $t0 to $fp-252
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp529 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp530 = this + _tmp529
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp531 = *(_tmp530)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp531
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -256($fp)	# spill _tmp529 from $t0 to $fp-256
	  sw $t2, -260($fp)	# spill _tmp530 from $t2 to $fp-260
	  sw $t3, -264($fp)	# spill _tmp531 from $t3 to $fp-264
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp532 = "!\n"
	  .data			# create string constant marked with label
	  _string28: .asciiz "!\n"
	  .text
	  la $t0, _string28	# load label
	# PushParam _tmp532
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -268($fp)	# spill _tmp532 from $t0 to $fp-268
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L44
	  b _L44		# unconditional branch
  _L45:
	# _tmp533 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp534 = this + _tmp533
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp535 = *(_tmp534)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp535
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -272($fp)	# spill _tmp533 from $t0 to $fp-272
	  sw $t2, -276($fp)	# spill _tmp534 from $t2 to $fp-276
	  sw $t3, -280($fp)	# spill _tmp535 from $t3 to $fp-280
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp536 = " stays at "
	  .data			# create string constant marked with label
	  _string29: .asciiz " stays at "
	  .text
	  la $t0, _string29	# load label
	# PushParam _tmp536
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -284($fp)	# spill _tmp536 from $t0 to $fp-284
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp537 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp538 = this + _tmp537
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp539 = *(_tmp538)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp539
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -288($fp)	# spill _tmp537 from $t0 to $fp-288
	  sw $t2, -292($fp)	# spill _tmp538 from $t2 to $fp-292
	  sw $t3, -296($fp)	# spill _tmp539 from $t3 to $fp-296
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp540 = ".\n"
	  .data			# create string constant marked with label
	  _string30: .asciiz ".\n"
	  .text
	  la $t0, _string30	# load label
	# PushParam _tmp540
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -300($fp)	# spill _tmp540 from $t0 to $fp-300
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L44:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.HasMoney:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp541 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp542 = 20
	  li $t1, 20		# load constant value 20 into $t1
	# _tmp543 = this + _tmp542
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp544 = _tmp541 < _tmp543
	  slt $t4, $t0, $t3	
	# Return _tmp544
	  move $v0, $t4		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.PrintMoney:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# _tmp545 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp546 = this + _tmp545
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp547 = *(_tmp546)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp547
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp545 from $t0 to $fp-8
	  sw $t2, -12($fp)	# spill _tmp546 from $t2 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp547 from $t3 to $fp-16
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp548 = ", you have $"
	  .data			# create string constant marked with label
	  _string31: .asciiz ", you have $"
	  .text
	  la $t0, _string31	# load label
	# PushParam _tmp548
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp548 from $t0 to $fp-20
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp549 = 20
	  li $t0, 20		# load constant value 20 into $t0
	# _tmp550 = this + _tmp549
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp551 = *(_tmp550)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp551
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp549 from $t0 to $fp-24
	  sw $t2, -28($fp)	# spill _tmp550 from $t2 to $fp-28
	  sw $t3, -32($fp)	# spill _tmp551 from $t3 to $fp-32
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp552 = ".\n"
	  .data			# create string constant marked with label
	  _string32: .asciiz ".\n"
	  .text
	  la $t0, _string32	# load label
	# PushParam _tmp552
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -36($fp)	# spill _tmp552 from $t0 to $fp-36
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.PlaceBet:
	# BeginFunc 96
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 96	# decrement sp to make space for locals/temps
	# _tmp553 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp554 = 16
	  li $t1, 16		# load constant value 16 into $t1
	# _tmp555 = this + _tmp554
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp555) = _tmp553
	  sw $t0, 0($t3) 	# store with offset
	# _tmp556 = *(this)
	  lw $t4, 0($t2) 	# load with offset
	# _tmp557 = 20
	  li $t5, 20		# load constant value 20 into $t5
	# _tmp558 = _tmp557 + _tmp556
	  add $t6, $t5, $t4	
	# _tmp559 = *(_tmp558)
	  lw $t7, 0($t6) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp559
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp553 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp554 from $t1 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp555 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp556 from $t4 to $fp-20
	  sw $t5, -24($fp)	# spill _tmp557 from $t5 to $fp-24
	  sw $t6, -28($fp)	# spill _tmp558 from $t6 to $fp-28
	  sw $t7, -32($fp)	# spill _tmp559 from $t7 to $fp-32
	  jalr $t7            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L46:
	# _tmp560 = 20
	  li $t0, 20		# load constant value 20 into $t0
	# _tmp561 = this + _tmp560
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp562 = *(_tmp561)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp563 = 16
	  li $t4, 16		# load constant value 16 into $t4
	# _tmp564 = this + _tmp563
	  add $t5, $t1, $t4	
	# _tmp565 = _tmp562 < _tmp564
	  slt $t6, $t3, $t5	
	# _tmp566 = 0
	  li $t7, 0		# load constant value 0 into $t7
	# _tmp567 = 16
	  li $s0, 16		# load constant value 16 into $s0
	# _tmp568 = this + _tmp567
	  add $s1, $t1, $s0	
	# _tmp569 = _tmp568 < _tmp566
	  slt $s2, $s1, $t7	
	# _tmp570 = _tmp566 == _tmp568
	  seq $s3, $t7, $s1	
	# _tmp571 = _tmp569 || _tmp570
	  or $s4, $s2, $s3	
	# _tmp572 = _tmp565 || _tmp571
	  or $s5, $t6, $s4	
	# IfZ _tmp572 Goto _L47
	# (save modified registers before flow of control change)
	  sw $t0, -36($fp)	# spill _tmp560 from $t0 to $fp-36
	  sw $t2, -40($fp)	# spill _tmp561 from $t2 to $fp-40
	  sw $t3, -44($fp)	# spill _tmp562 from $t3 to $fp-44
	  sw $t4, -48($fp)	# spill _tmp563 from $t4 to $fp-48
	  sw $t5, -52($fp)	# spill _tmp564 from $t5 to $fp-52
	  sw $t6, -56($fp)	# spill _tmp565 from $t6 to $fp-56
	  sw $t7, -60($fp)	# spill _tmp566 from $t7 to $fp-60
	  sw $s0, -64($fp)	# spill _tmp567 from $s0 to $fp-64
	  sw $s1, -68($fp)	# spill _tmp568 from $s1 to $fp-68
	  sw $s2, -72($fp)	# spill _tmp569 from $s2 to $fp-72
	  sw $s3, -76($fp)	# spill _tmp570 from $s3 to $fp-76
	  sw $s4, -80($fp)	# spill _tmp571 from $s4 to $fp-80
	  sw $s5, -84($fp)	# spill _tmp572 from $s5 to $fp-84
	  beqz $s5, _L47	# branch if _tmp572 is zero 
	# _tmp573 = "How much would you like to bet? "
	  .data			# create string constant marked with label
	  _string33: .asciiz "How much would you like to bet? "
	  .text
	  la $t0, _string33	# load label
	# PushParam _tmp573
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -88($fp)	# spill _tmp573 from $t0 to $fp-88
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp574 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# _tmp575 = 16
	  li $t1, 16		# load constant value 16 into $t1
	# _tmp576 = this + _tmp575
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp576) = _tmp574
	  sw $t0, 0($t3) 	# store with offset
	# Goto _L46
	# (save modified registers before flow of control change)
	  sw $t0, -92($fp)	# spill _tmp574 from $t0 to $fp-92
	  sw $t1, -96($fp)	# spill _tmp575 from $t1 to $fp-96
	  sw $t3, -100($fp)	# spill _tmp576 from $t3 to $fp-100
	  b _L46		# unconditional branch
  _L47:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.GetTotal:
	# BeginFunc 12
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 12	# decrement sp to make space for locals/temps
	# _tmp577 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp578 = this + _tmp577
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp579 = *(_tmp578)
	  lw $t3, 0($t2) 	# load with offset
	# Return _tmp579
	  move $v0, $t3		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Resolve:
	# BeginFunc 296
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 296	# decrement sp to make space for locals/temps
	# _tmp580 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# win = _tmp580
	  move $t1, $t0		# copy value
	# _tmp581 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# lose = _tmp581
	  move $t3, $t2		# copy value
	# _tmp582 = 2
	  li $t4, 2		# load constant value 2 into $t4
	# _tmp583 = 12
	  li $t5, 12		# load constant value 12 into $t5
	# _tmp584 = this + _tmp583
	  lw $t6, 4($fp)	# load this from $fp+4 into $t6
	  add $t7, $t6, $t5	
	# _tmp585 = *(_tmp584)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp586 = _tmp585 == _tmp582
	  seq $s1, $s0, $t4	
	# _tmp587 = 21
	  li $s2, 21		# load constant value 21 into $s2
	# _tmp588 = 4
	  li $s3, 4		# load constant value 4 into $s3
	# _tmp589 = this + _tmp588
	  add $s4, $t6, $s3	
	# _tmp590 = *(_tmp589)
	  lw $s5, 0($s4) 	# load with offset
	# _tmp591 = _tmp590 == _tmp587
	  seq $s6, $s5, $s2	
	# _tmp592 = _tmp586 && _tmp591
	  and $s7, $s1, $s6	
	# IfZ _tmp592 Goto _L49
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp580 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill win from $t1 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp581 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill lose from $t3 to $fp-20
	  sw $t4, -24($fp)	# spill _tmp582 from $t4 to $fp-24
	  sw $t5, -28($fp)	# spill _tmp583 from $t5 to $fp-28
	  sw $t7, -32($fp)	# spill _tmp584 from $t7 to $fp-32
	  sw $s0, -36($fp)	# spill _tmp585 from $s0 to $fp-36
	  sw $s1, -40($fp)	# spill _tmp586 from $s1 to $fp-40
	  sw $s2, -44($fp)	# spill _tmp587 from $s2 to $fp-44
	  sw $s3, -48($fp)	# spill _tmp588 from $s3 to $fp-48
	  sw $s4, -52($fp)	# spill _tmp589 from $s4 to $fp-52
	  sw $s5, -56($fp)	# spill _tmp590 from $s5 to $fp-56
	  sw $s6, -60($fp)	# spill _tmp591 from $s6 to $fp-60
	  sw $s7, -64($fp)	# spill _tmp592 from $s7 to $fp-64
	  beqz $s7, _L49	# branch if _tmp592 is zero 
	# _tmp593 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# win = _tmp593
	  move $t1, $t0		# copy value
	# Goto _L48
	# (save modified registers before flow of control change)
	  sw $t0, -68($fp)	# spill _tmp593 from $t0 to $fp-68
	  sw $t1, -12($fp)	# spill win from $t1 to $fp-12
	  b _L48		# unconditional branch
  _L49:
	# _tmp594 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp595 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp596 = this + _tmp595
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp597 = _tmp594 < _tmp596
	  slt $t4, $t0, $t3	
	# IfZ _tmp597 Goto _L51
	# (save modified registers before flow of control change)
	  sw $t0, -72($fp)	# spill _tmp594 from $t0 to $fp-72
	  sw $t1, -76($fp)	# spill _tmp595 from $t1 to $fp-76
	  sw $t3, -80($fp)	# spill _tmp596 from $t3 to $fp-80
	  sw $t4, -84($fp)	# spill _tmp597 from $t4 to $fp-84
	  beqz $t4, _L51	# branch if _tmp597 is zero 
	# _tmp598 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp598
	  move $t1, $t0		# copy value
	# Goto _L50
	# (save modified registers before flow of control change)
	  sw $t0, -88($fp)	# spill _tmp598 from $t0 to $fp-88
	  sw $t1, -20($fp)	# spill lose from $t1 to $fp-20
	  b _L50		# unconditional branch
  _L51:
	# _tmp599 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp600 = _tmp599 < dealer
	  lw $t1, 8($fp)	# load dealer from $fp+8 into $t1
	  slt $t2, $t0, $t1	
	# IfZ _tmp600 Goto _L53
	# (save modified registers before flow of control change)
	  sw $t0, -92($fp)	# spill _tmp599 from $t0 to $fp-92
	  sw $t2, -96($fp)	# spill _tmp600 from $t2 to $fp-96
	  beqz $t2, _L53	# branch if _tmp600 is zero 
	# _tmp601 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp601
	  move $t1, $t0		# copy value
	# Goto _L52
	# (save modified registers before flow of control change)
	  sw $t0, -100($fp)	# spill _tmp601 from $t0 to $fp-100
	  sw $t1, -12($fp)	# spill win from $t1 to $fp-12
	  b _L52		# unconditional branch
  _L53:
	# _tmp602 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp603 = this + _tmp602
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp604 = dealer < _tmp603
	  lw $t3, 8($fp)	# load dealer from $fp+8 into $t3
	  slt $t4, $t3, $t2	
	# IfZ _tmp604 Goto _L55
	# (save modified registers before flow of control change)
	  sw $t0, -104($fp)	# spill _tmp602 from $t0 to $fp-104
	  sw $t2, -108($fp)	# spill _tmp603 from $t2 to $fp-108
	  sw $t4, -112($fp)	# spill _tmp604 from $t4 to $fp-112
	  beqz $t4, _L55	# branch if _tmp604 is zero 
	# _tmp605 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp605
	  move $t1, $t0		# copy value
	# Goto _L54
	# (save modified registers before flow of control change)
	  sw $t0, -116($fp)	# spill _tmp605 from $t0 to $fp-116
	  sw $t1, -12($fp)	# spill win from $t1 to $fp-12
	  b _L54		# unconditional branch
  _L55:
	# _tmp606 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp607 = this + _tmp606
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp608 = *(_tmp607)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp609 = _tmp608 < dealer
	  lw $t4, 8($fp)	# load dealer from $fp+8 into $t4
	  slt $t5, $t3, $t4	
	# IfZ _tmp609 Goto _L56
	# (save modified registers before flow of control change)
	  sw $t0, -120($fp)	# spill _tmp606 from $t0 to $fp-120
	  sw $t2, -124($fp)	# spill _tmp607 from $t2 to $fp-124
	  sw $t3, -128($fp)	# spill _tmp608 from $t3 to $fp-128
	  sw $t5, -132($fp)	# spill _tmp609 from $t5 to $fp-132
	  beqz $t5, _L56	# branch if _tmp609 is zero 
	# _tmp610 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp610
	  move $t1, $t0		# copy value
	# Goto _L56
	# (save modified registers before flow of control change)
	  sw $t0, -136($fp)	# spill _tmp610 from $t0 to $fp-136
	  sw $t1, -20($fp)	# spill lose from $t1 to $fp-20
	  b _L56		# unconditional branch
  _L56:
  _L54:
  _L52:
  _L50:
  _L48:
	# _tmp611 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp612 = _tmp611 < win
	  lw $t1, -12($fp)	# load win from $fp-12 into $t1
	  slt $t2, $t0, $t1	
	# _tmp613 = _tmp611 == win
	  seq $t3, $t0, $t1	
	# _tmp614 = _tmp612 || _tmp613
	  or $t4, $t2, $t3	
	# IfZ _tmp614 Goto _L59
	# (save modified registers before flow of control change)
	  sw $t0, -140($fp)	# spill _tmp611 from $t0 to $fp-140
	  sw $t2, -144($fp)	# spill _tmp612 from $t2 to $fp-144
	  sw $t3, -148($fp)	# spill _tmp613 from $t3 to $fp-148
	  sw $t4, -152($fp)	# spill _tmp614 from $t4 to $fp-152
	  beqz $t4, _L59	# branch if _tmp614 is zero 
	# _tmp615 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp616 = this + _tmp615
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp617 = *(_tmp616)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp617
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -156($fp)	# spill _tmp615 from $t0 to $fp-156
	  sw $t2, -160($fp)	# spill _tmp616 from $t2 to $fp-160
	  sw $t3, -164($fp)	# spill _tmp617 from $t3 to $fp-164
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp618 = ", you won $"
	  .data			# create string constant marked with label
	  _string34: .asciiz ", you won $"
	  .text
	  la $t0, _string34	# load label
	# PushParam _tmp618
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -168($fp)	# spill _tmp618 from $t0 to $fp-168
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp619 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# _tmp620 = this + _tmp619
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp621 = *(_tmp620)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp621
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -172($fp)	# spill _tmp619 from $t0 to $fp-172
	  sw $t2, -176($fp)	# spill _tmp620 from $t2 to $fp-176
	  sw $t3, -180($fp)	# spill _tmp621 from $t3 to $fp-180
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp622 = ".\n"
	  .data			# create string constant marked with label
	  _string35: .asciiz ".\n"
	  .text
	  la $t0, _string35	# load label
	# PushParam _tmp622
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -184($fp)	# spill _tmp622 from $t0 to $fp-184
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L58
	  b _L58		# unconditional branch
  _L59:
	# _tmp623 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp624 = _tmp623 < lose
	  lw $t1, -20($fp)	# load lose from $fp-20 into $t1
	  slt $t2, $t0, $t1	
	# _tmp625 = _tmp623 == lose
	  seq $t3, $t0, $t1	
	# _tmp626 = _tmp624 || _tmp625
	  or $t4, $t2, $t3	
	# IfZ _tmp626 Goto _L61
	# (save modified registers before flow of control change)
	  sw $t0, -188($fp)	# spill _tmp623 from $t0 to $fp-188
	  sw $t2, -192($fp)	# spill _tmp624 from $t2 to $fp-192
	  sw $t3, -196($fp)	# spill _tmp625 from $t3 to $fp-196
	  sw $t4, -200($fp)	# spill _tmp626 from $t4 to $fp-200
	  beqz $t4, _L61	# branch if _tmp626 is zero 
	# _tmp627 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp628 = this + _tmp627
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp629 = *(_tmp628)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp629
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -204($fp)	# spill _tmp627 from $t0 to $fp-204
	  sw $t2, -208($fp)	# spill _tmp628 from $t2 to $fp-208
	  sw $t3, -212($fp)	# spill _tmp629 from $t3 to $fp-212
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp630 = ", you lost $"
	  .data			# create string constant marked with label
	  _string36: .asciiz ", you lost $"
	  .text
	  la $t0, _string36	# load label
	# PushParam _tmp630
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -216($fp)	# spill _tmp630 from $t0 to $fp-216
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp631 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# _tmp632 = this + _tmp631
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp633 = *(_tmp632)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp633
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -220($fp)	# spill _tmp631 from $t0 to $fp-220
	  sw $t2, -224($fp)	# spill _tmp632 from $t2 to $fp-224
	  sw $t3, -228($fp)	# spill _tmp633 from $t3 to $fp-228
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp634 = ".\n"
	  .data			# create string constant marked with label
	  _string37: .asciiz ".\n"
	  .text
	  la $t0, _string37	# load label
	# PushParam _tmp634
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -232($fp)	# spill _tmp634 from $t0 to $fp-232
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L60
	  b _L60		# unconditional branch
  _L61:
	# _tmp635 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp636 = this + _tmp635
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp637 = *(_tmp636)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp637
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -236($fp)	# spill _tmp635 from $t0 to $fp-236
	  sw $t2, -240($fp)	# spill _tmp636 from $t2 to $fp-240
	  sw $t3, -244($fp)	# spill _tmp637 from $t3 to $fp-244
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp638 = ", you push!\n"
	  .data			# create string constant marked with label
	  _string38: .asciiz ", you push!\n"
	  .text
	  la $t0, _string38	# load label
	# PushParam _tmp638
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -248($fp)	# spill _tmp638 from $t0 to $fp-248
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L60:
  _L58:
	# _tmp639 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# _tmp640 = this + _tmp639
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp641 = win * _tmp640
	  lw $t3, -12($fp)	# load win from $fp-12 into $t3
	  mul $t4, $t3, $t2	
	# win = _tmp641
	  move $t3, $t4		# copy value
	# _tmp642 = 16
	  li $t5, 16		# load constant value 16 into $t5
	# _tmp643 = this + _tmp642
	  add $t6, $t1, $t5	
	# _tmp644 = lose * _tmp643
	  lw $t7, -20($fp)	# load lose from $fp-20 into $t7
	  mul $s0, $t7, $t6	
	# lose = _tmp644
	  move $t7, $s0		# copy value
	# _tmp645 = 20
	  li $s1, 20		# load constant value 20 into $s1
	# _tmp646 = this + _tmp645
	  add $s2, $t1, $s1	
	# _tmp647 = *(_tmp646)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp648 = _tmp647 + win
	  add $s4, $s3, $t3	
	# _tmp649 = _tmp648 - lose
	  sub $s5, $s4, $t7	
	# _tmp650 = 20
	  li $s6, 20		# load constant value 20 into $s6
	# _tmp651 = this + _tmp650
	  add $s7, $t1, $s6	
	# *(_tmp651) = _tmp649
	  sw $s5, 0($s7) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Dealer
	  .data
	  .align 2
	  Dealer:		# label for class Dealer vtable
	  .word _Dealer.Init
	  .word _Dealer.TakeTurn
	  .text
  _Dealer.Init:
	# BeginFunc 48
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 48	# decrement sp to make space for locals/temps
	# _tmp652 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp653 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp654 = this + _tmp653
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# *(_tmp654) = _tmp652
	  sw $t0, 0($t3) 	# store with offset
	# _tmp655 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp656 = 8
	  li $t5, 8		# load constant value 8 into $t5
	# _tmp657 = this + _tmp656
	  add $t6, $t2, $t5	
	# *(_tmp657) = _tmp655
	  sw $t4, 0($t6) 	# store with offset
	# _tmp658 = 0
	  li $t7, 0		# load constant value 0 into $t7
	# _tmp659 = 12
	  li $s0, 12		# load constant value 12 into $s0
	# _tmp660 = this + _tmp659
	  add $s1, $t2, $s0	
	# *(_tmp660) = _tmp658
	  sw $t7, 0($s1) 	# store with offset
	# _tmp661 = "Dealer"
	  .data			# create string constant marked with label
	  _string39: .asciiz "Dealer"
	  .text
	  la $s2, _string39	# load label
	# _tmp662 = 24
	  li $s3, 24		# load constant value 24 into $s3
	# _tmp663 = this + _tmp662
	  add $s4, $t2, $s3	
	# *(_tmp663) = _tmp661
	  sw $s2, 0($s4) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Dealer.TakeTurn:
	# BeginFunc 140
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 140	# decrement sp to make space for locals/temps
	# _tmp664 = "\n"
	  .data			# create string constant marked with label
	  _string40: .asciiz "\n"
	  .text
	  la $t0, _string40	# load label
	# PushParam _tmp664
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp664 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp665 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp666 = this + _tmp665
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp667 = *(_tmp666)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp667
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp665 from $t0 to $fp-12
	  sw $t2, -16($fp)	# spill _tmp666 from $t2 to $fp-16
	  sw $t3, -20($fp)	# spill _tmp667 from $t3 to $fp-20
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp668 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string41: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string41	# load label
	# PushParam _tmp668
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp668 from $t0 to $fp-24
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L62:
	# _tmp669 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# _tmp670 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp671 = this + _tmp670
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp672 = _tmp671 < _tmp669
	  slt $t4, $t3, $t0	
	# _tmp673 = _tmp669 == _tmp671
	  seq $t5, $t0, $t3	
	# _tmp674 = _tmp672 || _tmp673
	  or $t6, $t4, $t5	
	# IfZ _tmp674 Goto _L63
	# (save modified registers before flow of control change)
	  sw $t0, -28($fp)	# spill _tmp669 from $t0 to $fp-28
	  sw $t1, -32($fp)	# spill _tmp670 from $t1 to $fp-32
	  sw $t3, -36($fp)	# spill _tmp671 from $t3 to $fp-36
	  sw $t4, -40($fp)	# spill _tmp672 from $t4 to $fp-40
	  sw $t5, -44($fp)	# spill _tmp673 from $t5 to $fp-44
	  sw $t6, -48($fp)	# spill _tmp674 from $t6 to $fp-48
	  beqz $t6, _L63	# branch if _tmp674 is zero 
	# _tmp675 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp676 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp677 = _tmp676 + _tmp675
	  add $t3, $t2, $t1	
	# _tmp678 = *(_tmp677)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t5, 8($fp)	# load deck from $fp+8 into $t5
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp678
	# (save modified registers before flow of control change)
	  sw $t1, -52($fp)	# spill _tmp675 from $t1 to $fp-52
	  sw $t2, -56($fp)	# spill _tmp676 from $t2 to $fp-56
	  sw $t3, -60($fp)	# spill _tmp677 from $t3 to $fp-60
	  sw $t4, -64($fp)	# spill _tmp678 from $t4 to $fp-64
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L62
	  b _L62		# unconditional branch
  _L63:
	# _tmp679 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp680 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp681 = this + _tmp680
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp682 = _tmp679 < _tmp681
	  slt $t4, $t0, $t3	
	# IfZ _tmp682 Goto _L65
	# (save modified registers before flow of control change)
	  sw $t0, -68($fp)	# spill _tmp679 from $t0 to $fp-68
	  sw $t1, -72($fp)	# spill _tmp680 from $t1 to $fp-72
	  sw $t3, -76($fp)	# spill _tmp681 from $t3 to $fp-76
	  sw $t4, -80($fp)	# spill _tmp682 from $t4 to $fp-80
	  beqz $t4, _L65	# branch if _tmp682 is zero 
	# _tmp683 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp684 = this + _tmp683
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp685 = *(_tmp684)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp685
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -84($fp)	# spill _tmp683 from $t0 to $fp-84
	  sw $t2, -88($fp)	# spill _tmp684 from $t2 to $fp-88
	  sw $t3, -92($fp)	# spill _tmp685 from $t3 to $fp-92
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp686 = " busts with the big "
	  .data			# create string constant marked with label
	  _string42: .asciiz " busts with the big "
	  .text
	  la $t0, _string42	# load label
	# PushParam _tmp686
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -96($fp)	# spill _tmp686 from $t0 to $fp-96
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp687 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp688 = this + _tmp687
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp689 = *(_tmp688)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp689
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -100($fp)	# spill _tmp687 from $t0 to $fp-100
	  sw $t2, -104($fp)	# spill _tmp688 from $t2 to $fp-104
	  sw $t3, -108($fp)	# spill _tmp689 from $t3 to $fp-108
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp690 = "!\n"
	  .data			# create string constant marked with label
	  _string43: .asciiz "!\n"
	  .text
	  la $t0, _string43	# load label
	# PushParam _tmp690
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -112($fp)	# spill _tmp690 from $t0 to $fp-112
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L64
	  b _L64		# unconditional branch
  _L65:
	# _tmp691 = 24
	  li $t0, 24		# load constant value 24 into $t0
	# _tmp692 = this + _tmp691
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp693 = *(_tmp692)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp693
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -116($fp)	# spill _tmp691 from $t0 to $fp-116
	  sw $t2, -120($fp)	# spill _tmp692 from $t2 to $fp-120
	  sw $t3, -124($fp)	# spill _tmp693 from $t3 to $fp-124
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp694 = " stays at "
	  .data			# create string constant marked with label
	  _string44: .asciiz " stays at "
	  .text
	  la $t0, _string44	# load label
	# PushParam _tmp694
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -128($fp)	# spill _tmp694 from $t0 to $fp-128
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp695 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp696 = this + _tmp695
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp697 = *(_tmp696)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp697
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp695 from $t0 to $fp-132
	  sw $t2, -136($fp)	# spill _tmp696 from $t2 to $fp-136
	  sw $t3, -140($fp)	# spill _tmp697 from $t3 to $fp-140
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp698 = ".\n"
	  .data			# create string constant marked with label
	  _string45: .asciiz ".\n"
	  .text
	  la $t0, _string45	# load label
	# PushParam _tmp698
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -144($fp)	# spill _tmp698 from $t0 to $fp-144
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L64:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class House
	  .data
	  .align 2
	  House:		# label for class House vtable
	  .word _House.SetupGame
	  .word _House.SetupPlayers
	  .word _House.TakeAllBets
	  .word _House.TakeAllTurns
	  .word _House.ResolveAllPlayers
	  .word _House.PrintAllMoney
	  .word _House.PlayOneGame
	  .text
  _House.SetupGame:
	# BeginFunc 96
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 96	# decrement sp to make space for locals/temps
	# _tmp699 = "\nWelcome to CS143 BlackJack!\n"
	  .data			# create string constant marked with label
	  _string46: .asciiz "\nWelcome to CS143 BlackJack!\n"
	  .text
	  la $t0, _string46	# load label
	# PushParam _tmp699
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp699 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp700 = "---------------------------\n"
	  .data			# create string constant marked with label
	  _string47: .asciiz "---------------------------\n"
	  .text
	  la $t0, _string47	# load label
	# PushParam _tmp700
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp700 from $t0 to $fp-12
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp701 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# PushParam _tmp701
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp702 = LCall _Alloc
	# (save modified registers before flow of control change)
	  sw $t0, -16($fp)	# spill _tmp701 from $t0 to $fp-16
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp703 = Random
	  la $t1, Random	# load label
	# *(_tmp702) = _tmp703
	  sw $t1, 0($t0) 	# store with offset
	# gRnd = _tmp702
	  move $t2, $t0		# copy value
	# _tmp704 = "Please enter a random number seed: "
	  .data			# create string constant marked with label
	  _string48: .asciiz "Please enter a random number seed: "
	  .text
	  la $t3, _string48	# load label
	# PushParam _tmp704
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp702 from $t0 to $fp-20
	  sw $t1, -24($fp)	# spill _tmp703 from $t1 to $fp-24
	  sw $t2, -188($fp)	# spill gRnd from $t2 to $fp-188
	  sw $t3, -28($fp)	# spill _tmp704 from $t3 to $fp-28
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp705 = *(_tmp702)
	  lw $t0, -20($fp)	# load _tmp702 from $fp-20 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp706 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp707 = _tmp706 + _tmp705
	  add $t3, $t2, $t1	
	# _tmp708 = *(_tmp707)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp709 = LCall _ReadInteger
	# (save modified registers before flow of control change)
	  sw $t1, -32($fp)	# spill _tmp705 from $t1 to $fp-32
	  sw $t2, -36($fp)	# spill _tmp706 from $t2 to $fp-36
	  sw $t3, -40($fp)	# spill _tmp707 from $t3 to $fp-40
	  sw $t4, -44($fp)	# spill _tmp708 from $t4 to $fp-44
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PushParam _tmp709
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp702
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, -20($fp)	# load _tmp702 from $fp-20 into $t1
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp708
	  lw $t2, -44($fp)	# load _tmp708 from $fp-44 into $t2
	# (save modified registers before flow of control change)
	  sw $t0, -48($fp)	# spill _tmp709 from $t0 to $fp-48
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp710 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp710
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp711 = LCall _Alloc
	# (save modified registers before flow of control change)
	  sw $t0, -52($fp)	# spill _tmp710 from $t0 to $fp-52
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp712 = BJDeck
	  la $t1, BJDeck	# load label
	# *(_tmp711) = _tmp712
	  sw $t1, 0($t0) 	# store with offset
	# _tmp713 = 12
	  li $t2, 12		# load constant value 12 into $t2
	# _tmp714 = this + _tmp713
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# *(_tmp714) = _tmp711
	  sw $t0, 0($t4) 	# store with offset
	# _tmp715 = 12
	  li $t5, 12		# load constant value 12 into $t5
	# _tmp716 = this + _tmp715
	  add $t6, $t3, $t5	
	# _tmp717 = *(_tmp716)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp718 = *(_tmp717)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp719 = 8
	  li $s1, 8		# load constant value 8 into $s1
	# _tmp720 = _tmp719 + _tmp718
	  add $s2, $s1, $s0	
	# _tmp721 = *(_tmp720)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp722 = *(_tmp716)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp722
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# ACall _tmp721
	# (save modified registers before flow of control change)
	  sw $t0, -56($fp)	# spill _tmp711 from $t0 to $fp-56
	  sw $t1, -60($fp)	# spill _tmp712 from $t1 to $fp-60
	  sw $t2, -64($fp)	# spill _tmp713 from $t2 to $fp-64
	  sw $t4, -68($fp)	# spill _tmp714 from $t4 to $fp-68
	  sw $t5, -72($fp)	# spill _tmp715 from $t5 to $fp-72
	  sw $t6, -76($fp)	# spill _tmp716 from $t6 to $fp-76
	  sw $t7, -80($fp)	# spill _tmp717 from $t7 to $fp-80
	  sw $s0, -84($fp)	# spill _tmp718 from $s0 to $fp-84
	  sw $s1, -88($fp)	# spill _tmp719 from $s1 to $fp-88
	  sw $s2, -92($fp)	# spill _tmp720 from $s2 to $fp-92
	  sw $s3, -96($fp)	# spill _tmp721 from $s3 to $fp-96
	  sw $s4, -100($fp)	# spill _tmp722 from $s4 to $fp-100
	  jalr $s3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.SetupPlayers:
	# BeginFunc 276
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 276	# decrement sp to make space for locals/temps
	# _tmp723 = "How many players do we have today? "
	  .data			# create string constant marked with label
	  _string49: .asciiz "How many players do we have today? "
	  .text
	  la $t0, _string49	# load label
	# PushParam _tmp723
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp723 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp724 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# numPlayers = _tmp724
	  move $t1, $t0		# copy value
	# _tmp725 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp726 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp727 = _tmp726 + numPlayers
	  add $t4, $t3, $t1	
	# _tmp728 = 4
	  li $t5, 4		# load constant value 4 into $t5
	# _tmp729 = _tmp728 * _tmp727
	  mul $t6, $t5, $t4	
	# _tmp730 = numPlayers < _tmp725
	  slt $t7, $t1, $t2	
	# _tmp731 = numPlayers == _tmp725
	  seq $s0, $t1, $t2	
	# _tmp732 = _tmp731 || _tmp730
	  or $s1, $s0, $t7	
	# IfZ _tmp732 Goto _L66
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp724 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill numPlayers from $t1 to $fp-16
	  sw $t2, -20($fp)	# spill _tmp725 from $t2 to $fp-20
	  sw $t3, -24($fp)	# spill _tmp726 from $t3 to $fp-24
	  sw $t4, -28($fp)	# spill _tmp727 from $t4 to $fp-28
	  sw $t5, -32($fp)	# spill _tmp728 from $t5 to $fp-32
	  sw $t6, -36($fp)	# spill _tmp729 from $t6 to $fp-36
	  sw $t7, -40($fp)	# spill _tmp730 from $t7 to $fp-40
	  sw $s0, -44($fp)	# spill _tmp731 from $s0 to $fp-44
	  sw $s1, -48($fp)	# spill _tmp732 from $s1 to $fp-48
	  beqz $s1, _L66	# branch if _tmp732 is zero 
	# _tmp733 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string50: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string50	# load label
	# PushParam _tmp733
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -52($fp)	# spill _tmp733 from $t0 to $fp-52
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L66:
	# PushParam _tmp729
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -36($fp)	# load _tmp729 from $fp-36 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp734 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp734) = numPlayers
	  lw $t1, -16($fp)	# load numPlayers from $fp-16 into $t1
	  sw $t1, 0($t0) 	# store with offset
	# _tmp735 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp736 = this + _tmp735
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# *(_tmp736) = _tmp734
	  sw $t0, 0($t4) 	# store with offset
	# _tmp737 = 0
	  li $t5, 0		# load constant value 0 into $t5
	# i = _tmp737
	  move $t6, $t5		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -56($fp)	# spill _tmp734 from $t0 to $fp-56
	  sw $t2, -60($fp)	# spill _tmp735 from $t2 to $fp-60
	  sw $t4, -64($fp)	# spill _tmp736 from $t4 to $fp-64
	  sw $t5, -68($fp)	# spill _tmp737 from $t5 to $fp-68
	  sw $t6, -72($fp)	# spill i from $t6 to $fp-72
  _L67:
	# _tmp738 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp739 = this + _tmp738
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp740 = *(_tmp739)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp741 = *(_tmp740)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp742 = i < _tmp741
	  lw $t5, -72($fp)	# load i from $fp-72 into $t5
	  slt $t6, $t5, $t4	
	# IfZ _tmp742 Goto _L68
	# (save modified registers before flow of control change)
	  sw $t0, -76($fp)	# spill _tmp738 from $t0 to $fp-76
	  sw $t2, -80($fp)	# spill _tmp739 from $t2 to $fp-80
	  sw $t3, -84($fp)	# spill _tmp740 from $t3 to $fp-84
	  sw $t4, -88($fp)	# spill _tmp741 from $t4 to $fp-88
	  sw $t6, -92($fp)	# spill _tmp742 from $t6 to $fp-92
	  beqz $t6, _L68	# branch if _tmp742 is zero 
	# _tmp743 = 28
	  li $t0, 28		# load constant value 28 into $t0
	# PushParam _tmp743
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp744 = LCall _Alloc
	# (save modified registers before flow of control change)
	  sw $t0, -96($fp)	# spill _tmp743 from $t0 to $fp-96
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp745 = Player
	  la $t1, Player	# load label
	# *(_tmp744) = _tmp745
	  sw $t1, 0($t0) 	# store with offset
	# _tmp746 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp747 = this + _tmp746
	  lw $t3, 4($fp)	# load this from $fp+4 into $t3
	  add $t4, $t3, $t2	
	# _tmp748 = *(_tmp747)
	  lw $t5, 0($t4) 	# load with offset
	# _tmp749 = *(_tmp748)
	  lw $t6, 0($t5) 	# load with offset
	# _tmp750 = *(_tmp747)
	  lw $t7, 0($t4) 	# load with offset
	# _tmp751 = _tmp749 < i
	  lw $s0, -72($fp)	# load i from $fp-72 into $s0
	  slt $s1, $t6, $s0	
	# _tmp752 = _tmp749 == i
	  seq $s2, $t6, $s0	
	# _tmp753 = _tmp752 || _tmp751
	  or $s3, $s2, $s1	
	# _tmp754 = 0
	  li $s4, 0		# load constant value 0 into $s4
	# _tmp755 = i < _tmp754
	  slt $s5, $s0, $s4	
	# _tmp756 = _tmp753 || _tmp755
	  or $s6, $s3, $s5	
	# IfZ _tmp756 Goto _L69
	# (save modified registers before flow of control change)
	  sw $t0, -100($fp)	# spill _tmp744 from $t0 to $fp-100
	  sw $t1, -104($fp)	# spill _tmp745 from $t1 to $fp-104
	  sw $t2, -108($fp)	# spill _tmp746 from $t2 to $fp-108
	  sw $t4, -112($fp)	# spill _tmp747 from $t4 to $fp-112
	  sw $t5, -116($fp)	# spill _tmp748 from $t5 to $fp-116
	  sw $t6, -120($fp)	# spill _tmp749 from $t6 to $fp-120
	  sw $t7, -124($fp)	# spill _tmp750 from $t7 to $fp-124
	  sw $s1, -128($fp)	# spill _tmp751 from $s1 to $fp-128
	  sw $s2, -132($fp)	# spill _tmp752 from $s2 to $fp-132
	  sw $s3, -136($fp)	# spill _tmp753 from $s3 to $fp-136
	  sw $s4, -140($fp)	# spill _tmp754 from $s4 to $fp-140
	  sw $s5, -144($fp)	# spill _tmp755 from $s5 to $fp-144
	  sw $s6, -148($fp)	# spill _tmp756 from $s6 to $fp-148
	  beqz $s6, _L69	# branch if _tmp756 is zero 
	# _tmp757 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string51: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string51	# load label
	# PushParam _tmp757
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -152($fp)	# spill _tmp757 from $t0 to $fp-152
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L69:
	# _tmp758 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp759 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp760 = _tmp759 + i
	  lw $t2, -72($fp)	# load i from $fp-72 into $t2
	  add $t3, $t1, $t2	
	# _tmp761 = _tmp758 * _tmp760
	  mul $t4, $t0, $t3	
	# _tmp762 = _tmp750 + _tmp761
	  lw $t5, -124($fp)	# load _tmp750 from $fp-124 into $t5
	  add $t6, $t5, $t4	
	# *(_tmp762) = _tmp744
	  lw $t7, -100($fp)	# load _tmp744 from $fp-100 into $t7
	  sw $t7, 0($t6) 	# store with offset
	# _tmp763 = 4
	  li $s0, 4		# load constant value 4 into $s0
	# _tmp764 = this + _tmp763
	  lw $s1, 4($fp)	# load this from $fp+4 into $s1
	  add $s2, $s1, $s0	
	# _tmp765 = *(_tmp764)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp766 = *(_tmp765)
	  lw $s4, 0($s3) 	# load with offset
	# _tmp767 = *(_tmp764)
	  lw $s5, 0($s2) 	# load with offset
	# _tmp768 = _tmp766 < i
	  slt $s6, $s4, $t2	
	# _tmp769 = _tmp766 == i
	  seq $s7, $s4, $t2	
	# _tmp770 = _tmp769 || _tmp768
	  or $t8, $s7, $s6	
	# _tmp771 = 0
	  li $t9, 0		# load constant value 0 into $t9
	# _tmp772 = i < _tmp771
	  slt $t5, $t2, $t9	
	# _tmp773 = _tmp770 || _tmp772
	  or $t2, $t8, $t5	
	# IfZ _tmp773 Goto _L70
	# (save modified registers before flow of control change)
	  sw $t0, -156($fp)	# spill _tmp758 from $t0 to $fp-156
	  sw $t1, -160($fp)	# spill _tmp759 from $t1 to $fp-160
	  sw $t2, -216($fp)	# spill _tmp773 from $t2 to $fp-216
	  sw $t3, -164($fp)	# spill _tmp760 from $t3 to $fp-164
	  sw $t4, -168($fp)	# spill _tmp761 from $t4 to $fp-168
	  sw $t5, -212($fp)	# spill _tmp772 from $t5 to $fp-212
	  sw $t6, -172($fp)	# spill _tmp762 from $t6 to $fp-172
	  sw $s0, -176($fp)	# spill _tmp763 from $s0 to $fp-176
	  sw $s2, -180($fp)	# spill _tmp764 from $s2 to $fp-180
	  sw $s3, -184($fp)	# spill _tmp765 from $s3 to $fp-184
	  sw $s4, -188($fp)	# spill _tmp766 from $s4 to $fp-188
	  sw $s5, -192($fp)	# spill _tmp767 from $s5 to $fp-192
	  sw $s6, -196($fp)	# spill _tmp768 from $s6 to $fp-196
	  sw $s7, -200($fp)	# spill _tmp769 from $s7 to $fp-200
	  sw $t8, -204($fp)	# spill _tmp770 from $t8 to $fp-204
	  sw $t9, -208($fp)	# spill _tmp771 from $t9 to $fp-208
	  beqz $t2, _L70	# branch if _tmp773 is zero 
	# _tmp774 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string52: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string52	# load label
	# PushParam _tmp774
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -220($fp)	# spill _tmp774 from $t0 to $fp-220
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L70:
	# _tmp775 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp776 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp777 = _tmp776 + i
	  lw $t2, -72($fp)	# load i from $fp-72 into $t2
	  add $t3, $t1, $t2	
	# _tmp778 = _tmp775 * _tmp777
	  mul $t4, $t0, $t3	
	# _tmp779 = _tmp767 + _tmp778
	  lw $t5, -192($fp)	# load _tmp767 from $fp-192 into $t5
	  add $t6, $t5, $t4	
	# _tmp780 = *(_tmp779)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp781 = *(_tmp780)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp782 = 0
	  li $s1, 0		# load constant value 0 into $s1
	# _tmp783 = _tmp782 + _tmp781
	  add $s2, $s1, $s0	
	# _tmp784 = *(_tmp783)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp785 = 1
	  li $s4, 1		# load constant value 1 into $s4
	# _tmp786 = i + _tmp785
	  add $s5, $t2, $s4	
	# PushParam _tmp786
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s5, 4($sp)	# copy param value to stack
	# _tmp787 = *(_tmp779)
	  lw $s6, 0($t6) 	# load with offset
	# PushParam _tmp787
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s6, 4($sp)	# copy param value to stack
	# ACall _tmp784
	# (save modified registers before flow of control change)
	  sw $t0, -224($fp)	# spill _tmp775 from $t0 to $fp-224
	  sw $t1, -228($fp)	# spill _tmp776 from $t1 to $fp-228
	  sw $t3, -232($fp)	# spill _tmp777 from $t3 to $fp-232
	  sw $t4, -236($fp)	# spill _tmp778 from $t4 to $fp-236
	  sw $t6, -240($fp)	# spill _tmp779 from $t6 to $fp-240
	  sw $t7, -244($fp)	# spill _tmp780 from $t7 to $fp-244
	  sw $s0, -248($fp)	# spill _tmp781 from $s0 to $fp-248
	  sw $s1, -252($fp)	# spill _tmp782 from $s1 to $fp-252
	  sw $s2, -256($fp)	# spill _tmp783 from $s2 to $fp-256
	  sw $s3, -260($fp)	# spill _tmp784 from $s3 to $fp-260
	  sw $s4, -264($fp)	# spill _tmp785 from $s4 to $fp-264
	  sw $s5, -268($fp)	# spill _tmp786 from $s5 to $fp-268
	  sw $s6, -272($fp)	# spill _tmp787 from $s6 to $fp-272
	  jalr $s3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp788 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp789 = i + _tmp788
	  lw $t1, -72($fp)	# load i from $fp-72 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp789
	  move $t1, $t2		# copy value
	# Goto _L67
	# (save modified registers before flow of control change)
	  sw $t0, -276($fp)	# spill _tmp788 from $t0 to $fp-276
	  sw $t1, -72($fp)	# spill i from $t1 to $fp-72
	  sw $t2, -280($fp)	# spill _tmp789 from $t2 to $fp-280
	  b _L67		# unconditional branch
  _L68:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllBets:
	# BeginFunc 228
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 228	# decrement sp to make space for locals/temps
	# _tmp790 = "\nFirst, let's take bets.\n"
	  .data			# create string constant marked with label
	  _string53: .asciiz "\nFirst, let's take bets.\n"
	  .text
	  la $t0, _string53	# load label
	# PushParam _tmp790
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp790 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp791 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp791
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp791 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
  _L71:
	# _tmp792 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp793 = this + _tmp792
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp794 = *(_tmp793)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp795 = *(_tmp794)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp796 = i < _tmp795
	  lw $t5, -16($fp)	# load i from $fp-16 into $t5
	  slt $t6, $t5, $t4	
	# IfZ _tmp796 Goto _L72
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp792 from $t0 to $fp-20
	  sw $t2, -24($fp)	# spill _tmp793 from $t2 to $fp-24
	  sw $t3, -28($fp)	# spill _tmp794 from $t3 to $fp-28
	  sw $t4, -32($fp)	# spill _tmp795 from $t4 to $fp-32
	  sw $t6, -36($fp)	# spill _tmp796 from $t6 to $fp-36
	  beqz $t6, _L72	# branch if _tmp796 is zero 
	# _tmp797 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp798 = this + _tmp797
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp799 = *(_tmp798)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp800 = *(_tmp799)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp801 = *(_tmp798)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp802 = _tmp800 < i
	  lw $t6, -16($fp)	# load i from $fp-16 into $t6
	  slt $t7, $t4, $t6	
	# _tmp803 = _tmp800 == i
	  seq $s0, $t4, $t6	
	# _tmp804 = _tmp803 || _tmp802
	  or $s1, $s0, $t7	
	# _tmp805 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp806 = i < _tmp805
	  slt $s3, $t6, $s2	
	# _tmp807 = _tmp804 || _tmp806
	  or $s4, $s1, $s3	
	# IfZ _tmp807 Goto _L73
	# (save modified registers before flow of control change)
	  sw $t0, -40($fp)	# spill _tmp797 from $t0 to $fp-40
	  sw $t2, -44($fp)	# spill _tmp798 from $t2 to $fp-44
	  sw $t3, -48($fp)	# spill _tmp799 from $t3 to $fp-48
	  sw $t4, -52($fp)	# spill _tmp800 from $t4 to $fp-52
	  sw $t5, -56($fp)	# spill _tmp801 from $t5 to $fp-56
	  sw $t7, -60($fp)	# spill _tmp802 from $t7 to $fp-60
	  sw $s0, -64($fp)	# spill _tmp803 from $s0 to $fp-64
	  sw $s1, -68($fp)	# spill _tmp804 from $s1 to $fp-68
	  sw $s2, -72($fp)	# spill _tmp805 from $s2 to $fp-72
	  sw $s3, -76($fp)	# spill _tmp806 from $s3 to $fp-76
	  sw $s4, -80($fp)	# spill _tmp807 from $s4 to $fp-80
	  beqz $s4, _L73	# branch if _tmp807 is zero 
	# _tmp808 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string54: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string54	# load label
	# PushParam _tmp808
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -84($fp)	# spill _tmp808 from $t0 to $fp-84
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L73:
	# _tmp809 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp810 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp811 = _tmp810 + i
	  lw $t2, -16($fp)	# load i from $fp-16 into $t2
	  add $t3, $t1, $t2	
	# _tmp812 = _tmp809 * _tmp811
	  mul $t4, $t0, $t3	
	# _tmp813 = _tmp801 + _tmp812
	  lw $t5, -56($fp)	# load _tmp801 from $fp-56 into $t5
	  add $t6, $t5, $t4	
	# _tmp814 = *(_tmp813)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp815 = *(_tmp814)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp816 = 16
	  li $s1, 16		# load constant value 16 into $s1
	# _tmp817 = _tmp816 + _tmp815
	  add $s2, $s1, $s0	
	# _tmp818 = *(_tmp817)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp819 = *(_tmp813)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp819
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# _tmp820 = ACall _tmp818
	# (save modified registers before flow of control change)
	  sw $t0, -88($fp)	# spill _tmp809 from $t0 to $fp-88
	  sw $t1, -92($fp)	# spill _tmp810 from $t1 to $fp-92
	  sw $t3, -96($fp)	# spill _tmp811 from $t3 to $fp-96
	  sw $t4, -100($fp)	# spill _tmp812 from $t4 to $fp-100
	  sw $t6, -104($fp)	# spill _tmp813 from $t6 to $fp-104
	  sw $t7, -108($fp)	# spill _tmp814 from $t7 to $fp-108
	  sw $s0, -112($fp)	# spill _tmp815 from $s0 to $fp-112
	  sw $s1, -116($fp)	# spill _tmp816 from $s1 to $fp-116
	  sw $s2, -120($fp)	# spill _tmp817 from $s2 to $fp-120
	  sw $s3, -124($fp)	# spill _tmp818 from $s3 to $fp-124
	  sw $s4, -128($fp)	# spill _tmp819 from $s4 to $fp-128
	  jalr $s3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp820 Goto _L74
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp820 from $t0 to $fp-132
	  beqz $t0, _L74	# branch if _tmp820 is zero 
	# _tmp821 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp822 = this + _tmp821
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp823 = *(_tmp822)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp824 = *(_tmp823)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp825 = *(_tmp822)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp826 = _tmp824 < i
	  lw $t6, -16($fp)	# load i from $fp-16 into $t6
	  slt $t7, $t4, $t6	
	# _tmp827 = _tmp824 == i
	  seq $s0, $t4, $t6	
	# _tmp828 = _tmp827 || _tmp826
	  or $s1, $s0, $t7	
	# _tmp829 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp830 = i < _tmp829
	  slt $s3, $t6, $s2	
	# _tmp831 = _tmp828 || _tmp830
	  or $s4, $s1, $s3	
	# IfZ _tmp831 Goto _L76
	# (save modified registers before flow of control change)
	  sw $t0, -136($fp)	# spill _tmp821 from $t0 to $fp-136
	  sw $t2, -140($fp)	# spill _tmp822 from $t2 to $fp-140
	  sw $t3, -144($fp)	# spill _tmp823 from $t3 to $fp-144
	  sw $t4, -148($fp)	# spill _tmp824 from $t4 to $fp-148
	  sw $t5, -152($fp)	# spill _tmp825 from $t5 to $fp-152
	  sw $t7, -156($fp)	# spill _tmp826 from $t7 to $fp-156
	  sw $s0, -160($fp)	# spill _tmp827 from $s0 to $fp-160
	  sw $s1, -164($fp)	# spill _tmp828 from $s1 to $fp-164
	  sw $s2, -168($fp)	# spill _tmp829 from $s2 to $fp-168
	  sw $s3, -172($fp)	# spill _tmp830 from $s3 to $fp-172
	  sw $s4, -176($fp)	# spill _tmp831 from $s4 to $fp-176
	  beqz $s4, _L76	# branch if _tmp831 is zero 
	# _tmp832 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string55: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string55	# load label
	# PushParam _tmp832
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -180($fp)	# spill _tmp832 from $t0 to $fp-180
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L76:
	# _tmp833 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp834 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp835 = _tmp834 + i
	  lw $t2, -16($fp)	# load i from $fp-16 into $t2
	  add $t3, $t1, $t2	
	# _tmp836 = _tmp833 * _tmp835
	  mul $t4, $t0, $t3	
	# _tmp837 = _tmp825 + _tmp836
	  lw $t5, -152($fp)	# load _tmp825 from $fp-152 into $t5
	  add $t6, $t5, $t4	
	# _tmp838 = *(_tmp837)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp839 = *(_tmp838)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp840 = 24
	  li $s1, 24		# load constant value 24 into $s1
	# _tmp841 = _tmp840 + _tmp839
	  add $s2, $s1, $s0	
	# _tmp842 = *(_tmp841)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp843 = *(_tmp837)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp843
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# ACall _tmp842
	# (save modified registers before flow of control change)
	  sw $t0, -184($fp)	# spill _tmp833 from $t0 to $fp-184
	  sw $t1, -188($fp)	# spill _tmp834 from $t1 to $fp-188
	  sw $t3, -192($fp)	# spill _tmp835 from $t3 to $fp-192
	  sw $t4, -196($fp)	# spill _tmp836 from $t4 to $fp-196
	  sw $t6, -200($fp)	# spill _tmp837 from $t6 to $fp-200
	  sw $t7, -204($fp)	# spill _tmp838 from $t7 to $fp-204
	  sw $s0, -208($fp)	# spill _tmp839 from $s0 to $fp-208
	  sw $s1, -212($fp)	# spill _tmp840 from $s1 to $fp-212
	  sw $s2, -216($fp)	# spill _tmp841 from $s2 to $fp-216
	  sw $s3, -220($fp)	# spill _tmp842 from $s3 to $fp-220
	  sw $s4, -224($fp)	# spill _tmp843 from $s4 to $fp-224
	  jalr $s3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L74
	  b _L74		# unconditional branch
  _L74:
	# _tmp844 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp845 = i + _tmp844
	  lw $t1, -16($fp)	# load i from $fp-16 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp845
	  move $t1, $t2		# copy value
	# Goto _L71
	# (save modified registers before flow of control change)
	  sw $t0, -228($fp)	# spill _tmp844 from $t0 to $fp-228
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
	  sw $t2, -232($fp)	# spill _tmp845 from $t2 to $fp-232
	  b _L71		# unconditional branch
  _L72:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllTurns:
	# BeginFunc 232
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 232	# decrement sp to make space for locals/temps
	# _tmp846 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp846
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp846 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill i from $t1 to $fp-12
  _L77:
	# _tmp847 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp848 = this + _tmp847
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp849 = *(_tmp848)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp850 = *(_tmp849)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp851 = i < _tmp850
	  lw $t5, -12($fp)	# load i from $fp-12 into $t5
	  slt $t6, $t5, $t4	
	# IfZ _tmp851 Goto _L78
	# (save modified registers before flow of control change)
	  sw $t0, -16($fp)	# spill _tmp847 from $t0 to $fp-16
	  sw $t2, -20($fp)	# spill _tmp848 from $t2 to $fp-20
	  sw $t3, -24($fp)	# spill _tmp849 from $t3 to $fp-24
	  sw $t4, -28($fp)	# spill _tmp850 from $t4 to $fp-28
	  sw $t6, -32($fp)	# spill _tmp851 from $t6 to $fp-32
	  beqz $t6, _L78	# branch if _tmp851 is zero 
	# _tmp852 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp853 = this + _tmp852
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp854 = *(_tmp853)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp855 = *(_tmp854)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp856 = *(_tmp853)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp857 = _tmp855 < i
	  lw $t6, -12($fp)	# load i from $fp-12 into $t6
	  slt $t7, $t4, $t6	
	# _tmp858 = _tmp855 == i
	  seq $s0, $t4, $t6	
	# _tmp859 = _tmp858 || _tmp857
	  or $s1, $s0, $t7	
	# _tmp860 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp861 = i < _tmp860
	  slt $s3, $t6, $s2	
	# _tmp862 = _tmp859 || _tmp861
	  or $s4, $s1, $s3	
	# IfZ _tmp862 Goto _L79
	# (save modified registers before flow of control change)
	  sw $t0, -36($fp)	# spill _tmp852 from $t0 to $fp-36
	  sw $t2, -40($fp)	# spill _tmp853 from $t2 to $fp-40
	  sw $t3, -44($fp)	# spill _tmp854 from $t3 to $fp-44
	  sw $t4, -48($fp)	# spill _tmp855 from $t4 to $fp-48
	  sw $t5, -52($fp)	# spill _tmp856 from $t5 to $fp-52
	  sw $t7, -56($fp)	# spill _tmp857 from $t7 to $fp-56
	  sw $s0, -60($fp)	# spill _tmp858 from $s0 to $fp-60
	  sw $s1, -64($fp)	# spill _tmp859 from $s1 to $fp-64
	  sw $s2, -68($fp)	# spill _tmp860 from $s2 to $fp-68
	  sw $s3, -72($fp)	# spill _tmp861 from $s3 to $fp-72
	  sw $s4, -76($fp)	# spill _tmp862 from $s4 to $fp-76
	  beqz $s4, _L79	# branch if _tmp862 is zero 
	# _tmp863 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string56: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string56	# load label
	# PushParam _tmp863
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -80($fp)	# spill _tmp863 from $t0 to $fp-80
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L79:
	# _tmp864 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp865 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp866 = _tmp865 + i
	  lw $t2, -12($fp)	# load i from $fp-12 into $t2
	  add $t3, $t1, $t2	
	# _tmp867 = _tmp864 * _tmp866
	  mul $t4, $t0, $t3	
	# _tmp868 = _tmp856 + _tmp867
	  lw $t5, -52($fp)	# load _tmp856 from $fp-52 into $t5
	  add $t6, $t5, $t4	
	# _tmp869 = *(_tmp868)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp870 = *(_tmp869)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp871 = 16
	  li $s1, 16		# load constant value 16 into $s1
	# _tmp872 = _tmp871 + _tmp870
	  add $s2, $s1, $s0	
	# _tmp873 = *(_tmp872)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp874 = *(_tmp868)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp874
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# _tmp875 = ACall _tmp873
	# (save modified registers before flow of control change)
	  sw $t0, -84($fp)	# spill _tmp864 from $t0 to $fp-84
	  sw $t1, -88($fp)	# spill _tmp865 from $t1 to $fp-88
	  sw $t3, -92($fp)	# spill _tmp866 from $t3 to $fp-92
	  sw $t4, -96($fp)	# spill _tmp867 from $t4 to $fp-96
	  sw $t6, -100($fp)	# spill _tmp868 from $t6 to $fp-100
	  sw $t7, -104($fp)	# spill _tmp869 from $t7 to $fp-104
	  sw $s0, -108($fp)	# spill _tmp870 from $s0 to $fp-108
	  sw $s1, -112($fp)	# spill _tmp871 from $s1 to $fp-112
	  sw $s2, -116($fp)	# spill _tmp872 from $s2 to $fp-116
	  sw $s3, -120($fp)	# spill _tmp873 from $s3 to $fp-120
	  sw $s4, -124($fp)	# spill _tmp874 from $s4 to $fp-124
	  jalr $s3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp875 Goto _L80
	# (save modified registers before flow of control change)
	  sw $t0, -128($fp)	# spill _tmp875 from $t0 to $fp-128
	  beqz $t0, _L80	# branch if _tmp875 is zero 
	# _tmp876 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp877 = this + _tmp876
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp878 = *(_tmp877)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp879 = *(_tmp878)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp880 = *(_tmp877)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp881 = _tmp879 < i
	  lw $t6, -12($fp)	# load i from $fp-12 into $t6
	  slt $t7, $t4, $t6	
	# _tmp882 = _tmp879 == i
	  seq $s0, $t4, $t6	
	# _tmp883 = _tmp882 || _tmp881
	  or $s1, $s0, $t7	
	# _tmp884 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp885 = i < _tmp884
	  slt $s3, $t6, $s2	
	# _tmp886 = _tmp883 || _tmp885
	  or $s4, $s1, $s3	
	# IfZ _tmp886 Goto _L82
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp876 from $t0 to $fp-132
	  sw $t2, -136($fp)	# spill _tmp877 from $t2 to $fp-136
	  sw $t3, -140($fp)	# spill _tmp878 from $t3 to $fp-140
	  sw $t4, -144($fp)	# spill _tmp879 from $t4 to $fp-144
	  sw $t5, -148($fp)	# spill _tmp880 from $t5 to $fp-148
	  sw $t7, -152($fp)	# spill _tmp881 from $t7 to $fp-152
	  sw $s0, -156($fp)	# spill _tmp882 from $s0 to $fp-156
	  sw $s1, -160($fp)	# spill _tmp883 from $s1 to $fp-160
	  sw $s2, -164($fp)	# spill _tmp884 from $s2 to $fp-164
	  sw $s3, -168($fp)	# spill _tmp885 from $s3 to $fp-168
	  sw $s4, -172($fp)	# spill _tmp886 from $s4 to $fp-172
	  beqz $s4, _L82	# branch if _tmp886 is zero 
	# _tmp887 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string57: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string57	# load label
	# PushParam _tmp887
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -176($fp)	# spill _tmp887 from $t0 to $fp-176
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L82:
	# _tmp888 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp889 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp890 = _tmp889 + i
	  lw $t2, -12($fp)	# load i from $fp-12 into $t2
	  add $t3, $t1, $t2	
	# _tmp891 = _tmp888 * _tmp890
	  mul $t4, $t0, $t3	
	# _tmp892 = _tmp880 + _tmp891
	  lw $t5, -148($fp)	# load _tmp880 from $fp-148 into $t5
	  add $t6, $t5, $t4	
	# _tmp893 = *(_tmp892)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp894 = *(_tmp893)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp895 = 12
	  li $s1, 12		# load constant value 12 into $s1
	# _tmp896 = _tmp895 + _tmp894
	  add $s2, $s1, $s0	
	# _tmp897 = *(_tmp896)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp898 = 12
	  li $s4, 12		# load constant value 12 into $s4
	# _tmp899 = this + _tmp898
	  lw $s5, 4($fp)	# load this from $fp+4 into $s5
	  add $s6, $s5, $s4	
	# PushParam _tmp899
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s6, 4($sp)	# copy param value to stack
	# _tmp900 = *(_tmp892)
	  lw $s7, 0($t6) 	# load with offset
	# PushParam _tmp900
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s7, 4($sp)	# copy param value to stack
	# ACall _tmp897
	# (save modified registers before flow of control change)
	  sw $t0, -180($fp)	# spill _tmp888 from $t0 to $fp-180
	  sw $t1, -184($fp)	# spill _tmp889 from $t1 to $fp-184
	  sw $t3, -188($fp)	# spill _tmp890 from $t3 to $fp-188
	  sw $t4, -192($fp)	# spill _tmp891 from $t4 to $fp-192
	  sw $t6, -196($fp)	# spill _tmp892 from $t6 to $fp-196
	  sw $t7, -200($fp)	# spill _tmp893 from $t7 to $fp-200
	  sw $s0, -204($fp)	# spill _tmp894 from $s0 to $fp-204
	  sw $s1, -208($fp)	# spill _tmp895 from $s1 to $fp-208
	  sw $s2, -212($fp)	# spill _tmp896 from $s2 to $fp-212
	  sw $s3, -216($fp)	# spill _tmp897 from $s3 to $fp-216
	  sw $s4, -220($fp)	# spill _tmp898 from $s4 to $fp-220
	  sw $s6, -224($fp)	# spill _tmp899 from $s6 to $fp-224
	  sw $s7, -228($fp)	# spill _tmp900 from $s7 to $fp-228
	  jalr $s3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L80
	  b _L80		# unconditional branch
  _L80:
	# _tmp901 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp902 = i + _tmp901
	  lw $t1, -12($fp)	# load i from $fp-12 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp902
	  move $t1, $t2		# copy value
	# Goto _L77
	# (save modified registers before flow of control change)
	  sw $t0, -232($fp)	# spill _tmp901 from $t0 to $fp-232
	  sw $t1, -12($fp)	# spill i from $t1 to $fp-12
	  sw $t2, -236($fp)	# spill _tmp902 from $t2 to $fp-236
	  b _L77		# unconditional branch
  _L78:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.ResolveAllPlayers:
	# BeginFunc 264
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 264	# decrement sp to make space for locals/temps
	# _tmp903 = "\nTime to resolve bets.\n"
	  .data			# create string constant marked with label
	  _string58: .asciiz "\nTime to resolve bets.\n"
	  .text
	  la $t0, _string58	# load label
	# PushParam _tmp903
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp903 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp904 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp904
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp904 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
  _L83:
	# _tmp905 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp906 = this + _tmp905
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp907 = *(_tmp906)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp908 = *(_tmp907)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp909 = i < _tmp908
	  lw $t5, -16($fp)	# load i from $fp-16 into $t5
	  slt $t6, $t5, $t4	
	# IfZ _tmp909 Goto _L84
	# (save modified registers before flow of control change)
	  sw $t0, -20($fp)	# spill _tmp905 from $t0 to $fp-20
	  sw $t2, -24($fp)	# spill _tmp906 from $t2 to $fp-24
	  sw $t3, -28($fp)	# spill _tmp907 from $t3 to $fp-28
	  sw $t4, -32($fp)	# spill _tmp908 from $t4 to $fp-32
	  sw $t6, -36($fp)	# spill _tmp909 from $t6 to $fp-36
	  beqz $t6, _L84	# branch if _tmp909 is zero 
	# _tmp910 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp911 = this + _tmp910
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp912 = *(_tmp911)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp913 = *(_tmp912)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp914 = *(_tmp911)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp915 = _tmp913 < i
	  lw $t6, -16($fp)	# load i from $fp-16 into $t6
	  slt $t7, $t4, $t6	
	# _tmp916 = _tmp913 == i
	  seq $s0, $t4, $t6	
	# _tmp917 = _tmp916 || _tmp915
	  or $s1, $s0, $t7	
	# _tmp918 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp919 = i < _tmp918
	  slt $s3, $t6, $s2	
	# _tmp920 = _tmp917 || _tmp919
	  or $s4, $s1, $s3	
	# IfZ _tmp920 Goto _L85
	# (save modified registers before flow of control change)
	  sw $t0, -40($fp)	# spill _tmp910 from $t0 to $fp-40
	  sw $t2, -44($fp)	# spill _tmp911 from $t2 to $fp-44
	  sw $t3, -48($fp)	# spill _tmp912 from $t3 to $fp-48
	  sw $t4, -52($fp)	# spill _tmp913 from $t4 to $fp-52
	  sw $t5, -56($fp)	# spill _tmp914 from $t5 to $fp-56
	  sw $t7, -60($fp)	# spill _tmp915 from $t7 to $fp-60
	  sw $s0, -64($fp)	# spill _tmp916 from $s0 to $fp-64
	  sw $s1, -68($fp)	# spill _tmp917 from $s1 to $fp-68
	  sw $s2, -72($fp)	# spill _tmp918 from $s2 to $fp-72
	  sw $s3, -76($fp)	# spill _tmp919 from $s3 to $fp-76
	  sw $s4, -80($fp)	# spill _tmp920 from $s4 to $fp-80
	  beqz $s4, _L85	# branch if _tmp920 is zero 
	# _tmp921 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string59: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string59	# load label
	# PushParam _tmp921
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -84($fp)	# spill _tmp921 from $t0 to $fp-84
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L85:
	# _tmp922 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp923 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp924 = _tmp923 + i
	  lw $t2, -16($fp)	# load i from $fp-16 into $t2
	  add $t3, $t1, $t2	
	# _tmp925 = _tmp922 * _tmp924
	  mul $t4, $t0, $t3	
	# _tmp926 = _tmp914 + _tmp925
	  lw $t5, -56($fp)	# load _tmp914 from $fp-56 into $t5
	  add $t6, $t5, $t4	
	# _tmp927 = *(_tmp926)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp928 = *(_tmp927)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp929 = 16
	  li $s1, 16		# load constant value 16 into $s1
	# _tmp930 = _tmp929 + _tmp928
	  add $s2, $s1, $s0	
	# _tmp931 = *(_tmp930)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp932 = *(_tmp926)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp932
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# _tmp933 = ACall _tmp931
	# (save modified registers before flow of control change)
	  sw $t0, -88($fp)	# spill _tmp922 from $t0 to $fp-88
	  sw $t1, -92($fp)	# spill _tmp923 from $t1 to $fp-92
	  sw $t3, -96($fp)	# spill _tmp924 from $t3 to $fp-96
	  sw $t4, -100($fp)	# spill _tmp925 from $t4 to $fp-100
	  sw $t6, -104($fp)	# spill _tmp926 from $t6 to $fp-104
	  sw $t7, -108($fp)	# spill _tmp927 from $t7 to $fp-108
	  sw $s0, -112($fp)	# spill _tmp928 from $s0 to $fp-112
	  sw $s1, -116($fp)	# spill _tmp929 from $s1 to $fp-116
	  sw $s2, -120($fp)	# spill _tmp930 from $s2 to $fp-120
	  sw $s3, -124($fp)	# spill _tmp931 from $s3 to $fp-124
	  sw $s4, -128($fp)	# spill _tmp932 from $s4 to $fp-128
	  jalr $s3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp933 Goto _L86
	# (save modified registers before flow of control change)
	  sw $t0, -132($fp)	# spill _tmp933 from $t0 to $fp-132
	  beqz $t0, _L86	# branch if _tmp933 is zero 
	# _tmp934 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp935 = this + _tmp934
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp936 = *(_tmp935)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp937 = *(_tmp936)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp938 = *(_tmp935)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp939 = _tmp937 < i
	  lw $t6, -16($fp)	# load i from $fp-16 into $t6
	  slt $t7, $t4, $t6	
	# _tmp940 = _tmp937 == i
	  seq $s0, $t4, $t6	
	# _tmp941 = _tmp940 || _tmp939
	  or $s1, $s0, $t7	
	# _tmp942 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp943 = i < _tmp942
	  slt $s3, $t6, $s2	
	# _tmp944 = _tmp941 || _tmp943
	  or $s4, $s1, $s3	
	# IfZ _tmp944 Goto _L88
	# (save modified registers before flow of control change)
	  sw $t0, -136($fp)	# spill _tmp934 from $t0 to $fp-136
	  sw $t2, -140($fp)	# spill _tmp935 from $t2 to $fp-140
	  sw $t3, -144($fp)	# spill _tmp936 from $t3 to $fp-144
	  sw $t4, -148($fp)	# spill _tmp937 from $t4 to $fp-148
	  sw $t5, -152($fp)	# spill _tmp938 from $t5 to $fp-152
	  sw $t7, -156($fp)	# spill _tmp939 from $t7 to $fp-156
	  sw $s0, -160($fp)	# spill _tmp940 from $s0 to $fp-160
	  sw $s1, -164($fp)	# spill _tmp941 from $s1 to $fp-164
	  sw $s2, -168($fp)	# spill _tmp942 from $s2 to $fp-168
	  sw $s3, -172($fp)	# spill _tmp943 from $s3 to $fp-172
	  sw $s4, -176($fp)	# spill _tmp944 from $s4 to $fp-176
	  beqz $s4, _L88	# branch if _tmp944 is zero 
	# _tmp945 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string60: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string60	# load label
	# PushParam _tmp945
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -180($fp)	# spill _tmp945 from $t0 to $fp-180
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L88:
	# _tmp946 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp947 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp948 = _tmp947 + i
	  lw $t2, -16($fp)	# load i from $fp-16 into $t2
	  add $t3, $t1, $t2	
	# _tmp949 = _tmp946 * _tmp948
	  mul $t4, $t0, $t3	
	# _tmp950 = _tmp938 + _tmp949
	  lw $t5, -152($fp)	# load _tmp938 from $fp-152 into $t5
	  add $t6, $t5, $t4	
	# _tmp951 = *(_tmp950)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp952 = *(_tmp951)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp953 = 32
	  li $s1, 32		# load constant value 32 into $s1
	# _tmp954 = _tmp953 + _tmp952
	  add $s2, $s1, $s0	
	# _tmp955 = *(_tmp954)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp956 = 8
	  li $s4, 8		# load constant value 8 into $s4
	# _tmp957 = this + _tmp956
	  lw $s5, 4($fp)	# load this from $fp+4 into $s5
	  add $s6, $s5, $s4	
	# _tmp958 = *(_tmp957)
	  lw $s7, 0($s6) 	# load with offset
	# _tmp959 = *(_tmp958)
	  lw $t8, 0($s7) 	# load with offset
	# _tmp960 = 28
	  li $t9, 28		# load constant value 28 into $t9
	# _tmp961 = _tmp960 + _tmp959
	  add $t2, $t9, $t8	
	# _tmp962 = *(_tmp961)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp963 = *(_tmp957)
	  lw $s5, 0($s6) 	# load with offset
	# PushParam _tmp963
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s5, 4($sp)	# copy param value to stack
	# _tmp964 = ACall _tmp962
	# (save modified registers before flow of control change)
	  sw $t0, -184($fp)	# spill _tmp946 from $t0 to $fp-184
	  sw $t1, -188($fp)	# spill _tmp947 from $t1 to $fp-188
	  sw $t2, -244($fp)	# spill _tmp961 from $t2 to $fp-244
	  sw $t3, -192($fp)	# spill _tmp948 from $t3 to $fp-192
	  sw $t4, -196($fp)	# spill _tmp949 from $t4 to $fp-196
	  sw $t5, -248($fp)	# spill _tmp962 from $t5 to $fp-248
	  sw $t6, -200($fp)	# spill _tmp950 from $t6 to $fp-200
	  sw $t7, -204($fp)	# spill _tmp951 from $t7 to $fp-204
	  sw $s0, -208($fp)	# spill _tmp952 from $s0 to $fp-208
	  sw $s1, -212($fp)	# spill _tmp953 from $s1 to $fp-212
	  sw $s2, -216($fp)	# spill _tmp954 from $s2 to $fp-216
	  sw $s3, -220($fp)	# spill _tmp955 from $s3 to $fp-220
	  sw $s4, -224($fp)	# spill _tmp956 from $s4 to $fp-224
	  sw $s5, -252($fp)	# spill _tmp963 from $s5 to $fp-252
	  sw $s6, -228($fp)	# spill _tmp957 from $s6 to $fp-228
	  sw $s7, -232($fp)	# spill _tmp958 from $s7 to $fp-232
	  sw $t8, -236($fp)	# spill _tmp959 from $t8 to $fp-236
	  sw $t9, -240($fp)	# spill _tmp960 from $t9 to $fp-240
	  jalr $t5            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam _tmp964
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp965 = *(_tmp950)
	  lw $t1, -200($fp)	# load _tmp950 from $fp-200 into $t1
	  lw $t2, 0($t1) 	# load with offset
	# PushParam _tmp965
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp955
	  lw $t3, -220($fp)	# load _tmp955 from $fp-220 into $t3
	# (save modified registers before flow of control change)
	  sw $t0, -256($fp)	# spill _tmp964 from $t0 to $fp-256
	  sw $t2, -260($fp)	# spill _tmp965 from $t2 to $fp-260
	  jalr $t3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L86
	  b _L86		# unconditional branch
  _L86:
	# _tmp966 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp967 = i + _tmp966
	  lw $t1, -16($fp)	# load i from $fp-16 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp967
	  move $t1, $t2		# copy value
	# Goto _L83
	# (save modified registers before flow of control change)
	  sw $t0, -264($fp)	# spill _tmp966 from $t0 to $fp-264
	  sw $t1, -16($fp)	# spill i from $t1 to $fp-16
	  sw $t2, -268($fp)	# spill _tmp967 from $t2 to $fp-268
	  b _L83		# unconditional branch
  _L84:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PrintAllMoney:
	# BeginFunc 128
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 128	# decrement sp to make space for locals/temps
	# _tmp968 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp968
	  move $t1, $t0		# copy value
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp968 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill i from $t1 to $fp-12
  _L89:
	# _tmp969 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp970 = this + _tmp969
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp971 = *(_tmp970)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp972 = *(_tmp971)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp973 = i < _tmp972
	  lw $t5, -12($fp)	# load i from $fp-12 into $t5
	  slt $t6, $t5, $t4	
	# IfZ _tmp973 Goto _L90
	# (save modified registers before flow of control change)
	  sw $t0, -16($fp)	# spill _tmp969 from $t0 to $fp-16
	  sw $t2, -20($fp)	# spill _tmp970 from $t2 to $fp-20
	  sw $t3, -24($fp)	# spill _tmp971 from $t3 to $fp-24
	  sw $t4, -28($fp)	# spill _tmp972 from $t4 to $fp-28
	  sw $t6, -32($fp)	# spill _tmp973 from $t6 to $fp-32
	  beqz $t6, _L90	# branch if _tmp973 is zero 
	# _tmp974 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp975 = this + _tmp974
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp976 = *(_tmp975)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp977 = *(_tmp976)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp978 = *(_tmp975)
	  lw $t5, 0($t2) 	# load with offset
	# _tmp979 = _tmp977 < i
	  lw $t6, -12($fp)	# load i from $fp-12 into $t6
	  slt $t7, $t4, $t6	
	# _tmp980 = _tmp977 == i
	  seq $s0, $t4, $t6	
	# _tmp981 = _tmp980 || _tmp979
	  or $s1, $s0, $t7	
	# _tmp982 = 0
	  li $s2, 0		# load constant value 0 into $s2
	# _tmp983 = i < _tmp982
	  slt $s3, $t6, $s2	
	# _tmp984 = _tmp981 || _tmp983
	  or $s4, $s1, $s3	
	# IfZ _tmp984 Goto _L91
	# (save modified registers before flow of control change)
	  sw $t0, -36($fp)	# spill _tmp974 from $t0 to $fp-36
	  sw $t2, -40($fp)	# spill _tmp975 from $t2 to $fp-40
	  sw $t3, -44($fp)	# spill _tmp976 from $t3 to $fp-44
	  sw $t4, -48($fp)	# spill _tmp977 from $t4 to $fp-48
	  sw $t5, -52($fp)	# spill _tmp978 from $t5 to $fp-52
	  sw $t7, -56($fp)	# spill _tmp979 from $t7 to $fp-56
	  sw $s0, -60($fp)	# spill _tmp980 from $s0 to $fp-60
	  sw $s1, -64($fp)	# spill _tmp981 from $s1 to $fp-64
	  sw $s2, -68($fp)	# spill _tmp982 from $s2 to $fp-68
	  sw $s3, -72($fp)	# spill _tmp983 from $s3 to $fp-72
	  sw $s4, -76($fp)	# spill _tmp984 from $s4 to $fp-76
	  beqz $s4, _L91	# branch if _tmp984 is zero 
	# _tmp985 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string61: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string61	# load label
	# PushParam _tmp985
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -80($fp)	# spill _tmp985 from $t0 to $fp-80
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L91:
	# _tmp986 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp987 = 1
	  li $t1, 1		# load constant value 1 into $t1
	# _tmp988 = _tmp987 + i
	  lw $t2, -12($fp)	# load i from $fp-12 into $t2
	  add $t3, $t1, $t2	
	# _tmp989 = _tmp986 * _tmp988
	  mul $t4, $t0, $t3	
	# _tmp990 = _tmp978 + _tmp989
	  lw $t5, -52($fp)	# load _tmp978 from $fp-52 into $t5
	  add $t6, $t5, $t4	
	# _tmp991 = *(_tmp990)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp992 = *(_tmp991)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp993 = 20
	  li $s1, 20		# load constant value 20 into $s1
	# _tmp994 = _tmp993 + _tmp992
	  add $s2, $s1, $s0	
	# _tmp995 = *(_tmp994)
	  lw $s3, 0($s2) 	# load with offset
	# _tmp996 = *(_tmp990)
	  lw $s4, 0($t6) 	# load with offset
	# PushParam _tmp996
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s4, 4($sp)	# copy param value to stack
	# ACall _tmp995
	# (save modified registers before flow of control change)
	  sw $t0, -84($fp)	# spill _tmp986 from $t0 to $fp-84
	  sw $t1, -88($fp)	# spill _tmp987 from $t1 to $fp-88
	  sw $t3, -92($fp)	# spill _tmp988 from $t3 to $fp-92
	  sw $t4, -96($fp)	# spill _tmp989 from $t4 to $fp-96
	  sw $t6, -100($fp)	# spill _tmp990 from $t6 to $fp-100
	  sw $t7, -104($fp)	# spill _tmp991 from $t7 to $fp-104
	  sw $s0, -108($fp)	# spill _tmp992 from $s0 to $fp-108
	  sw $s1, -112($fp)	# spill _tmp993 from $s1 to $fp-112
	  sw $s2, -116($fp)	# spill _tmp994 from $s2 to $fp-116
	  sw $s3, -120($fp)	# spill _tmp995 from $s3 to $fp-120
	  sw $s4, -124($fp)	# spill _tmp996 from $s4 to $fp-124
	  jalr $s3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp997 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp998 = i + _tmp997
	  lw $t1, -12($fp)	# load i from $fp-12 into $t1
	  add $t2, $t1, $t0	
	# i = _tmp998
	  move $t1, $t2		# copy value
	# Goto _L89
	# (save modified registers before flow of control change)
	  sw $t0, -128($fp)	# spill _tmp997 from $t0 to $fp-128
	  sw $t1, -12($fp)	# spill i from $t1 to $fp-12
	  sw $t2, -132($fp)	# spill _tmp998 from $t2 to $fp-132
	  b _L89		# unconditional branch
  _L90:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PlayOneGame:
	# BeginFunc 244
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 244	# decrement sp to make space for locals/temps
	# _tmp999 = 26
	  li $t0, 26		# load constant value 26 into $t0
	# _tmp1000 = 12
	  li $t1, 12		# load constant value 12 into $t1
	# _tmp1001 = this + _tmp1000
	  lw $t2, 4($fp)	# load this from $fp+4 into $t2
	  add $t3, $t2, $t1	
	# _tmp1002 = *(_tmp1001)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp1003 = *(_tmp1002)
	  lw $t5, 0($t4) 	# load with offset
	# _tmp1004 = 12
	  li $t6, 12		# load constant value 12 into $t6
	# _tmp1005 = _tmp1004 + _tmp1003
	  add $t7, $t6, $t5	
	# _tmp1006 = *(_tmp1005)
	  lw $s0, 0($t7) 	# load with offset
	# _tmp1007 = *(_tmp1001)
	  lw $s1, 0($t3) 	# load with offset
	# PushParam _tmp1007
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s1, 4($sp)	# copy param value to stack
	# _tmp1008 = ACall _tmp1006
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp999 from $t0 to $fp-8
	  sw $t1, -12($fp)	# spill _tmp1000 from $t1 to $fp-12
	  sw $t3, -16($fp)	# spill _tmp1001 from $t3 to $fp-16
	  sw $t4, -20($fp)	# spill _tmp1002 from $t4 to $fp-20
	  sw $t5, -24($fp)	# spill _tmp1003 from $t5 to $fp-24
	  sw $t6, -28($fp)	# spill _tmp1004 from $t6 to $fp-28
	  sw $t7, -32($fp)	# spill _tmp1005 from $t7 to $fp-32
	  sw $s0, -36($fp)	# spill _tmp1006 from $s0 to $fp-36
	  sw $s1, -40($fp)	# spill _tmp1007 from $s1 to $fp-40
	  jalr $s0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1009 = _tmp1008 < _tmp999
	  lw $t1, -8($fp)	# load _tmp999 from $fp-8 into $t1
	  slt $t2, $t0, $t1	
	# IfZ _tmp1009 Goto _L92
	# (save modified registers before flow of control change)
	  sw $t0, -44($fp)	# spill _tmp1008 from $t0 to $fp-44
	  sw $t2, -48($fp)	# spill _tmp1009 from $t2 to $fp-48
	  beqz $t2, _L92	# branch if _tmp1009 is zero 
	# _tmp1010 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# _tmp1011 = this + _tmp1010
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp1012 = *(_tmp1011)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp1013 = *(_tmp1012)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp1014 = 8
	  li $t5, 8		# load constant value 8 into $t5
	# _tmp1015 = _tmp1014 + _tmp1013
	  add $t6, $t5, $t4	
	# _tmp1016 = *(_tmp1015)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp1017 = *(_tmp1011)
	  lw $s0, 0($t2) 	# load with offset
	# PushParam _tmp1017
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s0, 4($sp)	# copy param value to stack
	# ACall _tmp1016
	# (save modified registers before flow of control change)
	  sw $t0, -52($fp)	# spill _tmp1010 from $t0 to $fp-52
	  sw $t2, -56($fp)	# spill _tmp1011 from $t2 to $fp-56
	  sw $t3, -60($fp)	# spill _tmp1012 from $t3 to $fp-60
	  sw $t4, -64($fp)	# spill _tmp1013 from $t4 to $fp-64
	  sw $t5, -68($fp)	# spill _tmp1014 from $t5 to $fp-68
	  sw $t6, -72($fp)	# spill _tmp1015 from $t6 to $fp-72
	  sw $t7, -76($fp)	# spill _tmp1016 from $t7 to $fp-76
	  sw $s0, -80($fp)	# spill _tmp1017 from $s0 to $fp-80
	  jalr $t7            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L92
	  b _L92		# unconditional branch
  _L92:
	# _tmp1018 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp1019 = 8
	  li $t2, 8		# load constant value 8 into $t2
	# _tmp1020 = _tmp1019 + _tmp1018
	  add $t3, $t2, $t1	
	# _tmp1021 = *(_tmp1020)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp1021
	# (save modified registers before flow of control change)
	  sw $t1, -84($fp)	# spill _tmp1018 from $t1 to $fp-84
	  sw $t2, -88($fp)	# spill _tmp1019 from $t2 to $fp-88
	  sw $t3, -92($fp)	# spill _tmp1020 from $t3 to $fp-92
	  sw $t4, -96($fp)	# spill _tmp1021 from $t4 to $fp-96
	  jalr $t4            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1022 = "\nDealer starts. "
	  .data			# create string constant marked with label
	  _string62: .asciiz "\nDealer starts. "
	  .text
	  la $t0, _string62	# load label
	# PushParam _tmp1022
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -100($fp)	# spill _tmp1022 from $t0 to $fp-100
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1023 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp1024 = this + _tmp1023
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp1025 = *(_tmp1024)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp1026 = *(_tmp1025)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp1027 = 0
	  li $t5, 0		# load constant value 0 into $t5
	# _tmp1028 = _tmp1027 + _tmp1026
	  add $t6, $t5, $t4	
	# _tmp1029 = *(_tmp1028)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp1030 = 0
	  li $s0, 0		# load constant value 0 into $s0
	# PushParam _tmp1030
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s0, 4($sp)	# copy param value to stack
	# _tmp1031 = *(_tmp1024)
	  lw $s1, 0($t2) 	# load with offset
	# PushParam _tmp1031
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s1, 4($sp)	# copy param value to stack
	# ACall _tmp1029
	# (save modified registers before flow of control change)
	  sw $t0, -104($fp)	# spill _tmp1023 from $t0 to $fp-104
	  sw $t2, -108($fp)	# spill _tmp1024 from $t2 to $fp-108
	  sw $t3, -112($fp)	# spill _tmp1025 from $t3 to $fp-112
	  sw $t4, -116($fp)	# spill _tmp1026 from $t4 to $fp-116
	  sw $t5, -120($fp)	# spill _tmp1027 from $t5 to $fp-120
	  sw $t6, -124($fp)	# spill _tmp1028 from $t6 to $fp-124
	  sw $t7, -128($fp)	# spill _tmp1029 from $t7 to $fp-128
	  sw $s0, -132($fp)	# spill _tmp1030 from $s0 to $fp-132
	  sw $s1, -136($fp)	# spill _tmp1031 from $s1 to $fp-136
	  jalr $t7            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp1032 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp1033 = this + _tmp1032
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp1034 = *(_tmp1033)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp1035 = *(_tmp1034)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp1036 = 4
	  li $t5, 4		# load constant value 4 into $t5
	# _tmp1037 = _tmp1036 + _tmp1035
	  add $t6, $t5, $t4	
	# _tmp1038 = *(_tmp1037)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp1039 = 12
	  li $s0, 12		# load constant value 12 into $s0
	# _tmp1040 = this + _tmp1039
	  add $s1, $t1, $s0	
	# PushParam _tmp1040
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s1, 4($sp)	# copy param value to stack
	# _tmp1041 = *(_tmp1033)
	  lw $s2, 0($t2) 	# load with offset
	# PushParam _tmp1041
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s2, 4($sp)	# copy param value to stack
	# ACall _tmp1038
	# (save modified registers before flow of control change)
	  sw $t0, -140($fp)	# spill _tmp1032 from $t0 to $fp-140
	  sw $t2, -144($fp)	# spill _tmp1033 from $t2 to $fp-144
	  sw $t3, -148($fp)	# spill _tmp1034 from $t3 to $fp-148
	  sw $t4, -152($fp)	# spill _tmp1035 from $t4 to $fp-152
	  sw $t5, -156($fp)	# spill _tmp1036 from $t5 to $fp-156
	  sw $t6, -160($fp)	# spill _tmp1037 from $t6 to $fp-160
	  sw $t7, -164($fp)	# spill _tmp1038 from $t7 to $fp-164
	  sw $s0, -168($fp)	# spill _tmp1039 from $s0 to $fp-168
	  sw $s1, -172($fp)	# spill _tmp1040 from $s1 to $fp-172
	  sw $s2, -176($fp)	# spill _tmp1041 from $s2 to $fp-176
	  jalr $t7            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp1042 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp1043 = 12
	  li $t2, 12		# load constant value 12 into $t2
	# _tmp1044 = _tmp1043 + _tmp1042
	  add $t3, $t2, $t1	
	# _tmp1045 = *(_tmp1044)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp1045
	# (save modified registers before flow of control change)
	  sw $t1, -180($fp)	# spill _tmp1042 from $t1 to $fp-180
	  sw $t2, -184($fp)	# spill _tmp1043 from $t2 to $fp-184
	  sw $t3, -188($fp)	# spill _tmp1044 from $t3 to $fp-188
	  sw $t4, -192($fp)	# spill _tmp1045 from $t4 to $fp-192
	  jalr $t4            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1046 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp1047 = this + _tmp1046
	  lw $t1, 4($fp)	# load this from $fp+4 into $t1
	  add $t2, $t1, $t0	
	# _tmp1048 = *(_tmp1047)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp1049 = *(_tmp1048)
	  lw $t4, 0($t3) 	# load with offset
	# _tmp1050 = 12
	  li $t5, 12		# load constant value 12 into $t5
	# _tmp1051 = _tmp1050 + _tmp1049
	  add $t6, $t5, $t4	
	# _tmp1052 = *(_tmp1051)
	  lw $t7, 0($t6) 	# load with offset
	# _tmp1053 = 12
	  li $s0, 12		# load constant value 12 into $s0
	# _tmp1054 = this + _tmp1053
	  add $s1, $t1, $s0	
	# PushParam _tmp1054
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s1, 4($sp)	# copy param value to stack
	# _tmp1055 = *(_tmp1047)
	  lw $s2, 0($t2) 	# load with offset
	# PushParam _tmp1055
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $s2, 4($sp)	# copy param value to stack
	# ACall _tmp1052
	# (save modified registers before flow of control change)
	  sw $t0, -196($fp)	# spill _tmp1046 from $t0 to $fp-196
	  sw $t2, -200($fp)	# spill _tmp1047 from $t2 to $fp-200
	  sw $t3, -204($fp)	# spill _tmp1048 from $t3 to $fp-204
	  sw $t4, -208($fp)	# spill _tmp1049 from $t4 to $fp-208
	  sw $t5, -212($fp)	# spill _tmp1050 from $t5 to $fp-212
	  sw $t6, -216($fp)	# spill _tmp1051 from $t6 to $fp-216
	  sw $t7, -220($fp)	# spill _tmp1052 from $t7 to $fp-220
	  sw $s0, -224($fp)	# spill _tmp1053 from $s0 to $fp-224
	  sw $s1, -228($fp)	# spill _tmp1054 from $s1 to $fp-228
	  sw $s2, -232($fp)	# spill _tmp1055 from $s2 to $fp-232
	  jalr $t7            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp1056 = *(this)
	  lw $t0, 4($fp)	# load this from $fp+4 into $t0
	  lw $t1, 0($t0) 	# load with offset
	# _tmp1057 = 16
	  li $t2, 16		# load constant value 16 into $t2
	# _tmp1058 = _tmp1057 + _tmp1056
	  add $t3, $t2, $t1	
	# _tmp1059 = *(_tmp1058)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp1059
	# (save modified registers before flow of control change)
	  sw $t1, -236($fp)	# spill _tmp1056 from $t1 to $fp-236
	  sw $t2, -240($fp)	# spill _tmp1057 from $t2 to $fp-240
	  sw $t3, -244($fp)	# spill _tmp1058 from $t3 to $fp-244
	  sw $t4, -248($fp)	# spill _tmp1059 from $t4 to $fp-248
	  jalr $t4            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _GetYesOrNo:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# PushParam prompt
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# load prompt from $fp+4 into $t0
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1060 = " (y/n) "
	  .data			# create string constant marked with label
	  _string63: .asciiz " (y/n) "
	  .text
	  la $t0, _string63	# load label
	# PushParam _tmp1060
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp1060 from $t0 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1061 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# answer = _tmp1061
	  move $t1, $t0		# copy value
	# _tmp1062 = "Y"
	  .data			# create string constant marked with label
	  _string64: .asciiz "Y"
	  .text
	  la $t2, _string64	# load label
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam _tmp1062
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# _tmp1063 = LCall _StringEqual
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp1061 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill answer from $t1 to $fp-16
	  sw $t2, -20($fp)	# spill _tmp1062 from $t2 to $fp-20
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp1064 = "y"
	  .data			# create string constant marked with label
	  _string65: .asciiz "y"
	  .text
	  la $t1, _string65	# load label
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t2, -16($fp)	# load answer from $fp-16 into $t2
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp1064
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp1065 = LCall _StringEqual
	# (save modified registers before flow of control change)
	  sw $t0, -24($fp)	# spill _tmp1063 from $t0 to $fp-24
	  sw $t1, -28($fp)	# spill _tmp1064 from $t1 to $fp-28
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp1066 = _tmp1063 || _tmp1065
	  lw $t1, -24($fp)	# load _tmp1063 from $fp-24 into $t1
	  or $t2, $t1, $t0	
	# Return _tmp1066
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  main:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# _tmp1067 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp1067
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp1068 = LCall _Alloc
	# (save modified registers before flow of control change)
	  sw $t0, -8($fp)	# spill _tmp1067 from $t0 to $fp-8
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1069 = BJDeck
	  la $t1, BJDeck	# load label
	# *(_tmp1068) = _tmp1069
	  sw $t1, 0($t0) 	# store with offset
	# b = _tmp1068
	  move $t2, $t0		# copy value
	# _tmp1070 = *(_tmp1068)
	  lw $t3, 0($t0) 	# load with offset
	# _tmp1071 = 8
	  li $t4, 8		# load constant value 8 into $t4
	# _tmp1072 = _tmp1071 + _tmp1070
	  add $t5, $t4, $t3	
	# _tmp1073 = *(_tmp1072)
	  lw $t6, 0($t5) 	# load with offset
	# PushParam _tmp1068
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp1073
	# (save modified registers before flow of control change)
	  sw $t0, -12($fp)	# spill _tmp1068 from $t0 to $fp-12
	  sw $t1, -16($fp)	# spill _tmp1069 from $t1 to $fp-16
	  sw $t2, -20($fp)	# spill b from $t2 to $fp-20
	  sw $t3, -24($fp)	# spill _tmp1070 from $t3 to $fp-24
	  sw $t4, -28($fp)	# spill _tmp1071 from $t4 to $fp-28
	  sw $t5, -32($fp)	# spill _tmp1072 from $t5 to $fp-32
	  sw $t6, -36($fp)	# spill _tmp1073 from $t6 to $fp-36
	  jalr $t6            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
