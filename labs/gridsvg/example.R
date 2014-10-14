setwd("~/github/qmssviz-FORK/labs/gridsvg")

library("grid")
library("gridSVG")
dev.off()

## create a grid scene consisting of two rectangles, one above the other.
topvp <- viewport(y=1, just="top", name="topvp", height=unit(1, "lines"))
botvp <- viewport(y=0, just="bottom", name="botvp", height=unit(1, "npc") - unit(1, "lines"))
grid.rect(gp=gpar(fill="grey"), vp=topvp, name="toprect")
grid.rect(vp=botvp, name="botrect")

## The main function in the gridSVG package is gridToSVG(), now called grid.export(). This function takes each graphical object (grob) in the current scene and converts it to one or more SVG elements.
grid.export("gridscene.svg")

# animation
## The grid.animate() function allows the components of a grid scene to be animated. For example, the following code animates the two rectangles in the simple grid scene above so that they both shrink to a width of 1 inch over a period of 3 seconds. The widths begin with a value of 1npc and end with a value of 1in.
widthValues <- unit(c(1,1), c("npc", "in"))
grid.animate("toprect", width=widthValues, duration=3)
grid.animate("botrect", width=widthValues, duration=3)
grid.export("gridanim.svg")

# interactivity
## The grid.hyperlink() function associates a hyperlink with a component of a grid scene. For example, the following code adds some text to the top rectangle in the simple grid scene so that when the text is clicked the web browser will navigate to the R home page (see Figure 4). Again, the component that is to be turned into a hyperlink is specified by name; in this case, it is the text component called "hypertext".
grid.text("take me there", vp=topvp, name="hypertext")
grid.hyperlink("hypertext", "http://www.r-project.org")
grid.export("gridhyper.svg")

# examples
library("lattice")
library("ggplot2")
library("reshape2")

# ggplot-svg example
iris.melt<-melt(iris, id.var="Species")
ggplot(iris.melt, aes(Species, value, group=Species)) +
  geom_boxplot() +
  facet_wrap(~variable, scale="free") +
  theme_bw()

# grid.hyperlink() function adds hyperlinks to the strip labels in the current plot.
grid.hyperlink("layout::strip_t-1.3-4-3-4.1",
               "http://en.wikipedia.org/wiki/Sepal")
grid.hyperlink("plot_01.textr.strip.1.2",
               "http://en.wikipedia.org/wiki/Sepal")
grid.hyperlink("plot_01.textr.strip.2.1",
               "http://en.wikipedia.org/wiki/Petal")
grid.hyperlink("plot_01.textr.strip.2.2",
               "http://en.wikipedia.org/wiki/Petal")

# The plot can now be converted to SVG using gridToSVG() so that clicking on the strip labels in a web browser will navigate to the relevant pages of Wikipedia.
grid.export("ggplothyper.svg")

# lattice-svg example
xyplot(Sepal.Length ~ Sepal.Width | Species, iris)

# grid.hyperlink() function adds hyperlinks to the strip labels in the current plot.
grid.hyperlink("plot_01.textr.strip.1.1",
               "http://en.wikipedia.org/wiki/Iris_flower_data_set")
grid.hyperlink("plot_01.textr.strip.1.2",
               "http://en.wikipedia.org/wiki/Iris_virginica")
grid.hyperlink("plot_01.textr.strip.2.1",
               "http://en.wikipedia.org/wiki/Iris_versicolor")

# The plot can now be converted to SVG using gridToSVG() so that clicking on the strip labels in a web browser will navigate to the relevant pages of Wikipedia.
grid.export("latticehyper.svg")
