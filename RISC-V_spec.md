<!-- <style>
.container {
    max-width: 1300px;
    margin: 0 auto 20px auto;
}

img{
	width : 1000px;
}
</style>
 -->
# RISC-V仕様書解説
IS17erCPU実験第1班コア係 五反田正太郎

## RV32I(subset)
(FENCE系,E系、CSR系命令をのぞいた37命令)

- word = 32bit
- レジスタ: PC,x0~x31,x0 == 0
- 即値は基本的に符号付きNbit整数
###命令フォーマット
![フォーマット](./1.png)
###即値フォーマット
![フォーマット](./2.png)



###命令一覧

|命令|形式|疑似コード|
|--|--|--|
|auipc|_auipc rd, imm_|rd = pc + imm << 12|
|jal|_jal rd, imm_|rd = pc + 4  ,pc = pc + imm<<1|
|jalr|_jalr rd, rs1, imm_|rd = pc + 4  ,pc = (rs1 + imm) ^  1|
|beq|_beq rs1, rs2, label_|pc = (rs1 == rs2) ? label : pc + 4|
|bne|_bne rs1, rs2, label_|pc = (rs1 != rs2) ? label : pc + 4|
|blt|_blt rs1, rs2, label_|pc = (rs1 < rs2) ? label : pc + 4|
|bge|_bge rs1, rs2, label_|pc = (rs1 >= rs2) ? label : pc + 4|
|bltu|_bltu rs1, rs2, label_|pc = (rs1 < rs2) ? label : pc + 4|
|bgeu|_bgeu rs1, rs2, label_|pc = (rs1 >= rs2) ? label : pc + 4|
|lb|_lb rd, imm(rs1)_|rd = {sign,mem[addr]}|
|lh|_lh rd, imm(rs1)_|rd = {sign,mem[addr]}|
|lw|_lw rd, imm(rs1)_|rd = {mem[addr]}|
|lbu|_lbu rd, imm(rs1)_|rd = {0,mem[addr]}|
|lhu|_lhu rd, imm(rs1)_|rd = {0,mem[addr]}|
|sb|_sb rs2, imm(rs1)_|mem[addr] = rs2[7:0]|
|sh|_sh rs2, imm(rs1)_|mem[addr] = rs2[15:0]|
|sw|_sw rs2, imm(rs1)_|mem[addr] = rs2|
|addi|_addi rd, rs1, imm_|rd = rs1 + imm|
|slti|_slti rd, rs1, imm_|rd = (rs1 < imm) ? 1 : 0|
|sltiu|_sltiu rd, rs1, imm_|rd = (rs1 < imm) ? 1 : 0|
|xori|_xori rd, rs1, imm_|rd = rs1 ^ imm|
|ori|_ori rd, rs1, imm_|rd = rs1 \| imm|
|andi|_andi rd, rs1, imm_|rd = rs1 & imm|
|slli|_slli rd, rs1, imm_|rd = rs1 << imm|
|srli|_srli rd, rs1, imm_|rd = rs1 >> imm|
|srai|_srai rd, rs1, imm_|rd = rs1 >>> imm|
|add|_add rd, rs1, rs2_|rd = rs1 + rs2|
|sub|_sub rd, rs1, rs2_|rd = rs1 - rs2|
|sll|_sll rd, rs1, rs2_|rd = rs1 << rs2|
|slt|_slt rd, rs1, rs2_|rd = (rs1 < rs2) ? 1:0|
|sltu|_sltu rd, rs1, rs2_|rd = (rs1 < rs2) ? 1:0|
|xor|_xor rd, rs1, rs2_|rd = rs1 ^ rs2|
|srl|_srl rd, rs1, rs2_|rd = rs1 >> rs2|
|sra|_sra rd, rs1, rs2_|rd = rs1 >>> rs2|
|or|_or rd, rs1, rs2_|rd = rs1 \| rs2|
|and|_and rd, rs1, rs2_|rd = rs1 & rs2|

