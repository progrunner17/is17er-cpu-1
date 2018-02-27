report.pdf: report.md
	pandoc report.md -o report.pdf --pdf-engine=xelatex -V mainfont=Hiragino\ Kaku\ Gothic\ Pro -V geometry:margin=1cm -V pagestyle=empty
