# RISC-V仕様書解説
IS17erCPU実験第1班コア係 五反田正太郎

## 変更履歴 
- 2017-02-25
	- ftox等の表記の揺れを修正、三角関数等の未実装の命令を削除
- 2017-02-14
	- 即値等補足の追加や、無駄な説明の破棄
- 2017-12-5
	- fmv.x.fやfmv.f.xをftoxやxtofにニーモニックを変更
	- 末尾に入出力用命令ib(input byte)及びob(output byte)の説明を追加
- 2017-10-31
	- ワードアドレッシングへ対応
- 2017-10-29
	- 命令一覧表のsw,lwを修正
	- RV32Fの詳細を追加.
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

- オペコードの下位2bitは32bit命令なので0b11で固定

### 即値について

|type | format |range |
|:-:|:-:|:-:|
|U|20bit unsigned|0~524287|
|J|20bit signed| -262144~262143|
|B,S,I| 12bit signed |-2048~2047|

※B(S),Iは即値のエンコーディングが異なる。



### 命令一覧

| 命令                 | 形式                           | 解釈疑似コード                                 | 命令(即値)フォーマット | 規定即値 | 実装の有無 | 備考 |
|:-------------------|:-----------------------------|:----------------------------------------|:------------:|:----:|:-----:|:---|
| [lui](#lui命令)      | _lui rd, imm_                | rd = imm << 12,pc++                     |      U       |      |   ○   |    |
| [auipc](#auipcC命令) | _auipc rd, imm_              | rd = pc + (imm<<12),pc++                |      U       |      |   ○   |    |
| [jal](#jal命令)      | _jal rd, imm_                | rd = pc + 1  ,pc += imm                 |      J       |      |   ○   |    |
| [jalr](#jalr命令)    | _jalr rd, rs1, imm_          | rd = pc + 1  ,pc = rs1 + imm            |      I       |      |   ○   |    |
| [beq](#beq)        | _beq rs1, rs2, pc + imm<<2_  | if(rs1 == rs2)then pc += imm else pc++  |      B       |      |   ○   |    |
| [bne](#bne)        | _bne rs1, rs2, pc + imm<<2_  | if(rs1 != rs2)then pc += imm else pc++  |      B       |      |   ×   |    |
| [blt](#blt)        | _blt rs1, rs2, pc + imm<<2_  | if(rs1 < rs2) then pc += imm else pc++  |      B       |      |   ○   |    |
| [bge]("bge")       | _bge rs1, rs2, pc + imm<<2_  | if(rs1 >= rs2)then pc += imm else pc++  |      B       |      |   ×   |    |
| [bltu](#bltu)      | _bltu rs1, rs2, pc + imm<<2_ | if(rs1 < rs2) then pc += imm else  pc++ |      B       |      |   ×   |    |
| [bgeu](#bgeu)      | _bgeu rs1, rs2, pc + imm<<2_ | if(rs1 >= rs2)then pc += imm else pc++  |      B       |      |   ×   |    |
| [lb](#lb)          | _lb rd, imm(rs1)_            | rd =   ,pc++                            |      I       |      |   ×   |    |
| [lh](#lh)          | _lh rd, imm(rs1)_            | rd =              ,pc++                 |      I       |      |   ×   |    |
| [lw](#lw)          | _lw rd, imm(rs1)_            | rd = mem[rs1+imm] ,pc++                 |      I       |      |   ○   |    |
| [lbu](#lbu)        | _lbu rd, imm(rs1)_           | rd =              ,pc++                 |      I       |      |   ×   |    |
| [lhu](#lhu)        | _lhu rd, imm(rs1)_           | rd =                                    |      I       |      |   ×   |    |
| [sb](#sb)          | _sb rs2, imm(rs1)_           | ,pc++                                   |      S       |      |   ×   |    |
| [sh](#sh)          | _sh rs2, imm(rs1)_           | ,pc++                                   |      S       |      |   ×   |    |
| [sw](#sw)          | _sw rs2, imm(rs1)_           | mem[addr] = rs2 ,pc++                   |      S       |      |   ○   |    |
| [addi](#addi)      | _addi rd, rs1, imm_          | rd = rs1 + imm ,pc++                    |      I       |      |   ○   |    |
| [slti](#slti)      | _slti rd, rs1, imm_          | rd = (rs1 < imm) ? 1 : 0 ,pc++          |      I       |      |   ○   |    |
| [sltiu](#sltiu)    | _sltiu rd, rs1, imm_         | rd = (rs1 < imm) ? 1 : 0 ,pc++          |      I       |      |   ○   |    |
| [xori](#xori)      | _xori rd, rs1, imm_          | rd = rs1 ^ imm ,pc++                    |      I       |      |   ○   |    |
| [ori](#ori)        | _ori rd, rs1, imm_           | rd = rs1 ｜imm ,pc++                     |      I       |      |   ○   |    |
| [andi](#andi)      | _andi rd, rs1, imm_          | rd = rs1 & imm ,pc++                    |      I       |      |   ○   |    |
| [slli](#slli)      | _slli rd, rs1, imm_          | rd = rs1 << imm ,pc++                   |   I(5bit)    |      |   ○   |    |
| [srli](#srli)      | _srli rd, rs1, imm_          | rd = rs1 >> imm ,pc++                   |   I(5bit)    |      |   ○   |    |
| [srai](#srai)      | _srai rd, rs1, imm_          | rd = rs1 >>> imm ,pc++                  |   I(5bit)    |      |   ○   |    |
| [add](#add)        | _add rd, rs1, rs2_           | rd = rs1 + rs2 ,pc++                    |      R       |      |   ○   |    |
| [sub](#sub)        | _sub rd, rs1, rs2_           | rd = rs1 - rs2 ,pc++                    |      R       |      |   ○   |    |
| [sll](#sll)        | _sll rd, rs1, rs2_           | rd = rs1 << rs2 ,pc++                   |      R       |      |   ○   |    |
| [slt](#slt)        | _slt rd, rs1, rs2_           | rd = (rs1 < rs2) ? 1:0 ,pc++            |      R       |      |   ○   |    |
| [sltu](#sltu)      | _sltu rd, rs1, rs2_          | rd = (rs1 < rs2) ? 1:0 ,pc++            |      R       |      |   ○   |    |
| [xor](#xor)        | _xor rd, rs1, rs2_           | rd = rs1 ^ rs2 ,pc++                    |      R       |      |   ○   |    |
| [srl](#srl)        | _srl rd, rs1, rs2_           | rd = rs1 >> rs2 ,pc++                   |      R       |      |   ○   |    |
| [sra](#sra)        | _sra rd, rs1, rs2_           | rd = rs1 >>> rs2 ,pc++                  |      R       |      |   ○   |    |
| [or](#or)          | _or rd, rs1, rs2_            | rd = rs1 ｜rs2 ,pc++                     |      R       |      |   ○   |    |
| [and](#and)        | _and rd, rs1, rs2_           | rd = rs1 & rs2 ,pc++                    |      R       |      |   ○   |    |

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
- 意味: rd = pc + (imm << 12)


#### JAL命令
- オペコード:0b1101111
- 命令(即値)フォーマット: J
- funct3 0b000
- 命令形式: _jal rd, imm_
- 意味: rd = pc + 1  ,pc += imm
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
- 意味: rd = pc + 1  ,pc = rs1 + imm

### BRANCH系命令
- オペコード:0b1100011
- 命令(即値)フォーマット: B
- これもimm<<2よりinst[8]を0埋めにする。
- 命令形式: _bcc rs1, rs2, pc + imm<<2_

	#### beq
	- funct3: 0b000
	- 意味:	if(rs1 == rs2) pc += imm else pc++

	#### bne
	- funct3: 0b001
	- 意味:	if(rs1 != rs2) pc += imm else pc++

	#### blt
	- funct3: 0b100
	- 意味:	if(rs1 < rs2) pc += imm else pc++

	#### bge
	- funct3: 0b101
	- 意味:	if(rs1 >= rs2) pc += imm else pc++

	#### bltu
	- funct3: 0b110
	- 意味:	if(rs1 < rs2) pc += imm else pc++

	#### bgeu
	- funct3: 0b111
	- 意味:	if(rs1 >= rs2) pc += imm else pc++

### LOAD系命令
- オペコード:	0b0000011
- 命令(即値)フォーマット: I
- 命令形式:	_lxx rd, imm(rs1)_

	#### lb (未実装)
	- funct3 0b000
	- 意味: rd =

	#### lh (未実装)
	- funct3 0b001
	- 意味: rd =

	#### lw
	- funct3 0b010
	- 意味: rd = {mem[rs1+imm]}

	#### lbu (未実装)
	- funct3 0b100
	- 意味: rd = {0,mem[rs1+imm]}

	#### lhu (未実装)
	- funct3 0b101
	- 意味: rd = {0,mem[rs1+imm]}

### STORE系命令
- オペコード:	0b0100011
- 命令(即値)フォーマット: S
- リトルエンディアン
	#### sb (未実装)
	- funct3 0b000
	- 命令形式: _sb rs2, imm(rs1)_
	- 意味:	mem[rs1+imm] = rs2[7:0]

	#### sh (未実装)
	- funct3 0b001
	- 命令形式: _sh rs2, imm(rs1)_
	- 意味:	mem[rs1+imm] = rs2[15:0]

	#### sw
	- funct3 0b010
	- 命令形式: _sw rs2, imm(rs1)_
	- 意味:	mem[rs1+imm] = rs2

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

| 命令    | 形式                  | 解釈疑似コード              |      レジスタ規定      | 実装の有無 | 備考 |
|:------|:--------------------|:---------------------|:----------------:|:-----:|:---|
| flw   | _flw rd, imm(rs1)_  | rd = mem\[rs1+imm\]  |   rd:fn,rs1:xn   |   ○   |    |
| fsw   | _fsw rs2, imm(rs1)_ | mem\[rs1+imm\] = rs2 |  rs2:fn,rs1:xn   |   ○   |    |
| fadd  | _fadd rd, rs1, rs2_ | rd = rs1 +. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fsub  | _fsub rd, rs1, rs2_ | rd = rs1 -. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fmul  | _fmul rd, rs1, rs2_ | rd = rs1 *. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fdiv  | _fdiv rd, rs1, rs2_ | rd = rs1 /. rs2      |  rd,rs1,rs2:fn   |   ○   |    |
| fsqrt | _fsqrt rd, rs1_     | rd = sqrt(rs)        |     rd,rs:fn     |   ○   |    |
| fabs  | _fabs rd, rs1_      | rd = ｜rs｜            |     rd,rs:fn     |   ○   |    |
| fneg  | _fneg rd, rs1_      | rd = -rs             |     rd,rs:fn     |   ○   |    |
| feq   | _feq rd, rs1, rs2_  | rd = (rs1==rs2)?1:0  | rd:xn,rs1,rs2:fn |   ○   |    |
| flt   | _flt rd, rs1, rs2_  | rd = (rs1<rs2)?1:0   | rd:xn,rs1,rs2:fn |   ○   |    |
| fle   | _fle rd, rs1, rs2_  | rd = (rs1<=rs2)?1:0  | rd:xn,rs1,rs2:fn |   ○   |    |
| itof  | _itof rd, rs1_      | rd = (float) rs1     |   rd:fn,rs1:xn   |   ○   |    |
| ftoi  | _ftoi rd, rs1_      | rd = (int) rs2       |   rd:xn,rs1:fn   |   ○   |    |
| floor | _floor rd, rs1_     | rd = [rs1]           |   rd:xn,rs1:fn   |   ○   |    |
| xtof  | _xtof rd, rs1_   | rd = rs1             |   rd:fn,rs1:xn   |   ○   |    |
| ftox  | _ftox rd, rs1_   | rd = rs1             |   rd:xn,rs1:fn   |   ○   |    |


#### FLW命令
- オペコード:0b0000111
- funct3: 0b010
- 命令形式: flw rd, imm(rs1)
- レジスタ: rd:fn, rs1:xn
- 意味 rd = memory[addr]
- addr は


#### FSW命令
- オペコード:0b0100111
- funct3: 0b010
- 命令形式: fsw rs2, imm(rs1)
- レジスタ: rs2:fn,rs1:xn
- 意味 memory[addr] = imm
-

### FP系命令
- オペコード:0b0100111

#### fadd
- funct7:0b00000
- 命令形式: _fadd rd, rs1, rs2_
- レジスタ: rd,rs1,rs2:fn

#### fsub
- funct5:0b00001
- 命令形式: _fsub rd, rs1, rs2_
- レジスタ: rd,rs1,rs2:fn

#### fmul
- funct5:0b00010
- 命令形式: _fmul rd, rs1, rs2_
- レジスタ: rd,rs1,rs2:fn

#### fdiv
- funct5:0b00011
- 命令形式: _fadd rd, rs1, rs2_
- レジスタ: rd,rs1,rs2:fn

#### fsqrt
- funct5:0b01011
- 命令形式: _fsqrt rd, rs1_
- レジスタ: rd,rs1:fn

#### fsgnj系命令
- funct5:0b00100
- 命令形式: _opcode rd, rs1_
ただし、機械語へのエンコーディングは _fsgnj(x,n) rd, rs1, rs1_ と等しくなるように
- レジスタ: rd,rs1:fn

	#### fmv.f.f (fsgnj)
	- funct3: 0b000
	- 意味: rd = rs1

	#### fneg (fsgnjn)
	- funct3: 0b001
	- 意味: rd = -rs1

	#### fabs (fsgnjx)
	- funct3: 0b010
	- 意味: rd = \|rs1\|

#### ftoi
- funct5: 0b11000
- 命令形式: _ftoi(u) rd, rs1_
- レジスタ: rd:xn, rs1:fn
- 意味: rd = (int) rs1
- 補足:基本最近接だが、ちょうど小数部が0.5の時の丸めはCとは逆になる(IPコアのしよう)

#### ftox
- funct5: 0b11100
- funct3: 0b000
- rs2: 0b00000
- 命令形式: _ftox rd, rs1_
- レジスタ: float -> int
- 意味: rd = rs1 (xn = fn)
	(ビット列コピー)

#### float比較系命令
- funct5:0b10100
- 命令形式: _opcode rd, rs1, rs2_
- レジスタ: rd:xn, rs1,rs2:fn

	#### feq
	- funct3: 0b010
	- 意味: rd = (rs1 == rs2) ? 1 : 0

	#### flt
	- funct3: 0b001
	- 意味: rd = (rs1 < rs2) ? 1 : 0

	#### fle
	- funct3: 0b000
	- 意味: rd = (rs1 <= rs2) ? 1 : 0

#### itof
- funct5: 0b11010
- 命令形式: _itof rd, rs1_
- 型: float -> int
- 意味: rd = float rs1
- 補足:
	rs2 == 0b00000

#### xtof
- funct5: 0b11110
- funct3: 0b000
- rs2: 0b00000
- 命令形式: _xtof rd, rs1_
- レジスタ: int -> float
- 意味: rd = rs1 (fn = xn)
	(ビット列コピー)



## 入出力拡張命令
___xレジスタを使用___

### ob
- オペコード:0b0001011
- funct3: 0b000 (sbと同じ)
- 命令形式: _ob rs2_

output byteの略。例えば _ob x1_ とするとx1レジスタの下位8bitを出力

### ib
- オペコード:0b0101011
- funct3: 0b100 (lbuと同じ)
- 命令形式: _ib rd_

input byteの略。例えば _ib x1_ とすると8bitの入力を上位24bitゼロ拡張してx1に入れる。

