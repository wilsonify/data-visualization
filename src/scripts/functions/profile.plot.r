##
## profile.plot.R
## Version 1.1
##
## Patrick R. Schmid 
## prschmid@gmail.com
## May 2012
##
## Create a profile plot. 
##
## This code is based on the the profile plotting code by Detlev Reymann that can be found here:
## http://addictedtor.free.fr/graphiques/RGraphGallery.php?graph=145
##
##
profile.plot <- function(
  x,                    ## The matrix of data to plot. Each profile item is in a column with an appropriate column name.
  ## The column names will be used as the names for the profiles in the legend.
  text.left = c(),        ## The text to appear on the left hand side (same length as nrow(x))
  text.right = c(),        ## The text to appear on the right hand side (same length as nrow(x))
  highlight.col = -1,    ## The column index of the entry to highlight. (Default,none highlighted)
  text.width.adjust = 30,    ## The adjustment factor for the spacing for the text on the left and right of the plot. If you
  ## need more space,make this larger. If you need less,make it smaller.
  colours = NULL,        ## The vector of colours to use for the lines. Default is rainbow()
  draw.segments = T,    ## Whether or not horizontal segements should be drawn
  draw.mid = T,        ## Whether or not a vertical line should be drawn down the middle of the profile plot.
  plot.legend = T,    ## Whether or not to include a legend at the bottom
  legend.n.col = NA        ## The number of columns that should be used in the legend
) {

  ## Find the min and max for the x-axis
  min.x <- floor(min(x))
  max.x <- ceiling(max(x))
  mid.x <- (max.x + min.x) / 2

  ##
  ## Configure the graphics output
  ##

  ## Keep the old par() setting around so that we can reset them at the end
  par.default <- par(no.readonly = T)

  ## create new window for output
  plot.new()

  ## Outer margin:
  #	par(oma=c(0,0,0,0))
  par(omi = c(0.25, 1.5, 0.95, 1.5))

  ## letter size
  # par(ps=14)

  ## First discover text largest in size to set dimensions
  ## for text and graph
  left.text.width <- max(strwidth(text.left))
  right.text.width <- max(strwidth(text.right))

  ## I (Detlev Reymann) found this multiplication factor just by trail
  ## and error has to be adjusted for longer text!!
  left.text.width <- left.text.width * text.width.adjust
  right.text.width <- right.text.width * text.width.adjust

  ## Define area for drawing the graph (Text is not part of the graph)
  ## par(mar=c(bottom,left,top,right))
  #	par(mar=c(0.5,left.text.width,0.5,right.text.width))
  par(mai = c(0, 2, 0, 2))

  ## Calculating the size for the caption
  ## three names in one line
  if (plot.legend) {
    line.height <- 0.66
    caption.height <- -((nrow(x) %% 3) + 1) * line.height
    plot.window(xlim = c(min.x, max.x), ylim = c(caption.height, nrow(x)))
  } else {
    plot.window(xlim = c(min.x, max.x), ylim = c(0, nrow(x)))
  }

  ##
  ## Let's do some plotting
  ##

  ## Configure Y-axis
  y <- 1:nrow(x)

  ## Draw a dotted line for each item
  if (draw.segments) {
    segments(min.x, y, max.x, y, lty = "dotted", col = "gray")
  }

  ## Draw a line for the average/neutral value
  if (draw.mid) {
    lines(c(mid.x, mid.x), c(1, nrow(x)), lwd = 3, col = "gray")
  }

  ## The set of colours to use (if none provided)
  if (is.null(colours)) {
    colours <- rainbow(ncol(x))
  }

  ## If there is some highlighting to be done,make the default line
  ## solid
  if (highlight.col > 0) {
    par(lwd = 4, lty = "solid")
  }

  ## Loop over all profiles (columns)
  for (i in 1:ncol(x)) {

    ## In most cases we want one of the objects to be highlighted
    ## in the graph,my own brand,the reference object etc.
    if (highlight.col == i) {
      par(lwd = 3, lty = 1)
    } else {
      par(lwd = 3, lty = "solid")
    }

    ## Draw lines and symbols for each object
    for (j in 1:nrow(x)) {

      cur.y <- (nrow(x) + 1) - j

      ## Draw the point
      points(x[j, i], cur.y, col = colours[(i %% length(colours)) + 1], pch = 19)

      ## Connect with lines
      if (j > 1) {
        lines(
          c(x[j, i], x[(j - 1), i]),
          c(cur.y, (cur.y + 1)),
          col = colours[(i %% length(colours)) + 1])
      }
    }
  }

  ## Display Text on the left
  mtext(rev(text.left), at = y, adj = 1, side = 2, las = 2)

  ## Display Text on the right
  mtext(rev(text.right), at = y, adj = 0, side = 4, las = 2)

  ##
  ## Draw x-axis
  ##

  ## Set ticks for x-axis
  ticks <- c(
    round(min.x, 3),
    round(((min.x + mid.x) / 2), 3),
    round(mid.x, 3),
    round(((mid.x + max.x) / 2), 3),
    round(max.x, 3))

  par(cex.axis = 0.5, mex = 0.5)
  axis(1, at = ticks, labels = ticks, pos = 0.5)

  ##
  ## Add in the legend
  ##

  if (plot.legend) {
    if (is.na(legend.n.col)) {
      legend.n.col <- ceiling(ncol(x) / 2)
    }
    legend(min.x, 0, legend = colnames(x), pch = 19, col = colours, bg = NA, box.col = NA, ncol = legend.n.col)
  }

  ## Reset all of the par() settings to what they were before we started
  par(par.default)
}

## Create some random data
x <- matrix(rnorm(50), ncol = 5)
colnames(x) <- c("A", "B", "C", "D", "E")

## Some random labels for the left and right text. These labels
## need to be the same length as the number of rows in x
text.left <- paste(1:nrow(x), "Left Text")
text.right <- paste(1:nrow(x), "Right Text")

## Create the profile plot. See the details in profile.plot.R for 
## the details on the parameters
profile.plot(
  x,
  text.left,
  text.right,
  highlight.col = 2,
  legend.n.col = 5)
