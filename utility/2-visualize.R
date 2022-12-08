#' @file 2-dataviz.R
#' @author Leon Wang
#' @date Fall 2022
#' 
#' R Script to generate a data visualization of the cleaned data from 
#' 1-clean.R.
#' 
#' See README.md for more information on what I am exploring with this data.

# Package checker from 0-parse.R
check_package("ggplot2")

ggplot(data, aes(x=time)) +
  geom_histogram(aes(y=..density..),
                 bins=15, 
                 fill="lightcoral", 
                 lty="blank",
                 alpha=5/6) +
  geom_density(lwd=0.25,
               color="blue",
               fill="lightblue",
               alpha=1/4) +
  labs(title="Distribution of Song Duration Over Time (1992-2022)",
       subtitle="Leon Wang - STAT 447",
       caption="Data source: Spotify API",
       x="Song Duration (minutes)",
       y="Density") +
  theme_minimal() +
  theme(plot.title = element_text(hjust=0.5, size=16, face="bold"),
        plot.caption = element_text(size=8, face="italic"),
        plot.subtitle = element_text(size=8, hjust=0.5)) +
  geom_vline(xintercept=mean(data$time),
             color="#777777",
             alpha=5/6,
             linewidth=0.5,
             linetype="longdash") +
  scale_x_continuous(breaks = seq(1, 11, 2)) +
  facet_wrap(~ year)

ggsave("plot.pdf")
cat("\014Visualization saved to 'plot.pdf'")
