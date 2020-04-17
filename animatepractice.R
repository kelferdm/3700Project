library(gganimate)
library(ggplot2)
library(vocab)

data("iris")
data("coronavirus")
#create new column for random dates
iris$Dates <-sample(seq(as.Date('2019/11/01'), as.Date('2020/04/20'), by="day"), 150)
#static plot
p <- ggplot(iris, aes(x= Petal.Width, y= Petal.Length)) +
  geom_point()

plot(p)

anim <- p + 
    transition_states(Dates,
                      transition_length = 2,
                      state_length = 1)
anim

p1 <- ggplot(coronavirus, aes(x= date, y= type)) +
    geom_point()

plot(p1)

anim1 <- p1 +
      transition_states(date,
                          transition_length = 2,
                          state_length = 1)
anim1
