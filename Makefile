.PHONY: clean

objects :=\
	plots/hicMapExample01.pdf\
	plots/hicMapExample02.pdf\
	plots/hicMapExample03.pdf\
	plots/hicMapExample04.pdf\
	plots/hicMapExample05.pdf\
	plots/hicWithChromosomes.pdf\
	plots/rectangleHic.pdf\
	plots/squareHic.png\
	plots/squareHicSplit.png\
	plots/loopApaRegion.png\
	plots/loopApaCond1.png\
	plots/loopApaCond2.png

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
		
plots/rectangleHic.pdf:\
	data/raw/hic/MEGA_K562_WT_0_inter.hic\
	scripts/marinerColorPalettes.R\
	scripts/rectangleHic.R
		Rscript scripts/rectangleHic.R
		
plots/squareHic.png:\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	scripts/marinerColorPalettes.R\
	scripts/squareHic.R
		Rscript scripts/squareHic.R
		
plots/squareHicSplit.png:\
	data/raw/hic/MEGA_K562_WT_0_inter.hic\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	scripts/marinerColorPalettes.R\
	scripts/squareHicSplit.R
		Rscript scripts/squareHicSplit.R

plots/loopApaRegion.png\
plots/loopApaCond1.png\
plots/loopApaCond2.png:\
	data/raw/hic/MEGA_K562_WT_0_inter.hic\
	data/raw/hic/MEGA_K562_WT_4320_inter.hic\
	data/raw/loops/0_loops.txt\
	data/raw/loops/360_loops.txt\
	data/raw/loops/4320_loops.txt\
	scripts/marinerColorPalettes.R\
	scripts/loopApa.R
		Rscript scripts/loopApa.R