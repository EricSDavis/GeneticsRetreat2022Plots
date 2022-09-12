## Load libraries
library(plotgardener)
library(InteractionSet)

## Helper functions and globals
source("scripts/marinerColorPalettes.R")

## Define common params
p <- pgParams(assembly = "hg38",
              
              ## Define region of interest
              chrom = "7",
              chromstart = 54660000,
              chromend = 55350000,
              
              ## Hi-C parameters
              resolution = 5e03,
              zrange = c(0, 60),
              norm = "SCALE",
              palette = colorRampPalette(marinerSea),
              bg = marinerSea[1])

## Hi-C plot
pdf(file="plots/rectangleHic.pdf", width = 4, height = 3)
plotHicRectangle(data = "data/raw/hic/MEGA_K562_WT_0_inter.hic",
                 params = p)
dev.off()