PDFLATEX=env TEXINPUTS="~/Latex/beamer-theme;${TEXINPUTS}" latexmk -shell-escape -lualatex 
BIBTEX=bibtex
TEX=example.tex
PDF=$(TEX:.tex=.pdf)

all: $(PDF)

$(PDF): $(TEX) $(wildcard *.tex) $(wildcard *.bib)
	$(PDFLATEX) -output-directory=build -pvc $<; $(BIBTEX) $(<:.tex=); \
        for i in `seq 2`; do $(PDFLATEX) $<; done

check:
	@make -s clean; make -s all >/dev/null 2>&1; \
        echo "Checking with $(PDFLATEX) [$(TEX)]:"; $(PDFLATEX) $(TEX) | \
        grep "Overfull \\\hbox\|undefined on"; \
        echo "Checking with $(BIBTEX) [$(TEX)]:"; \
        $(BIBTEX) $(TEX:.tex=) | grep "Error\|Warning"; exit 0

clean:
	if [ -f build/$(PDF) ]; then mv build/$(PDF) .;	fi;
	rm -rf build
rm:
	make clean
	rm -f $(PDF)
