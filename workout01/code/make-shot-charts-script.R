#####################################################################################
#title: Make Shot Charts Script
#description: Creates visualizations of players' data
#inputs: nba-court.jpg, shots-data.csv
#outputs: andre-iguodala-shot-chart.pdf, draymond-green-shot-chart.pdf, kevin-durant-shot-chart.pdf, klay-thompson-shot-chart.pdf, stephen-curry-shot-chart.pdf, stephen-curry-shot-chart.pdf,gsw-shot-charts.pdf, gsw-shot-charts.png
#####################################################################################

#Libraries to import
library(ggplot2)
library(grid)
library(jpeg)

# Create the background for the ggplot
court_file = '../images/nba-court.jpg'
court_images = rasterGrob(readJPEG(court_file), width = unit(1, 'npc'), height = unit(1, 'npc'))

# Import necessary data frame about players' data to use
data_types = c("team_name"="character", "game_date"="character", "season" = "integer", "period"="integer",
               "minutes_remaining"="integer", "seconds_remaining"="integer", "shot_made_flag"="character",
               "action_type"="factor", "shot_type"="factor", "shot_distance"="integer", "opponent"="character",
               "x"="integer", "y"="integer")
shots = read.csv('../data/shots-data.csv', stringsAsFactors = FALSE, colClasses = data_types)

andre = shots[shots$name == 'Andre Iguodala', ]
draymond = shots[shots$name == 'Draymond Green', ]
kevin = shots[shots$name == 'Kevin Durant',]
klay = shots[shots$name == 'Klay Thompson', ]
stephen = shots[shots$name == 'Stephen Curry', ]


andre_scatterplot = ggplot(data = andre) + annotation_custom(court_images, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal()
draymond_scatterplot = ggplot(data = draymond)+annotation_custom(court_images, -250, 250, -50, 420)+ geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal()
kevin_scatterplot = ggplot(data = kevin)+annotation_custom(court_images, -250, 250, -50, 420)+ geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal()
klay_scatterplot = ggplot(data = klay)+annotation_custom(court_images, -250, 250, -50, 420)+ geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
stephen_scatterplot = ggplot(data = stephen)+annotation_custom(court_images, -250, 250, -50, 420)+ geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()

pdf(file = "../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
andre_scatterplot
dev.off()

pdf(file = "../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
draymond_scatterplot
dev.off()

pdf(file = "../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
kevin_scatterplot
dev.off()

pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
klay_scatterplot
dev.off()

pdf("../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
stephen_scatterplot
dev.off()

# Create 1 graph for all players
gsw_scatterplot = ggplot(data=shots) + annotation_custom(court_images, -250, 250, -50, 420)+ geom_point(aes(x=x, y=y, color=shot_made_flag))+
  ylim(-50, 420) + ggtitle('Shot Chart: GSW (2016 season)') + theme_minimal() + facet_wrap(~name, ncol=3)

pdf('../images/gsw-shot-charts.pdf', width=8,height=7)
gsw_scatterplot
dev.off()

png('../images/gsw-shot-charts.png', width=8,height=7, units="in", res = 300)
gsw_scatterplot
dev.off()