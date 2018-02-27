report.pdf: report.md
	pandoc report.md -o report.pdf --pdf-engine=xelatex -V geometry:margin=1cm -V mainfont=Hiragino\ Kaku\ Gothic\ Pro
