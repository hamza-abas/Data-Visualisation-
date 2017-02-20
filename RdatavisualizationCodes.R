#----------Author---Abas-Hamza------------20/01/2017----

#In this Section I am going to describe and write the most useful functions to visualize and to manipulate, and I'll regroupe together a whole bunch of R visualization with base ploting system and ggpplot2 #


# Lest's start wih a data called Climate, We give the Rplot1 ---
# ------------------ Rplot1-----------------------------------#
#------------------------------------------------------------#

data(Climate)

# Let's sub´set the data by year 1900 and Source Berkeley
climatedata <- subset(climate, Source == "Berkeley", & Year >= 1900)

# We then creat a new column called prev inorder to know which value is positive
# and which one is not

climatedata$prev <- climatedata$Anomaly10y >= 0 
# Once we have the data, we can make the graph and map prev to the fill color


#  Making a Stacked Bar Graph----------------------------------
# ------------------ Rplot2-----------------------------------#
#------------------------------------------------------------#
data("cabbage_exp")
 ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar))
  +    geom_bar(stat="identity") +  ggtitle("Stacked Bar Graph")

# you can reverse the order of items in the legend by using guides() and specifying the aesthetic for which the legend should be reversed. In this case, it’s the fill aesthetic:

#  Making a Stacked Bar Graph----------------------------------
# ------------------ Rplot2b-----------------------------------#
#------------------------------------------------------------#

 ggplot(mpg, aes(x=manufacturer, fill=class)) + geom_bar()
> ggplot(mpg, aes(x=manufacturer, fill=class)) + geom_bar() + theme(axis.text.x = element_text(angle=60, hjust=1)
+ )


# Adding Labels to a Bar Graph----------------------------------
# ------------------ Rplot3-----------------------------------#
#------------------------------------------------------------#

ggplot(cabbage_exp, aes(x =interaction(Date, Cultivar), y = Weight))
 + geom_bar(stat = "identity") + geom_text(aes(label = Weight), vjust=-0.3)
 + ylim(0, max(cabbage_exp$Weight) * 1.05)

 
 #  Cleveland Dot Plot ----------------------------------
# ------------------ Rplot4-----------------------------------#
#------------------------------------------------------------#

# Cleveland Dot Plot is very handy, it creates a beautiful graph and easilly readable

ex :  ggplot(iris, aes(x = Species, y= Petal.Width)) + geom_point()

+ theme_bw()  # this will make the grey colour to White



 #  Cleveland Dot Plot part 2 ----------------------------------
# ------------------ Rplot5-----------------------------------#
#------------------------------------------------------------#

# To swap the axes so that the names go along the x-axis and the values go along the y-axis,

 ggplot(tophit, aes(x=reorder(name, avg), y=avg)) + 
    geom_point(size=3) +  theme_bw() + 
    theme(axis.text.x = element_text(angle=60, hjust=1),
     panel.grid.major.y = element_blank(), 
      panel.grid.major.x = element_line(colour="grey60", linetype="dashed")) 
 ggplot(tophit, aes(x=reorder(name, avg), y=avg)) +    geom_point(size=3, colour="blue") + 
  theme_bw() + theme(axis.text.x = element_text(angle=60, hjust=1), panel.grid.major.y = element_blank(),  panel.grid.major.x = element_line(colour="grey60", linetype="dashed"))


  #  Cleveland Dot Plot part 3 ----------------------------------
# ------------------ Rplot6-----------------------------------#
#------------------------------------------------------------#

#  group the items by 2 variable, We sort the variable name by 2 other variable

# Get the names, sorted first by lg, then by avg
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]


# Turn name into a factor, with levels in the order of nameorder

tophit$name <- factor(tophit$name, levels=nameorder)

ggplot(tophit, aes(x=avg, y=name)) +    
geom_segment(aes(yend=name), xend=0, colour="grey50") +   
 geom_point(size=3, aes(colour=lg)) +    
 scale_colour_brewer(palette="Set1", limits=c("NL","AL")) +   
  theme_bw() +   
  theme(panel.grid.major.y = element_blank(),   # No horizontal grid lines        
    legend.position=c(1, 0.55),             # Put legend inside plot area          
    legend.justification=c(1, 0.5))

    #  Cleveland Dot Plot part 4 ----------------------------------
# ------------------ Rplot7-----------------------------------#
#------------------------------------------------------------#

data(cars) # We are going to Creat a new plot

