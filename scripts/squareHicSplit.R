## Load libraries
library(plotgardener)
library(InteractionSet)

## Helper functions and globals
source("scripts/marinerColorPalettes.R")

## Define common params
p <- pgParams(assembly = "hg38",
              
              ## Define region of interest
              chrom = "7",
              chromstart = 54660000 - 150e03,
              chromend = 55350000 + 150e03,
              
              ## Hi-C parameters
              resolution = 5e03,
              zrange = c(0, 100),
              norm = "SCALE",
              palette = colorRampPalette(marinerSea),
              
              ## Define reference point
              x = 0,
              y = 0,
              width = 5,
              height = 5,
              length = 5)

## Hi-C plot
png(file="plots/squareHicSplit.png", width = 5, height = 5, units = 'in', res = 300)
pageCreate(width = 5, height=5, showGuides = FALSE)
plotRect(params = p, fill = marinerSea[1], just = c('left', 'top'))
plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_0_inter.hic",
              params = p,
              half="top")
plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
              params = p,
              half="bottom")
dev.off()