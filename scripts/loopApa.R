## Load required packages
library(data.table)
library(mariner)
library(GenomeInfoDb)
library(plotgardener)
library(GenomicRanges)
library(hictoolsr,
        include.only = c("filterBedpe",
                         "calcApa",
                         "plotApa"))

## Source helper functions/globals
source("scripts/marinerColorPalettes.R")
res <- 5e03
buffer <- 5

## List loop files for each timepoint
bedpeFiles <-
  list.files(path = "data/raw/loops",
             full.names = TRUE)

## Read in data and format as GInteractions
giList <-
  lapply(bedpeFiles, fread) |>
  lapply(as_ginteractions) |>
  setNames(gsub("[^0-9]+", "", bedpeFiles))

## Cluster and merge pairs
mgi <- 
  mergePairs(x = giList,
             radius = 10e03,
             method = "manhattan")

## De novo (must be in 72 but not in 0)
deNovo <-
  subsetBySource(x = mgi,
                 include = "4320",
                 exclude = "0")

## Assign to Hi-C bins
deNovo <- 
  binPairs(x = deNovo,
           binSize = res)


## Filter out short interactions
deNovo <- 
  as.data.table(deNovo) |>
  as_ginteractions() |>
  filterBedpe(res = res, buffer = buffer)

## Change chromosome style
seqlevelsStyle(deNovo) <- "ENSEMBL"

## Visualize -------------------------------------------------------------------

## Define common params
p <- pgParams(assembly = "hg38",
              
              ## Define region of interest
              chrom = "7",
              chromstart = 54660000 - 150e03,
              chromend = 55350000 + 150e03,
              resolution = res,
              zrange = c(0, 100),
              norm = "SCALE",
              palette = colorRampPalette(marinerSea),
              
              ## Define reference point
              x = 0,
              y = 0,
              width = 5,
              height = 5,
              length = 5,
              space = 0.1)

## Initialize page
png(filename = "plots/loopApaRegion.png",
    width = 5, height = 5, units = "in", res = 300)
pageCreate(width = 5, height = 5, showGuides = FALSE)

## Hi-C plots
plotRect(params = p, fill = marinerSea[1], just = c('left', 'top'))
top <- 
  plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_0_inter.hic",
                params = p,
                half = "top")
bottom <- 
  plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
                params = p,
                half = "bottom")

## Annotate loop pixels
annoPixels(plot = top,
           data = deNovo,
           shift = buffer,
           col = 'white',
           params = p)
annoPixels(plot = bottom,
           data = deNovo,
           shift = buffer,
           col = 'white',
           params = p)
dev.off()

## APA of deNovo loops ---------------------------------------------------------

## Subset for deNovo loops in region of interest
deNovoRegion <- 
  subsetByOverlaps(x = deNovo,
                   ranges = paste0(p$chrom, ":",
                                   p$chromstart, "-", 
                                   p$chromend) |>
                     GRanges())


## Calculate APA for each condition
cond1 <- 
  calcApa(bedpe = deNovoRegion,
          hic = "data/raw/hic/MEGA_K562_WT_0_inter.hic",
          norm = "NONE",
          res = res,
          buffer = buffer,
          matrix = "observed")

cond2 <- 
  calcApa(bedpe = deNovoRegion,
          hic = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
          norm = "NONE",
          res = res,
          buffer = buffer,
          matrix = "observed")

## Visualize
png(filename = "plots/loopApaCond1.png",
    width = 5, height = 5, units = 'in', res = 300)
plotApa(apa = cond1,
         palette = p$palette,
         zrange = c(0, max(c(cond1, cond2))))
dev.off()

png(filename = "plots/loopApaCond2.png",
    width = 5, height = 5, units = 'in', res = 300)
plotApa(apa = cond2,
         palette = p$palette,
         zrange = c(0, max(c(cond1, cond2))))
dev.off()