ggplot(cars, aes(x = reorder(dist, speed) , y= speed)) + 
geom_point(size=2, colour="red")  + 
theme(axis.text.x = element_text(angle=60, 
	hjust=1),panel.grid.major.y = element_blank(), 
    panel.grid.minor.y = element_blank(), 
    panel.grid.major.x = element_line(colour="grey60", 
    linetype="dashed"))

#  Making Line Graph----------------------------------
# ------------------ Rplot8-----------------------------------#
#------------------------------------------------------------#

#Line graph is suitable for continious variable both x axis and Y

ex: data(cars)

 ggplot(cars,aes(x=speed, y=dist)) + geom_line()
 #if the one of the value is a factor we add in aes group=1 So that ggplot knows
 # that the data comes from one dataset
  ggplot(cars,aes(x=speed, y=dist, group=1)) + geom_line()

  # Adding Points to a Line Graph
+ geom_point(colour="red")
# it always good practice to start the graph from the initial point 
+ ylim(0,cars$dist)


#   Scatter plots ----------------------------------
# ------------------ Rplot9-----------------------------------#
#------------------------------------------------------------#

#Scatter plot is used for continious variable both x and y

 ggplot(data, 
  aes(x=ageYear, y=heightIn, colour=sex, shape=sex)) + geom_point()

 # to plot by another continous variable

 ggplot(data, aes(x=ageYear, y=heightIn, colour=weightLb)) + geom_point()

 # When there are more than two continuous variables, they must be mapped to other aesthetics: size and/or color
 ggplot(data, aes(x=ageYear, y=heightIn, size=weightLb)) + geom_point()


#   Scatter plots ----------------------------------
# ------------------ Rplot9c-----------------------------------#
#------------------------------------------------------------#

#Scatter plot is used for continious variable both x and y
# When we mapping a continus V to a x axis or y , we use colour = , or fil

ggplot(iris, aes(x=Sepal.Length, y=Petal.Width, 
  colour=Petal.Length, shape=Species)) + geom_point()

#   Scatter plots ----------------------------------
# ------------------ Rplot10-----------------------------------#
#------------------------------------------------------------#

# this code displays the scatter plot using Linear model to predict the data

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, size=Petal.Length))
 + geom_point(alpha=.9) + stat_smooth(method = lm, level = 0.99)


 #   Scatter plots using logistic regression model for binary outcome data ----------------------------------
# ------------------ Rplot11-----------------------------------#
#------------------------------------------------------------#

 ggplot(dat, aes(x=mpg, y=vs)) + geom_point(position = position_jitter(width = 0.4,height = 0.02), size=2) 
 + stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

 #    marginal rugs  ----------------------------------
# ------------------ Rplot12-----------------------------------#
#------------------------------------------------------------#

#A rug is a one-dimensional density plot drawn on the axis of a plot.
# A marginal rug plot is essentially a one-dimensional scatter plot that 
# can be used to visualize the distribution of data on each axis.

ggplot(faithful, aes(x=eruptions, y=waiting)) 
+ geom_point() + geom_rug(position="jitter", size=.2)


 #     Labeling Points in a Scatter Plot ----------------------------------
# ------------------ Rplot13-----------------------------------#
#------------------------------------------------------------#

mydata$Name1 <- mydata$Name
idx <- mydata$Name1 %in% c("Canada", "Ireland", "United Kingdom", "United States", "New Zealand", "Iceland", "Japan", "Luxembourg", "Netherlands", "Switzerland"
  )
ggplot(mydata, aes(x=healthexp, y=infmortality)) 
+ geom_point()  + geom_text(aes(y=infmortality+.2,label=Name1), size=4, hjust=0) + xlim(2000,10000)

 #    Creating a Balloon Plot ----------------------------------
# ------------------ Rplot13b-----------------------------------#
#------------------------------------------------------------#


cdat <- subset(countries, Year==2009 &    Name %in% c("Canada", "Ireland", "United Kingdom", "United States",                "New Zealand", "Iceland", "Japan", "Luxembourg", "Netherlands", "Switzerland"))

# GDP mapped to radius (default with scale_size_continuous) 
ggplot(cdat, aes(x=healthexp, y=infmortality, size=GDP)) 
+  geom_point(shape=21, colour="black", fill="blue")

# GDP mapped to area instead, and larger circles  

+ scale_size_area(max_size=15)


#    Histograms ----------------------------------
# ------------------ Rplot14-----------------------------------#
#------------------------------------------------------------#

# EX : We are going to make hist plot and we map to a varible called Smoke 
# we first make that variable a factor,the data we are using comes form Mass library

birthwt$smoke <- factor(birthwt$smoke)
ggplot(birthwt, aes(x=bwt, fill=smoke)) + geom_histogram(position = "identity", alpha=.4)


