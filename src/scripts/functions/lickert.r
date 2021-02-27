#' Constructor function to create a likert class.
#'
#' This function will provide various summary statistics about a set of likert
#' items. The resulting object will have the following items:
#' \itemize{
#'    \item results this data frame will contain a column 'Item','Group' (if a 
#'          grouping variable was specified,and a column for each level of the
#'          items (e.g. agree,disagree,etc.). The value within each cell corresponds
#'          to the percentage of responses for that level and group.
#'    \item items a copy of the original items data frame.
#'    \item grouping a copy of the original grouping vector.
#'    \item nlevels the number of levels used in the calculations.
#'    \item summary this data frame provides additional summary information. It
#'          will contain 'Item' and 'Group' columns similiar to the results data
#'          frame as well as a column 'low' corresponding to the sum of levels below
#'          neutral,a column 'high' corresponding to the sum of levels above
#'          neutral,and columns 'mean' and 'sd' corresponding to the mean and
#'          standard deviation,respectively,of the results. The numeric values
#'          are determined by as.numeric which will use the values of the factors.
#' }
#'
#' @export
#' @param items data frame containing the likert based items. The variables
#'        in the data frame should be factors.
#' @param grouping (optional) should the results be summarized by the given
#'        grouping variable.
#' @param nlevels number of possible levels. Only necessary if there are missing levels.
#' @return a likert class with the following elements: results,items,grouping,
#'        nlevels,and summary.
likert <- function(items, grouping = NULL, nlevels = length(levels(items[, 1]))) {
  lowrange <- 1:ceiling(nlevels / 2 - nlevels %% 2)
  highrange <- ceiling(nlevels / 2 + 1):nlevels

  results <- data.frame()
  if (!is.null(grouping)) {
    results <- data.frame(
      Group = rep(unique(grouping), each = nlevels),
      Response = rep(1:nlevels, length(unique(grouping)))
    )
    for (i in 1:ncol(items)) {
      t <- as.data.frame(table(grouping, items[, i]))
      t <- cast(t, Var2 ~ grouping, value = 'Freq', add.missing = T)
      t <- apply(t, 2, FUN = function(x) { x / sum(x) * 100 })
      t <- melt(t)
      results <- cbind(results, t[, 3])
    }

    names(results)[3:ncol(results)] <- names(items)

    results2 <- data.frame(Group = rep(unique(results$Group), each = ncol(items)),
                           Item = rep(names(items), length(unique(results$Group))),
                           low = rep(NA, ncol(items) * length(unique(results$Group))),
                           high = rep(NA, ncol(items) * length(unique(results$Group))),
                           mean = rep(NA, ncol(items) * length(unique(results$Group))),
                           sd = rep(NA, ncol(items) * length(unique(results$Group))))
    for (g in unique(results$Group)) {
      results2[which(results2$Group == g),]$low <- apply(
        results[results$Response %in% lowrange &
                  results$Group == g, 3:ncol(results)], 2, sum)
      results2[which(results2$Group == g),]$high <- apply(
        results[results$Response %in% highrange &
                  results$Group == g, 3:ncol(results)], 2, sum)
      for (i in names(items)) {
        results2[which(results2$Group == g & results2$Item == i), 'mean'] <-
          mean(as.numeric(items[which(grouping == g), i]), na.rm = T)
        results2[which(results2$Group == g & results2$Item == i), 'sd'] <-
          sd(as.numeric(items[which(grouping == g), i]), na.rm = T)
      }
    }

    results$Response <- factor(results$Response, levels = 1:nlevels,
                               labels = levels(items[, i]))
    results <- melt(results, id = c('Group', 'Response'))
    results <- cast(results, Group + variable ~ Response)
    results <- as.data.frame(results)
    names(results)[2] <- 'Item'
  } else {
    results <- data.frame(Response = 1:nlevels)
    means <- numeric()
    sds <- numeric()
    for (i in 1:ncol(items)) {
      t <- table(items[, i])
      t <- (t / sum(t) * 100)
      means[i] <- mean(as.numeric(items[, i]), na.rm = T)
      sds[i] <- sd(as.numeric(items[, i]), na.rm = T)
      results <- cbind(results, as.data.frame(t)[2])
      names(results)[ncol(results)] <- names(items)[i]
    }
    results <- as.data.frame(t(results))
    names(results) <- as.character(unique(items[!is.na(items[, 1]), 1]))
    results <- results[2:nrow(results),]
    results$Item <- row.names(results)
    row.names(results) <- 1:nrow(results)
    results2 <- data.frame(Item = results$Item,
                           low = apply(results[, lowrange], 1, sum),
                           high = apply(results[, highrange], 1, sum),
                           mean = means, sd = sds)
    #results=melt(results,id.vars='Item')
  }

  r <- list(results = results, items = items, grouping = grouping, nlevels = nlevels,
            summary = results2)
  class(r) <- 'likert'
  return(r)
}

#' Prints results table.
#'
#' @param x the likert class to print.
#' @export
#' @method print likert
#' @S3method print likert
print.likert <- function(x, ...) {
  return(x$results)
}

#' Prints summary table.
#'
#' @param x the likert class to summarize.
#' @export
#' @method summary likert
#' @S3method summary likert
summary.likert <- function(x, ...) {
  return(x$summary)
}

#' Plots a set of likert items. 
#'
#' @param likert the likert items to plot
#' @param low.colour colour corresponding to the lowest value likert items
#' @param high.colour colour corresponding to the highest value likert items
#' @param neutral.colour colour for middle values. Only used when there are an odd
#'        number of levels.
#' @param text.size size or text labels
#' @param type whether to plot a bar or heat map graphic
#' @export
#' @method plot likert
#' @S3method plot likert
plot.likert <- function(likert, low.colour = 'blue', high.colour = 'red',
                        neutral.colour = 'white', text.colour = 'white', text.size = 2,
                        type = c('bar', 'heat'), ...)
{
  if (type[1] == 'bar') {
    plot.likert.bar(likert, low.colour = low.colour, high.colour = high.colour,
                    neutral.colour = neutral.colour, text.size = text.size, ...)
  } else {
    plot.likert.heat(likert, low.colour = low.colour, high.colour = high.colour,
                     text.size = text.size, ...)
  }
}

