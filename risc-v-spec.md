# RISC-V仕様書解説
IS17erCPU実験第1班コア係 五反田正太郎

## 変更履歴
- 2017-10-28
	- 命令一覧表を見やすいよう整形
	- 命令一覧に即値や実装の有無に関する項目を追加
	- 命令一覧表でlui,auipcが混ざっていたので修正。
	- jal命令でワード対応アドレスにするために imm<<1を imm<<2に修正変更
	- jalr命令で、下位2ビットを切り捨てる仕様に変更(元は1bit)
	- branch系命令で第3オペランドに即値としてラベルからword単位の符号付きoffsetを指定できるように変更。
- 2017-10-27
	- spec公開


## RV32I(subset)
(FENCE系,E系、CSR系命令をのぞいた37命令)

- word = 32bit
- レジスタ: PC,x0~x31,x0 == 0
- 即値は基本的に符号付きNbit整数
### 命令フォーマット


### 注意点


### 命令一覧

| 命令   | 形式                          | 解釈疑似コード                                     | 命令(即値)フォーマット| 規定即値 | 実装の有無 | 備考|
|:------|:-----------------------------|:-------------------------------------------------|:--------:|:--------:|:-----:|:--|
| lui   | _lui rd, imm_                | rd = imm << 12                                   |    U     |         |   ○   |   |
| auipc | _auipc rd, imm_              | rd = pc + imm << 12                              |    U     |         |   ○   |   |
| jal   | _jal rd, imm_                | rd = pc + 4  ,pc = pc + imm<<2                   |    J     |         |   ○   |   |
| jalr  | _jalr rd, rs1, imm_          | rd = pc + 4  ,pc = (rs1 + imm)(下位2bit切り捨て)   |    I     |         |   ○   |   |
| beq   | _beq rs1, rs2, pc + imm<<2_  | pc = (rs1 == rs2) ? pc + imm<<2 : pc + 4         |    B     |         |   ○   |   |
| bne   | _bne rs1, rs2, pc + imm<<2_  | pc = (rs1 != rs2) ? pc + imm<<2 : pc + 4         |    B     |         |   ×   |   |
| blt   | _blt rs1, rs2, pc + imm<<2_  | pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4          |    B     |         |   ○   |   |
| bge   | _bge rs1, rs2, pc + imm<<2_  | pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4         |    B     |         |   ×   |   |
| bltu  | _bltu rs1, rs2, pc + imm<<2_ | pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4          |    B     |         |   ×   |   |
| bgeu  | _bgeu rs1, rs2, pc + imm<<2_ | pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4         |    B     |         |   ×   |   |
| lb    | _lb rd, imm(rs1)_            | rd =                                             |    I     |         |   ×   |   |
| lh    | _lh rd, imm(rs1)_            | rd =                                             |    I     |         |   ×   |   |
| lw    | _lw rd, imm(rs1)_            | rd = mem[rs1 + imm <<2]                          |    I     |         |   ○   |   |
| lbu   | _lbu rd, imm(rs1)_           | rd = {0,mem[addr]}                               |    I     |         |   ×   |   |
| lhu   | _lhu rd, imm(rs1)_           | rd = {0,mem[addr]}                               |    I     |         |   ×   |   |
| sb    | _sb rs2, imm(rs1)_           | mem[addr] = rs2[7:0]                             |    S     |         |   ×   |   |
| sh    | _sh rs2, imm(rs1)_           | mem[addr] = rs2[15:0]                            |    S     |         |   ×   |   |
| sw    | _sw rs2, imm(rs1)_           | mem[addr] = rs2                                  |    S     |         |   ○   |   |
| addi  | _addi rd, rs1, imm_          | rd = rs1 + imm                                   |    I     |         |   ○   |   |
| slti  | _slti rd, rs1, imm_          | rd = (rs1 < imm) ? 1 : 0                         |    I     |         |   ○   |   |
| sltiu | _sltiu rd, rs1, imm_         | rd = (rs1 < imm) ? 1 : 0                         |    I     |         |   ○   |   |
| xori  | _xori rd, rs1, imm_          | rd = rs1 ^ imm                                   |    I     |         |   ○   |   |
| ori   | _ori rd, rs1, imm_           | rd = rs1 \|  imm  							      |    I 	 |         |   ○   |   |
| andi  | _andi rd, rs1, imm_          | rd = rs1 & imm                                   |    I     |         |   ○   |   |
| slli  | _slli rd, rs1, imm_          | rd = rs1 << imm                                  |  I(5bit) |         |   ○   |   |
| srli  | _srli rd, rs1, imm_          | rd = rs1 >> imm                                  |  I(5bit) |         |   ○   |   |
| srai  | _srai rd, rs1, imm_          | rd = rs1 >>> imm                                 |  I(5bit) |         |   ○   |   |
| add   | _add rd, rs1, rs2_           | rd = rs1 + rs2                                   |    R     |         |   ○   |   |
| sub   | _sub rd, rs1, rs2_           | rd = rs1 - rs2                                   |    R     |         |   ○   |   |
| sll   | _sll rd, rs1, rs2_           | rd = rs1 << rs2                                  |    R     |         |   ○   |   |
| slt   | _slt rd, rs1, rs2_           | rd = (rs1 < rs2) ? 1:0                           |    R     |         |   ○   |   |
| sltu  | _sltu rd, rs1, rs2_          | rd = (rs1 < rs2) ? 1:0                           |    R     |         |   ○   |   |
| xor   | _xor rd, rs1, rs2_           | rd = rs1 ^ rs2                                   |    R     |         |   ○   |   |
| srl   | _srl rd, rs1, rs2_           | rd = rs1 >> rs2                                  |    R     |         |   ○   |   |
| sra   | _sra rd, rs1, rs2_           | rd = rs1 >>> rs2                                 |    R     |         |   ○   |   |
| or    | _or rd, rs1, rs2_            | rd = rs1 \|  rs2  							      |    R     |         |   ○   |   |
| and   | _and rd, rs1, rs2_           | rd = rs1 & rs2                             	  |    R     |         |   ○   |   |

