setwd("~/Documents/github/excalidraw-libraries/libraries/ggplot")

library(devoutsvg)
library(ggplot2)
library(glue)

p <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) +
  geom_point() +
  # geom_blank() +
  theme() +
  labs(colour='cyl', 
       title='mtcars', 
       subtitle = 'theme(music = "vroom vroom")*', 
       caption = '*: not an actual command') 
# 
# devoutsvg::svgout('p.svg', width = 5, height=4)
# print(p)
# dev.off()


library(glue)

tpl <- '
	<shape type="sphere">
	<point name="center" x="{x}" y="{y}" z="1"/> <float name="radius" value="{r}"/>
<bsdf type="conductor">
<string name="material" value="{m}"/>
</bsdf>
	</shape>
'

g <- ggplot_build(p)
params <- g$data[[1]]
xx <- g$data[[1]]$x
yy <- g$data[[1]]$y
#"#00BA38" "#F8766D"
# [3] "#619CFF"
params$m <- dplyr::recode(params$colour,  "#00BA38" = "Au",
                    "#F8766D" = "Cu" ,
                        "#619CFF" = "Cr" )
params$r <- scales::rescale(params$size, c(1,1))
params$x <- scales::rescale(-yy, c(20,80))
params$y <- scales::rescale(xx, c(-35,40))
  
cat(glue_data(params, tpl), file='_tmp.xml')
