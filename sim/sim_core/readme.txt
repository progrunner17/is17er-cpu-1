シミュレーターの使い方


COMAND_LINE_OPTION
	-s ソースファイル名:	アセンブリファイルを指定
	-m 機械語ファイル名:	機械語を出力用ファイル名(comming soon)
	-o 出力ファイル名:		出力ファイル名(comming soon) 指定しないとsim.outに出力
	-i 入力ファイル名:		入力ファイル名(comming soon) 未対応
	-l ログファイル名:		ログファイル名(comming soon) 指定しないとstderrに出力
	権限次第で書き込めないかも？

COMMAND
	r or run
		プログラムの全実行
	c or continue
		プログラムをブレイクポイントの直前まで実行
	n or next [回数]
		回数分だけ命令を実行する。
		回数を省略すると1回実行
	h or help
		この文章を表示する。
	p or print  対象
		対象に指定した物の値を表示する
		対象 ::= pc | x0~x31 | f0~f31 |
	i or info 対象
		対象に指定した物の情報を指定する。
		対象 ::= x(整数レジスタ) | f(浮動小数点レジスタ) | r(レジスタ全体) | program or p (プログラム)
				| n or next(次命令) | l or label(ラベル一覧)
	s or set 対象 = 値
		対象に指定した物の値を更新する。
		対象 ::= pc | x1~x31 | f1~f10
		値 ::= 10進数,0x16進数,浮動小数点数
	q or quit
		シミュレータの終了