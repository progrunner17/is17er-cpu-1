シミュレーターの使い方

COMAND_LINE_OPTION
（void parse_commandline_arg(int argc, char **argv);がコピペなので使い方はsim_coreと同様）

	-s ソースファイル名:	    アセンブリファイルを指定
	-o 出力ファイル名:		出力ファイル名 指定しないとsim.outに出力
	-i 入力ファイル名:		入力ファイル名 sldを指定する。
	-l ログファイル名:		ログファイル名 指定しないとstderrに出力
	権限次第で書き込めないかも？らしい

COMMAND
	r or run
		プログラムの全実行
	p or print  [対象]
		対象に指定した物の値を表示する
		対象 ::= pc | x0~x31 | f0~f31 |すべて表示all
	        (pc(pcxも可)は16進数で表示。10進数で表示したいならpcd）
	h or help
		この文章を表示する
	q or quit
		シミュレータの終了
