library(pacman)
p_load('zoo','nnfor')

#Pull in Texas Data
training = TX_NY_NJ
corona = TX_Corona_Curve

#Convert data to Time Seres data structure
train = ts(corona$`TX New Cases`)


#Fit the model
fit.mlp = mlp(train)
plot(fit.mlp)

fore.mlp = forecast(fit.mlp,reps = 50,h=32, hd.auto.type = "cv")
plot(fore.mlp)

forecast = fore.mlp

texas = ggplot(corona, aes(x = Curve_Day, y = `TX New Cases`)) +
  geom_line()

actual = texas +
  geom_line(Corona_MAE_JAW, mapping = aes(x = Curve_Day, y = `TX New Cases`),color="royalblue", size=2)+
  annotate("text",x = 52, y = 7900,label = "TX New Cases")

actual +
  geom_line(Corona_MAE_JAW,mapping = aes(x = Curve_Day, y = `MLP Predicitons`),color="Red", size=1,linetype="dashed") +
  annotate("text",x = 52, y = 22000,label = "Prediction") +
  ggtitle("COVID-19 Predictions Mapped Against Actual Cases")
