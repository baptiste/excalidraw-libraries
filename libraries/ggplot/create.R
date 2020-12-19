setwd("~/Documents/github/excalidraw-libraries/libraries/ggplot")

library(devoutsvg)
library(ggplot2)

p <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) +
  geom_point() +
  theme() +
  labs(colour='cyl', 
       title='mtcars', 
       subtitle = 'theme(music = "vroom vroom")*', 
       caption = '*: not an actual command') 

devoutsvg::svgout('p.svg', width = 5, height=4)
print(p)
dev.off()
