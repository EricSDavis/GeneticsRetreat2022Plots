.PHONY: clean

objects :=\
	plots/hicMapExample01.pdf\
	plots/hicMapExample02.pdf\
	plots/hicMapExample03.pdf\
	plots/hicMapExample04.pdf\
	plots/hicMapExample05.pdf\
	plots/hicWithChromosomes.pdf

all: $(objects)

clean:
	rm -rf $(objects)

plots/hicMapExample01.pdf\
plots/hicMapExample02.pdf\
plots/hicMapExample03.pdf\
plots/hicMapExample04.pdf\
plots/hicMapExample05.pdf:\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	scripts/marinerColorPalettes.R\
	scripts/hicMapExample.R
		Rscript scripts/hicMapExample.R

plots/hicWithChromosomes.pdf:\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	scripts/marinerColorPalettes.R\
	scripts/hicWithChromosomes.R
		Rscript scripts/hicWithChromosomes.R