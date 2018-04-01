#install.packages("hexSticker")
library(hexSticker)
library(ggplot2)
pkg <- basename(getwd())
img <- "data-raw/hexsubplot.png"
out <- paste0(c("data-raw/", "inst/"), pkg, ".png")

hex_plot <- function(out, mult = 1){
  sticker(img, 1, 0.75, 0.45, 0.5, "rock", p_x = 0.575, p_size = mult * 28, p_color = "white", h_size = mult * 1.2, h_fill = "black",
          h_color = "seagreen1", url = paste0("leonawicz.github.io/", pkg), u_color = "white", u_size = mult * 3,
          filename = out)
  x <- last_plot() + geom_pkgname("chain", 1.335, 1.4, "seagreen1", "Aller_Rg", mult * 28)
  # overwrite file for larger size
  ggsave(out, x, width = mult*43.9, height = mult*50.8, bg = "transparent", units = "mm")
}

hex_plot(out[1], 4) # multiplier for larger sticker size
hex_plot(out[2])
