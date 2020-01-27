# packages - sqldf, dplyr, reshape2, readxl, xlsx, ggplot2, googleVis


setwd("C:/Allen/Training/Rforexcel/")
players = read.csv("Master.csv")
View(players)

batting = read.csv("batting.csv")
View(batting)


batting_extra = merge(batting, players [,c("playerID","birthYear")])
View(batting_extra)

x = batting_extra[which(batting_extra$AB > 200 &
                        batting_extra$yearID >= 1950), ]
x$age = x$yearID - x$birthYear

hist(x$age):
  
summary(x$age)

library(sqldf)


salaries = read.csv("Salaries.csv")
View(salaries)
teams = read.csv("Teams.csv")
View(teams)

head(salaries)

salaries_teams = sqldf("SELECT a.*, b.name 
              FROM salaries a
              JOIN teams b ON(a.yearID = b.yearID   
              AND a.teamID = b.teamID)")
head(salaries_teams)

al_nl_salary =
    sqldf("Select yearID, 
          AVG(CASE WHEN lgID = 'AL' THEN salary END) as AVE_AL_salary,
          AVG(CASE WHEN lgID = 'NL' THEN salary END) as AVE_NL_salary
    FROM salaries_teams GROUP BY 1")

install.packages("googleVis")
library(googleVis)


g = gvisLineChart(al_nl_salary, xvar = "yearID",
                  yvar = c("AVG_AL_salary","AVG_NL_salary" ),
                 options = list(title = "Average Salary Trends - AL vs NL"))
plot(g)






