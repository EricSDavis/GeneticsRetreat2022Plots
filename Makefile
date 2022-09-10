.PHONY: clean

objects :=\
	plots/hicMapExample01.pdf\
	plots/hicMapExample02.pdf\
	plots/hicMapExample03.pdf\
	plots/hicMapExample04.pdf\
	plots/hicMapExample05.pdf

all: $(objects)

clean:
	rm -rf $(objects)

plots/hicMapExample01.pdf\
plots/hicMapExample02.pdf\
plots/hicMapExample03.pdf\
plots/hicMapExample04.pdf\
plots/hicMapExample05.pdf:\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	scripts/hicMapExample.R
		Rscript scripts/hicMapExample.R
