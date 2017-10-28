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
	- float系を再整備
	- 各命令の説明を追加
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

| 命令                | 形式                           | 解釈疑似コード                                    | 命令(即値)フォーマット | 規定即値 | 実装の有無 | 備考 |  |
|:------------------|:-----------------------------|:-------------------------------------------|:------------:|:----:|:-----:|:---|:-|
| [lui](#lui命令)     | _lui rd, imm_                | rd = imm << 12                             |      U       |      |   ○   |    |  |
| [auipc](#auipcC命令) | _auipc rd, imm_              | rd = pc + imm << 12                        |      U       |      |   ○   |    |  |
| [jal](#jal命令)     | _jal rd, imm_                | rd = pc + 4  ,pc = pc + imm<<2             |      J       |      |   ○   |    |  |
| [jalr](#jalr命令)   | _jalr rd, rs1, imm_          | rd = pc + 4  ,pc = (rs1 + imm)(下位2bit切り捨て) |      I       |      |   ○   |    |  |
| [beq](#beq)       | _beq rs1, rs2, pc + imm<<2_  | pc = (rs1 == rs2) ? pc + imm<<2 : pc + 4   |      B       |      |   ○   |    |  |
| [bne](#bne)       | _bne rs1, rs2, pc + imm<<2_  | pc = (rs1 != rs2) ? pc + imm<<2 : pc + 4   |      B       |      |   ×   |    |  |
| [blt](#blt)       | _blt rs1, rs2, pc + imm<<2_  | pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4    |      B       |      |   ○   |    |  |
| [bge]("bge")      | _bge rs1, rs2, pc + imm<<2_  | pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4   |      B       |      |   ×   |    |  |
| [bltu](#bltu)     | _bltu rs1, rs2, pc + imm<<2_ | pc = (rs1 < rs2) ? pc + imm<<2 : pc + 4    |      B       |      |   ×   |    |  |
| [bgeu](#bgeu)     | _bgeu rs1, rs2, pc + imm<<2_ | pc = (rs1 >= rs2) ? pc + imm<<2 : pc + 4   |      B       |      |   ×   |    |  |
| [lb](#lb)         | _lb rd, imm(rs1)_            | rd =                                       |      I       |      |   ×   |    |  |
| [lh](#lh)         | _lh rd, imm(rs1)_            | rd =                                       |      I       |      |   ×   |    |  |
| [lw](#lw)         | _lw rd, imm(rs1)_            | rd = mem[rs1 + imm <<2]                    |      I       |      |   ○   |    |  |
| [lbu](#lbu)       | _lbu rd, imm(rs1)_           | rd = {0,mem[addr]}                         |      I       |      |   ×   |    |  |
| [lhu](#lhu)       | _lhu rd, imm(rs1)_           | rd = {0,mem[addr]}                         |      I       |      |   ×   |    |  |
| [sb](#sb)         | _sb rs2, imm(rs1)_           | mem[addr] = rs2[7:0]                       |      S       |      |   ×   |    |  |
| [sh](#sh)         | _sh rs2, imm(rs1)_           | mem[addr] = rs2[15:0]                      |      S       |      |   ×   |    |  |
| [sw](#sw)         | _sw rs2, imm(rs1)_           | mem[addr] = rs2                            |      S       |      |   ○   |    |  |
| [addi](#addi)     | _addi rd, rs1, imm_          | rd = rs1 + imm                             |      I       |      |   ○   |    |  |
| [slti](#slti)     | _slti rd, rs1, imm_          | rd = (rs1 < imm) ? 1 : 0                   |      I       |      |   ○   |    |  |
| [sltiu](#sltiu)   | _sltiu rd, rs1, imm_         | rd = (rs1 < imm) ? 1 : 0                   |      I       |      |   ○   |    |  |
| [xori](#xori)     | _xori rd, rs1, imm_          | rd = rs1 ^ imm                             |      I       |      |   ○   |    |  |
| [ori](#ori)       | _ori rd, rs1, imm_           | rd = rs1 ｜imm                              |      I       |      |   ○   |    |  |
| [andi](#andi)     | _andi rd, rs1, imm_          | rd = rs1 & imm                             |      I       |      |   ○   |    |  |
| [slli](#slli)     | _slli rd, rs1, imm_          | rd = rs1 << imm                            |   I(5bit)    |      |   ○   |    |  |
| [srli](#srli)     | _srli rd, rs1, imm_          | rd = rs1 >> imm                            |   I(5bit)    |      |   ○   |    |  |
| [srai](#srai)     | _srai rd, rs1, imm_          | rd = rs1 >>> imm                           |   I(5bit)    |      |   ○   |    |  |
| [add](#add)       | _add rd, rs1, rs2_           | rd = rs1 + rs2                             |      R       |      |   ○   |    |  |
| [sub](#sub)       | _sub rd, rs1, rs2_           | rd = rs1 - rs2                             |      R       |      |   ○   |    |  |
| [sll](#sll)       | _sll rd, rs1, rs2_           | rd = rs1 << rs2                            |      R       |      |   ○   |    |  |
| [slt](#slt)       | _slt rd, rs1, rs2_           | rd = (rs1 < rs2) ? 1:0                     |      R       |      |   ○   |    |  |
| [sltu](#sltu)     | _sltu rd, rs1, rs2_          | rd = (rs1 < rs2) ? 1:0                     |      R       |      |   ○   |    |  |
| [xor](#xor)       | _xor rd, rs1, rs2_           | rd = rs1 ^ rs2                             |      R       |      |   ○   |    |  |
| [srl](#srl)       | _srl rd, rs1, rs2_           | rd = rs1 >> rs2                            |      R       |      |   ○   |    |  |
| [sra](#sra)       | _sra rd, rs1, rs2_           | rd = rs1 >>> rs2                           |      R       |      |   ○   |    |  |
| [or](#or)         | _or rd, rs1, rs2_            | rd = rs1 ｜rs2                              |      R       |      |   ○   |    |  |
| [and](#and)       | _and rd, rs1, rs2_           | rd = rs1 & rs2                             |      R       |      |   ○   |    |  |

##### ※細かい仕様の変更をした方が良さそう。


#### LUI命令
- オペコード:0b0010111
- 命令(即値)フォーマット: U
- 命令形式: _lui rd, imm_
- 意味: rd = imm << 12  

20bit符号付き即値を左に12bitシフトした値を入れる。
 -2^11≤imm<2^11
addi命令の12bitの即値と合わせて1word = 32bitの即値を作る。
jalr命令(即値12bit)と組み合わせて遠方への相対ジャンプができる。
共にaddi,jalr命令共に符号付き整数なので、12bit目を1となるような値を得たい場合lui命令で1大きい値を指定し、引き算を行う。


#### AUIPC命令
- オペコード:0b0010111
- 命令(即値)フォーマット: U
- 命令形式: _auipc rd, imm_
- 意味: rd = pc + imm << 12


#### JAL命令
- オペコード:0b1101111
- 命令(即値)フォーマット: J
- funct3 0b000
- 命令形式: _jal rd, imm_
- 意味: rd = pc + 4  ,pc = pc + imm<<2  
immは命令単位の差分を設定    
例えば_jal x0, 5_とすると5命令先にジャンプする。  

アセンブリの挙動としてはimm<<2の部分がISAと異なる気がするが
(ISAにアセンブリは詳しくかいてなかったから)、
即値のエンコーディングとしてはJのままにする。(つまり効果範囲は一緒だが、immに指定できる範囲は通常のJ-format即値の半分になる。)
結果としてinst[21]が常に0になり無駄だが仕方ない...

#### JALR命令
- オペコード:0b1100111
- 命令(即値)フォーマット: I
- funct3 0b000
- 命令形式: _jalr rd, rs1, imm_
- 意味: rd = pc + 4  ,pc = (rs1 +  imm<<2 ) &(~0b11)
&(~0b11)は要するに、下位2bitを切り捨てるという事。
もともとimmを2bitシフトする作用はないが、AUIPC命令でpcを取ってくる事を考えるとこの方がコンパイラがword単位で制御できるから楽そう。
これもJAL命令と同様に即値のフォーマット及びデコーディングはIのままにするのでinst[20:21]を0埋めにする分immに指定できる範囲は通常のI-formatと比べると4分の1になる。



### BRANCH系命令
- オペコード:0b1100011  
- 命令(即値)フォーマット: B
- これもimm<<2よりinst[8]を0埋めにする。
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
- 命令(即値)フォーマット: I
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
- 命令(即値)フォーマット: S
- リトルエンディアン
	#### sb
	- funct3 0b000
	- 命令形式: _sb rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[7:0]

	#### sh
	- funct3 0b001
	- 命令形式: _sh rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2[15:0]

	#### sw
	- funct3 0b010
	- 命令形式: _sw rs2, imm(rs1)_
	- 意味:	mem[addr] = rs2

### OP-IMM系命令
- オペコード:0b0010011
- 命令(即値)フォーマット: I
- 命令形式: _opcode rd, rs1, imm_

	#### addi
	- funct3:	0b000
	- 意味:	rd = rs1 + imm

	#### slti
	- funct3:	0b010
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	#### sltiu
	- funct3:	0b011
	- 意味:	rd = (rs1 < imm) ? 1 : 0

	#### xori
	- funct3:	0b100
	- 意味:	rd = rs1 ^ imm

	#### ori
	- funct3:	0b110
	- 意味:	rd = rs1 \| imm

	#### andi
	- funct3:	0b111
	- 意味:	rd = rs1 & imm

	#### slli
	- funct3:	0b001
	- 意味:	rd = rs1 << imm

	#### srli
	- funct3:	0b101
	- 意味:	rd = rs1 >> imm
	- 補足:	論理右シフト

	#### srai
	- funct3:	0b101
	- 意味:	rd = rs1 >>> imm
	- 補足: 算術右シフト

### OP系命令
- オペコード:0b0110011
- 命令(即値)フォーマット: R
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
	- f1~f10,f30、f31: 汎用レジスタ
	- f0,f11~f29: 定数
	#### 浮動小数点数 hard wired レジスタ一覧

| レジスタ名 | 値        | bit表現                  | 備考              |
|:------|:---------|:-----------------------|:----------------|
| f0    | 0.0      | 0x00000000(hard wired) | //LUI&ADDIで生成可能 |
| f11   | 1.0      | 0x3F800000(hard wired) | //LUIで生成可能      |
| f12   | 2.0      | 0x40000000(hard wired) | //LUIで生成可能      |
| f13   | 4.0      | 0x40800000(hard wired) | //LUIで生成可能      |
| f14   | 10.0     | 0x41200000(hard wired) | //LUIで生成可能      |
| f15   | 15.0     | 0x41700000(hard wired) | //LUIで生成可能      |
| f16   | 20.0     | 0x41A00000(hard wired) | //LUIで生成可能      |
| f17   | 128.0    | 0x43000000(hard wired) | //LUIで生成可能      |
| f18   | 200.0    | 0x43480000(hard wired) | //LUIで生成可能      |
| f19   | 255.0    | 0x437F0000(hard wired) | //LUIで生成可能      |
| f20   | 850.0    | 0x44548000(hard wired) | //LUIで生成可能      |
| f21   | 0.100    | 0x3DCCCCCD(hard wired) | //LUI&ADDIで生成可能 |
| f22   | 0.200    | 0x3E4CCCCD(hard wired) | //LUI&ADDIで生成可能 |
| f23   | 0.001    | 0x3A83126F(hard wired) | //LUI&ADDIで生成可能 |
| f24   | 0.005    | 0x3BA3D70A(hard wired) | //LUI&ADDIで生成可能 |
| f25   | 0.150    | 0x3E19999A(hard wired) | //LUI&ADDIで生成可能 |
| f26   | 0.250    | 0x3E800000(hard wired) | //LUIで生成可能      |
| f27   | 0.500    | 0x3F000000(hard wired) | //LUIで生成可能      |
| f28   | pi       | 0x40490FDB(hard wired) | //LUI&ADDIで生成可能 |
| f29   | 30.0 /pi | 0x4118C9EB(hard wired) | //LUI&ADDIで生成可能 |


### 命令一覧

| 命令      | 形式                  | 解釈疑似コード              |      レジスタ規定      | 実装の有無 | 備考 |
|:--------|:--------------------|:---------------------|:----------------:|:-----:|:---|
| flw     | _flw rd, imm(rs1)_  | rd = mem\[rs1+imm\]  |   rd:fn,rs1:xn   |   ○   |    |
| fsw     | _fsw rs2, imm(rs1)_ | mem\[rs1+imm\] = rs2 |  rs2:fn,rs1:xn   |   ○   |    |
| fadd    | _fadd rd, rs1, rs2_ | rd = rs1 +. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fsub    | _fsub rd, rs1, rs2_ | rd = rs1 -. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fmul    | _fmul rd, rs1, rs2_ | rd = rs1 *. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fdiv    | _fdiv rd, rs1, rs2_ | rd = rs1 /. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fsqrt   | _fsqrt rd, rs1_     | rd = sqrt(rs)        |     rd,rs:fn     |   ○   |    |
| fabs    | _fabs rd, rs1_      | rd = ｜rs｜            |     rd,rs:fn     |   ○   |    |
| fneg    | _fneg rd, rs1_      | rd = -rs             |     rd,rs:fn     |   ○   |    |
| feq     | _feq rd, rs1, rs2_  | rd = (rs1==rs2)?1:0  | rd:xn,rs1,rs2:fn |   ○   |    |
| flt     | _flt rd, rs1, rs2_  | rd = (rs1<rs2)?1:0   | rd:xn,rs1,rs2:fn |   ○   |    |
| fle     | _fle rd, rs1, rs2_  | rd = (rs1<=rs2)?1:0  | rd:xn,rs1,rs2:fn |   ○   |    |
| itof    | _itof rd, rs1_      | rd = (float) rs1     |   rd:fn,rs1:xn   |   ○   |    |
| ftoi    | _ftoi rd, rs1_      | rd = (int) rs2       |   rd:xn,rs1:fn   |   ○   |    |
| floor   | _floor rd, rs1_     | rd = [rs1]           |   rd:xn,rs1:fn   |   ○   |    |
| fmv.f.x | _fmv.f.x rd, rs1_   | rd = rs1             |   rd:fn,rs1:xn   |   ○   |    |
| fmv.x.f | _fmv.f.x rd, rs1_   | rd = rs1             |   rd:xn,rs1:fn   |   ○   |    |
| sin     | _sin rd, rs1_       | rd = sin(rs1)        |     rd,rs:fn     |   ×   |    |
| cos     | _cos rd, rs1_       | rd = cos(rs1)        |     rd,rs:fn     |   ×   |    |
| atan    | _atan rd, rs1_      | rd = atan(rs1)       |     rd,rs:fn     |   ×   |    |