##### ※細かい仕様の変更をした方が良さそう。


#### LUI命令
- オペコード:0b0010111
- 命令形式: _lui rd, imm_
- 意味: rd = imm << 12

20bit符号付き即値を左に12bitシフトした値を入れる。
 -2^11≤imm<2^11
addi命令の12bitの即値と合わせて1word = 32bitの即値を作る。
jalr命令(即値12bit)と組み合わせて遠方への相対ジャンプができる。
共にaddi,jalr命令共に符号付き整数なので、12bit目を1となるような値を得たい場合lui命令で1大きい値を指定し、引き算を行う。


#### AUIPC命令
- オペコード:0b0010111
- 命令形式: _auipc rd, imm_
- 意味: rd = pc + imm << 12


#### JAL命令
- オペコード:0b1101111
- funct3 0b000
- 命令形式: _jal rd, imm_
- 意味: rd = pc + 4  ,pc = pc + imm<<1

 アラインは要相談。（公式specではlsbのみアラインするため2の倍数であることしか保証されないので）

#### JALR命令
- オペコード:0b1100111
- funct3 0b000
- 命令形式: _jalr rd, rs1, imm_
- 意味: rd = pc + 4  ,pc = (rs1 + imm) ^  1


### BRANCH系命令
- オペコード:0b1100011
- 命令形式: _bcc rs1, rs2, pc + imm<<2_

	#### beq
	- funct3: 0b000
	- 意味:	pc = (rs1 == rs2) ? pc + imm<<2 : pc + 4

	#### bne
	- funct3: 0b001
	- 意味:	pc = (rs1 != rs2) ? pc + imm<<2 : pc + 4

	#### blt
	- funct3: 0b100
	- 意味:	pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4

	#### bge
	- funct3: 0b101
	- 意味:	pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4

	#### bltu
	- funct3: 0b110
	- 意味:	pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4

	#### bgeu
	- funct3: 0b111
	- 意味:	pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4

