library(COVID19)
data(mtcars)
library(covid19us)
get_counties_info()
get_states_current()
get_states_current(UT)

# plot by country
x <- world('country')
f <- function(x, group) {
  plot(x$confirmed~x$date, main = group)
}
gapply(x, f)


# data by country
x <- italy("country")
# data by region
x <- italy("state")
# data by city
x <- italy("city")

get_states_daily(state = "UT", date = "all")