#####※細かい仕様の変更をした方が良さそう。
[問題点](##問題点)



####LUI命令
- オペコード:0b0010111
- 命令形式: _lui rd, imm_
- 意味: rd = imm << 12

20bit符号付き即値を左に12bitシフトした値を入れる。
 -2^11≤imm<2^11
addi命令の12bitの即値と合わせて1word = 32bitの即値を作る。
jalr命令(即値12bit)と組み合わせて遠方への相対ジャンプができる。
共にaddi,jalr命令共に符号付き整数なので、12bit目を1となるような値を得たい場合lui命令で1大きい値を指定し、引き算を行う。
####AUIPC命令
- オペコード:0b0010111
- 命令形式: _auipc rd, imm_
- 意味: rd = pc + imm << 12


####JAL命令
- オペコード:0b1101111
- funct3 0b000
- 命令形式: _jal rd, imm_
- 意味: rd = pc + 4  ,pc = pc + imm<<1

 アラインは要相談。（公式specではlsbのみアラインするため2の倍数であることしか保証されないので）

####JALR命令
- オペコード:0b1100111
- funct3 0b000
- 命令形式: _jalr rd, rs1, imm_
- 意味: rd = pc + 4  ,pc = (rs1 + imm) ^  1


###BRANCH命令
- オペコード:0b1100011
- 命令形式: _bcc rs1, rs2, label_

	####beq
	- funct3: 0b000
	- 意味:	pc = (rs1 == rs2) ? label : pc + 4

	####bne
	- funct3: 0b001
	- 意味:	pc = (rs1 != rs2) ? label : pc + 4

	####blt
	- funct3: 0b100
	- 意味:	pc = (rs1 < rs2) ? label : pc + 4

	####bge
	- funct3: 0b101
	- 意味:	pc = (rs1 >= rs2) ? label : pc + 4

	####bltu
	- funct3: 0b110
	- 意味:	pc = (rs1 < rs2) ? label : pc + 4

	####bgeu
	- funct3: 0b111
	- 意味:	pc = (rs1 >= rs2) ? label : pc + 4

###LOAD命令
- オペコード:	0b0000011
- 命令形式:	_lxx rd, imm(rs1)_

	####lb
	- funct3 0b000
	- 意味: rd = {sign,mem[addr]}

	####lh
	- funct3 0b001
	- 意味: rd = {sign,mem[addr]}

	####lw
	- funct3 0b010
	- 意味: rd = {mem[addr]}

	####lbu
	- funct3 0b100
	- 意味: rd = {0,mem[addr]}

	####lhu
	- funct3 0b101
	- 意味: rd = {0,mem[addr]}

###STORE命令
- オペコード:	0b0100011
- リトルエンディアン
	####SB命令
	- funct3 0b000
	- 命令形式: _sb rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[7:0]

	####SH命令
	- funct3 0b001
	- 命令形式: _sh rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[15:0]

	####SW命令
	- funct3 0b010
	- 命令形式: _sw rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2

###IMMEDIATE命令
- オペコード:0b0010011

	####ADDI命令
	- funct3:	0b000
	- 命令形式: _addi rd, rs1, imm_
	- 意味:	rd = rs1 + imm

	####SLTI命令
	- funct3:	0b010
	- 命令形式: _slti rd, rs1, imm_
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	####SLTIU命令
	- funct3:	0b011
	- 命令形式: _sltiu rd, rs1, imm_
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	####XORI命令
	- funct3:	0b100
	- 命令形式: _xori rd, rs1, imm_
	- 意味:	rd = rs1 ^ imm

	####ORI命令
	- funct3:	0b110
	- 命令形式: _ori rd, rs1, imm_
	- 意味:	rd = rs1 \| imm

	####ANDI命令
	- funct3:	0b111
	- 命令形式: _andi rd, rs1, imm_
	- 意味:	rd = rs1 & imm

	####SLLI命令
	- funct3:	0b001
	- 命令形式: _slli rd, rs1, imm_
	- 意味:	rd = rs1 << imm

	####SRLI命令
	- funct3:	0b101
	- 命令形式: _srli rd, rs1, imm_
	- 意味:	rd = rs1 >> imm
	- 補足:	論理右シフト

	####SRAI命令
	- funct3:	0b101
	- 命令形式: _srai rd, rs1, imm_
	- 意味:	rd = rs1 >>> imm
	- 補足: 算術右シフト

####ADD命令
- オペコード:0b0110011
- funct3 |
- 命令形式: add rd, rs1, rs2_|rd = rs1 + rs2

####SUB命令
- オペコード:同上
- funct3 |
- 命令形式: sub rd, rs1, rs2_|rd = rs1 - rs2

####SLL命令
- オペコード:同上
- funct3 |
- 命令形式: sll rd, rs1, rs2_|rd = rs1 << rs2

####SLT命令
- オペコード:同上
- funct3 |
- 命令形式: slt rd, rs1, rs2_|rd = (rs1 < rs2) ? 1:0

####SLTU命令
- オペコード:同上
- funct3 |
- 命令形式: sltu rd, rs1, rs2_|rd = (rs1 < rs2) ? 1:0

####XOR命令
- オペコード:同上
- funct3 |
- 命令形式: xor rd, rs1, rs2_|rd = rs1 ^ rs2

####SRL命令
- オペコード:同上
- funct3 |
- 命令形式: srl rd, rs1, rs2_|rd = rs1 >> rs2

####SRA命令
- オペコード:同上
- funct3 |
- 命令形式: sra rd, rs1, rs2_|rd = rs1 >>> rs2

####OR命令
- オペコード:同上
- funct3 |
- 命令形式: or rd, rs1, rs2_|rd = rs1 \| rs2

####AND命令
- オペコード:同上
- funct3 |
- 命令形式: and rd, rs1, rs2_|rd = rs1 & rs2



## RV32F改

###命令一覧


##問題点

