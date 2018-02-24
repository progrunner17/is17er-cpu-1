シミュレーターの使い方
"だいたいlogとnextでデバッグできるはずさ！"

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
	p or print  [対象](未完成)
		対象に指定した物の値を表示する
		対象 ::= pc | x0~x31 | f0~f31 |すべて表示all|メモリ（int型float型は別）
	        (pc(pcxも可)は16進数で表示。10進数で表示したいならpcd）
	l or log
		log n0 n1 (n0 n1はint型)と書くと現在の命令から数えてn0番目からn1番目までの命令とその時のレジスタの中身を"simulator.log"に書き出しながら全実行。
	o or opcode_next（未完成）
		指定した次のニーモニックまで実行。
	n or next
		next n　(nはint型)と打つと命令をn個実行
	c or continue(未完成)
		continue n　(nはint型)と打つと最初から数えてn番目の命令まで実行
	h or help
		この文章を表示する
	i orinitialize
		初期化
	q or quit
		シミュレータの終了

