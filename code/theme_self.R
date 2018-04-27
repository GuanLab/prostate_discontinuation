library(ggplot2)
theme_self <- function() {
  theme_bw() + 
    theme(axis.text = element_text(size = 10), legend.position = "bottom", panel.grid = element_blank()) + 
    theme(axis.title = element_text(size = 12, face = 'bold'), legend.text = element_text(size = 10), legend.title = element_text(size = 12, face = 'bold'))
}