### LOAD系命令
- オペコード:	0b0000011
- 命令形式:	_lxx rd, imm(rs1)_

	#### lb
	- funct3 0b000
	- 意味: rd =

	#### lh
	- funct3 0b001
	- 意味: rd =

	#### lw
	- funct3 0b010
	- 意味: rd = {mem[addr]}

	#### lbu
	- funct3 0b100
	- 意味: rd = {0,mem[addr]}

	#### lhu
	- funct3 0b101
	- 意味: rd = {0,mem[addr]}

### STORE系命令
- オペコード:	0b0100011
- リトルエンディアン
	#### SB命令
	- funct3 0b000
	- 命令形式: _sb rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[7:0]

	#### SH命令
	- funct3 0b001
	- 命令形式: _sh rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[15:0]

	#### SW命令
	- funct3 0b010
	- 命令形式: _sw rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2

### OP-IMM系命令
- オペコード:0b0010011

	#### addi
	- funct3:	0b000
	- 命令形式: _addi rd, rs1, imm_
	- 意味:	rd = rs1 + imm

	#### slti
	- funct3:	0b010
	- 命令形式: _slti rd, rs1, imm_
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	#### sltiu
	- funct3:	0b011
	- 命令形式: _sltiu rd, rs1, imm_
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	#### xori
	- funct3:	0b100
	- 命令形式: _xori rd, rs1, imm_
	- 意味:	rd = rs1 ^ imm

	#### ori
	- funct3:	0b110
	- 命令形式: _ori rd, rs1, imm_
	- 意味:	rd = rs1 \| imm

	#### andi
	- funct3:	0b111
	- 命令形式: _andi rd, rs1, imm_
	- 意味:	rd = rs1 & imm

	#### slli
	- funct3:	0b001
	- 命令形式: _slli rd, rs1, imm_
	- 意味:	rd = rs1 << imm

	#### srli
	- funct3:	0b101
	- 命令形式: _srli rd, rs1, imm_
	- 意味:	rd = rs1 >> imm
	- 補足:	論理右シフト

	#### srai
	- funct3:	0b101
	- 命令形式: _srai rd, rs1, imm_
	- 意味:	rd = rs1 >>> imm
	- 補足: 算術右シフト

### OP系命令
- オペコード:0b0110011
- 命令形式:	_opcode rd, rs1, rs2_
	#### add
	- funct3:	0b000
	- 意味:	rd = rs1 + rs2

	#### sub
	- funct3:	0b000
	- 意味:	rd = rs1 - rs2

	#### sll
	- funct3:	0b001
	- 意味:	rd = rs1 << rs2

	#### slt
	- funct3:	0b010
	- 意味:	rd = (rs1 < rs2) ? 1:0

	#### sltu
	- funct3:	0b011
	- 意味:	rd = (rs1 < rs2) ? 1:0

	#### xor
	- funct3:	0b100
	- 意味:	rd = rs1 ^ rs2

	#### srl
	- funct3:	0b101
	- 意味:	rd = rs1 >> rs2
	論理シフト


	#### sra
	- funct3:	0b101
	- 意味:	rd = rs1 >>> rs2
	算術シフト

	#### or
	- funct3:	0b110
	- 意味:	rd = rs1 \| rs2

	#### and
	- funct3:	0b111
	- 意味:	rd = rs1 & rs2



## RV32F改

- 単精度(IEEE754)命令
- 浮動小数点専用レジスタ f0~f31
- f0 = 0

###命令一覧

###OP-FP命令
- オペコード:	0b1010011
	- fadd
		- funct7: 	0b00000000
	- fsub
		- funct7:	0b0000100
	- fmul
		- funct7:	0b0001000
	- fdiv
		- funct7:	0b0001100
	- fsqrt
		- funct7:	0b0101100
	- ftoi
		- funct7:	0b
	- itof
		- funct7:	0b
	- floor
		- funct7:	0b
	#### fsgn
	- funct7:	0b0010000
		- fabs
			- funct3: 	0b010
		- fneg
			- funct3:	0b001
		- fmv
			- funct3:	0b000

###CUSTOM-FP命令
- オペコード 0b0001011





