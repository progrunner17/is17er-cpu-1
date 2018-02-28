report.pdf: report.md
	pandoc report.md -o report.pdf --pdf-engine=xelatex -V mainfont=Hiragino\ Kaku\ Gothic\ Pro -V geometry:margin=1cm -V pagestyle=empty

report_mori.pdf: report_mori.md
	pandoc report_mori.md -o report_mori.pdf --pdf-engine=xelatex -V mainfont=Hiragino\ Kaku\ Gothic\ Pro -V geometry:margin=1cm -V pagestyle=empty
