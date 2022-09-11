## Load required libraries
library(strawr)
library(ggplot2)

## Extract data for all chromosomes
dat <-
  strawr::straw(norm = "NONE",
                fname = "data/raw/hic/MEGA_K562_WT_4320_inter.hic",
                chr1loc = "ALL",
                chr2loc = "ALL",
                unit = "BP",
                binsize = 6418,
                matrix = "observed") |>
  `colnames<-`(c("ALL1", "ALL2", "counts"))

## Fill in lower diagonal
dat <- 
  rbind(dat, cbind(ALL1 = dat$ALL2,
                   ALL2 = dat$ALL1,
                   counts = dat$counts))

## Visualize
ggplot(data = dat,
                aes(x = as.factor(ALL1), y = as.factor(ALL2), fill = counts)) +
  scale_fill_gradientn(colors = marinerSea,
                       limits = c(0, 20000), #83704
                       oob = scales::squish,
                       na.value = marinerSea[1])+
  geom_tile() +
  theme_void() +
  theme(aspect.ratio = 1)