#    Histograms , making density curve ----------------------------------
# ------------------ Rplot15-----------------------------------#
#------------------------------------------------------------#

ggplot(iris, aes(x=Sepal.Length)) + geom_density(color="blue") + theme_bw()

# If you don’t like the lines along the side and bottom, you can use geom_line(stat="den sity") 
## The expand_limits() increases the y range to include the value 0 

ggplot(iris, aes(x=Sepal.Length)) + geom_density(color="blue") 
+ theme_bw() + expand_limits(y=0)

#    Histograms , making density curve ----------------------------------
# ------------------ Rplot15b-----------------------------------#
#------------------------------------------------------------#

# To fill the ´density 
ggplot(iris, aes(x=Sepal.Length))
 + geom_density(color="blue", fill="blue", alpha=.6) + theme_bw()


 #    Histograms , making density curve ----------------------------------
# ------------------ Rplot15d-----------------------------------#
#------------------------------------------------------------#

# histogram with densi´ty 

ggplot(iris, aes(x=Sepal.Length, y=..density..)) 
+ geom_histogram(fill="blue", alpha=.2, binwidth = .1)
 + geom_density() + geom_line(stat = "density")


 #    Histograms , making  multiple density curve ----------------------------------
# ------------------ Rplot15E-----------------------------------#
#------------------------------------------------------------#

# The variable to fill with should be a factor
ggplot(birthwt, aes(x=bwt, fill=smoke)) + geom_density(alpha=.3)


 #    Boxplot----------------------------------
# ------------------ Rplot16-----------------------------------#
#------------------------------------------------------------#

ggplot(iris, aes(x=factor(Sepal.Length), y=Sepal.Width)) 
+ geom_boxplot() + theme(axis.text.x = element_text(angle=60, hjust=1)
+ )


 #    Graph with annotations----------------------------------
# ------------------ Rplot17-----------------------------------#
#------------------------------------------------------------#

ggplot(faithful, aes(x=eruptions, y=waiting)) 
+ geom_point() + geom_smooth(method = "lm")
 + annotate("text", x=3,y=48, label="Groupe1", size=5, color="red", fontface="italic") 
 + annotate("text", x=4.8,y=71, label="Groupe2", size=5, color="red", fontface="italic")
  + annotate("text", x=3,y=90, label="This is LM graph")

  #    Using Mathematical Expressions in Annotations------------
# ------------------ Rplot17A-----------------------------------#
#------------------------------------------------------------#

 p <- ggplot(data.frame(x=c(-3,3)), aes(x=x)) 
 + stat_function(fun = dnorm)
 p + annotate("text", x=2, y=0.3, parse=TRUE,label="frac(1, sqrt(2 * pi)) * e ^ {-x^2 / 2}")
 

  #    Graph with rectangle emphasis------------
# ------------------ Rplot17A-----------------------------------#
#------------------------------------------------------------#

 ggplot(mtcars,aes(x=cyl, y=mpg))
  + geom_line()
 + annotate("rect", xmin=5.6,xmax=6.4,ymin=10,ymax=23, alpha=.2)
  + theme(axis.line = element_line(colour="red"))


#    Reordered graph ------------
# ------------------ Rplot19-----------------------------------#
#------------------------------------------------------------#

ggplot(dtf, aes(x=Sepal.Length, y=Count))
 + geom_bar(stat = "identity", fill="blue", alpha=.2) 
 + coord_flip() + theme_classic()
 + annotate("text",x=7.5,y=5.3 , label="Reordered Graph", color="red")

  #One of the most useful techniques in data visualization is rendering groups of data alongside each other



  ## FACET THE MOST IMPORTANT TECHNIC USED IN DATA VIS,

#    Facets ------------
# ------------------ Rplot20----------------------------------#
#------------------------------------------------------------#

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) 
+ geom_point() + facet_wrap( ~ Species, ncol = 1)


#    ------------Creating a Heat Map--------------------------
# ------------------ Rplot21----------------------------------#
#------------------------------------------------------------#

ggplot(pres_rating, aes(x=year, y=quarter, fill=rating)) 
+ geom_tile() +  geom_raster()
  

    #  ------------Creating a 3D graph--------------------------
# ------------------ Rplot21----------------------------------#
#------------------------------------------------------------#

# You may need to install first ("rgl") package

plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=0.75, lit=FALSE)
> plot3d(mtcars$wt, mtcars$disp, mtcars$mpg, type="s", size=0.75)


# Thanks for your View, I hope these scripts will meet your requirement about data Vis...


