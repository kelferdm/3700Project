library(ggplot2)
library(ggmap)
library(ggsn) 
library(dplyr) 
library(lubridate) 
library(sf) 
library(spData) 
library(tmap) 
library(leaflet) 
library(mapview) 
library(animation) 
library(gganimate)
library(ggthemes) 
library(gifski) 
library(av)
library(anytime)



cov <- read.csv("../3700_Project/Covid_19_Questions/COVID19_line_list_data.csv")
covClean <- read.csv("../3700_Project/Covid_19_Questions/covid_19_clean_complete.csv")


from = levels(covClean$Date)
to = c("1/22/2020","1/23/2020","1/24/2020","1/25/2020","1/26/2020","1/27/2020","1/28/2020","1/29/2020","1/30/2020","1/31/2020","2/1/2020","2/10/2020","2/11/2020","2/12/2020",
"2/13/2020","2/14/2020","2/15/2020","2/16/2020","2/17/2020","2/18/2020","2/19/2020","2/2/2020","2/20/2020","2/21/2020","2/22/2020","2/23/2020","2/24/2020","2/25/2020",
"2/26/2020","2/27/2020","2/28/2020","2/29/2020","2/3/2020","2/4/2020","2/5/2020","2/6/2020","2/7/2020","2/8/2020","2/9/2020","3/1/2020","3/10/2020","3/11/2020",
"3/12/2020","3/13/2020","3/14/2020","3/15/2020","3/16/2020","3/17/2020","3/18/2020","3/19/2020","3/2/2020","3/20/2020","3/3/2020","3/4/2020","3/5/2020","3/6/2020",
"3/7/2020","3/8/2020","3/9/2020"
)

reportingdatenew <- as.character(plyr::mapvalues(covClean$Date, from=from, to=to))

reportingdatenew <- as.POSIXct(reportingdatenew, format = '%m/%d/%Y')

covClean$Date <- reportingdatenew

# fix dates

from = levels(cov$reporting.date)
to=c("02/01/2020", "02/02/2020", "02/03/2020", "02/04/2020", "02/05/2020", "02/06/2020", "02/07/2020", 
"02/08/2020", "02/09/2020", "02/10/2020", "02/11/2020", 
"02/12/2020" ,"01/13/2020", "01/15/2020", "01/17/2020", "01/20/2020", "01/21/2020", 
"01/22/2020", "01/23/2020", "01/24/2020", "01/25/2020", "01/26/2020", 
"01/27/2020", "01/28/2020", "01/29/2020", "01/30/2020", "01/31/2020", 
"02/13/2020", "02/14/2020", "02/15/2020", "02/16/2020", "02/17/2020", "02/18/2020", 
"02/19/2020", "02/20/2020", "02/21/2020", "02/22/2020", "02/23/2020", "02/24/2020", "02/25/2020", "02/26/2020", "02/27/2020", "02/28/2020")


reportingdatenew <- as.character(plyr::mapvalues(cov$reporting.date, from=from, to=to))

reportingdatenew <- as.POSIXct(reportingdatenew, format = '%m/%d/%Y')

cov$reporting.date <- reportingdatenew





days <- unique(as.Date(covClean$Date))

l <- length(days)

cols <- c( "-1" = "grey","0" = "darkgrey", "1" = "green", "2" = "blue", "3" = "yellow", "4" = "pink", "5" = "orange", "6" = "red" , "7" = "violet", "8" = "black" , "NA" = "white")

bbox <- make_bbox(lon = c(-180, 180), lat = c(-70, 70) , f = 0)

??make_bbox

map <- get_map(location = bbox, zoom = 3, source = "stamen" , maptype = "terrain" , force = FALSE)



saveGIF( {
  for (i in 1:l) {
    #6.1
    the_day <- days[i]
    #6.2
    reports_of_day <- covClean %>% filter(as.Date() == the_day)
    #6.3
    #magnitude <- factor(round(earthquakes_of_day$mag))
    #6.4
    p <- ggmap(map) 
    #6.5
    p <- p + geom_point(data = reports_of_day , aes(x=longitude , y=latitude))
    #6.6
    p <- p + scale_colour_manual(values = cols) 
    #6.7
    p <- p + ggtitle(the_day)
    #6.8
    plot(p)
  }
  
},  

interval = 1 , nmax = l, ani.width = 1000, ani.height = 1000 , movie.name = "covid.gif")