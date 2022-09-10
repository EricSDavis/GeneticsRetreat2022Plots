## Load libraries
library(plotgardener)
library(InteractionSet)

## Define "mariner-sea" color palette
marinerSea <- 
  c("#1d2b5b", "#44548a", "#786898",
    "#c06b92", "#e47a8b", "#ffefae")

marinerSky <-
  c("#ffefae", "#ffe88a", "#ffd657",
    "#ffb760", "#ff9665", "#ff6e67",
    "#fa4061")

initialHic <- function(p = p) {
  ## Hi-C plots
  hic <- 
    plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
                  params = p,
                  half = "both",
                  draw = FALSE)
  return(hic)
}

## Define function for plotting region
plotRegion <- function(p = p, hic = hic, highlight=FALSE) {
  
  ## Hi-C plots
  hic2 <- 
    plotHicSquare(data = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
                  params = p,
                  half = "both")
  
  ## Annotate heatmap legend
  annoHeatmapLegend(plot = hic2,
                    params = p,
                    orientation = "v",
                    fontcolor = "black",
                    x = p$x + p$width + p$space,
                    width = p$space,
                    height = p$height*0.5)
  
  ## Label genome
  annoGenomeLabel(plot = hic2,
                  params = p,
                  y = p$y + p$height,
                  scale = "Mb")
  
  ## Label genome
  annoGenomeLabel(plot = hic2,
                  params = p,
                  axis = "y",
                  x = p$x,
                  just = c("right", "top"),
                  scale = "Mb")
  
  ## Define loop
  loop <- 
    GInteractions(GRanges("7:54750000-54825000"),
                  GRanges("7:55225000-55300000"))
  
  ## Annotate loop
  annoPixels(plot = hic,
             data = loop,
             shift = 0)
  
  ## Highlight loop
  if (highlight) {
    annoHighlight(plot = hic,
                  params = p,
                  chrom = as.character(seqnames(anchors(loop, 'first'))),
                  chromstart = start(anchors(loop, 'first')),
                  chromend = end(anchors(loop, 'first')))
    annoHighlight(plot = hic,
                  params = p,
                  chrom = as.character(seqnames(anchors(loop, 'second'))),
                  chromstart = start(anchors(loop, 'second')),
                  chromend = end(anchors(loop, 'second')))
  }
  
}

## Initialize page
pageCreate(width = 4, height = 4, showGuides = FALSE)

## Define common params
p <- pgParams(assembly = "hg38",
              
              ## Define region of interest
              chrom = "7",
              chromstart = 54660000,
              chromend = 55350000,
              
              ## Hi-C parameters
              resolution = 25e03,
              zrange = c(0, 1400),
              norm = "SCALE",
              palette = colorRampPalette(marinerSea),
              bg = marinerSea[1],
              
              ## Define reference point
              x = 0.5,
              y = 0.5,
              width = 3,
              height = 3,
              length = 3,
              space = 0.1)

## Initial Hi-C object
hic <- initialHic(p = p)

## Plot region
pageCreate(width = 4, height = 4, showGuides = FALSE)
plotRegion(p = p, hic = hic, highlight = TRUE)

## 10Kb resolution
pageCreate(width = 4, height = 4, showGuides = FALSE)
p$resolution <- 10e03
p$zrange <- c(0, 300)
plotRegion(p = p, hic = hic)


## 5Kb resolution
pageCreate(width = 4, height = 4, showGuides = FALSE)
p$resolution <- 5e03
p$zrange <- c(0, 100)
plotRegion(p = p, hic = hic)
