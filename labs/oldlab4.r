# POLS/CSSS 503
# Lab Session 4: April 25, 2014
# Carolina Johnson

# Agenda:

# 1. More useful tools
# 2. Examples using loops
# 3. Simulating regression results
# 4. Simulating the Monty Hall Problem
# 5. Exercise: The Birthday Problem


#### 1.  Questions on Homework?

#### 2.  More useful tools

z<-rnorm(10, mean=100, sd=1) # draw randomly from the normal distribution
z1<-runif(10,0,1) #draw from a uniform distribution between min and max values
sample(z, 2) # samples two numbers from the z vector
sort(z) # puts z in (ascending) order.
sort(z, decreasing=T)
sample(c("red","blue","yellow","green"),10,replace=T)
sample(c("red","blue","yellow","green"),3,replace=F) #note you cannot have a higher number of draws when replace=F

#which(data2$id=="CAN") # tells you the position(s) where the condition is met
which.max(z1)


# IF conditions
a<-10
if (a==10) print("Yes, a is 10.")
print("This gets printed no matter what value a was.")
# the statement immediately after the if statement is run only when the argument in parentheses evalues to TRUE.  Try #setting 'a' to another value and see what happens.

# Note: use braces {} after the if statement if you want multiple commands to be executed when the condition is met:
if (a==10) {
    print("Yes, a is 10.")
    print("Because a is 10 I'm doing this too.")
    } else print("DIDNT WORK")

print("This gets printed no matter what value a was.")


# FOR loops
for (i in 1:10){
print(i^2)
} # close the i loop

# you can put as many lines of code as you want in between the {} braces, including other for loops and if statements, and whatever else you want.



#### 3. Examples using loops
## (Example 1 for data online)

data1<-read.csv("rossoildata.csv", na.strings="", stringsAsFactors=FALSE)

data3<-data1[,c("cty_name","year","regime1","oil","GDPcap","oecd")]

#We're going to examine the level of missingness for each country

#a list of every country name
uc<-unique(data3$cty_name)
uc

#convert from factor data to character data
uc<-as.character(uc) #if necessary

#the number of countries in the dataset
numcountries<-length(uc)

#empty vectors to hold our results
country_obs<-rep(NA, numcountries)
country_na<-rep(NA, numcountries)

# This loop is going to go through each individual country in turn, and find out two things:
# 1. how many observations are there for that country?
# 2. how many observations for that country are left after listwise deletion of missing data?
# After evaluating these questions for each country, and storing the results in two different vectors, the loop will repeat the same tasks for the next country.
# The counter variable "i" simply goes up by 1 for each iteration of the loop. By referencing "uc[i]", we are asking the lines of code inside the loop to apply to the first country, then the second country, then the third, and so on...

for(i in 1:numcountries){
	tempdata<-data3[data3$cty_name==uc[i],]
	na_omit_tempdata<-na.omit(tempdata)
	country_obs[i]<-nrow(tempdata)
	country_na[i]<-nrow(na_omit_tempdata)
	}

cbind(uc,country_obs,country_na,country_na/country_obs)
#Why are there quotes around the numbers? How might you fix this

na_table<-as.data.frame(cbind(country_obs,country_na,round(country_na/country_obs,2)))
rownames(na_table)<-uc
colnames(na_table)<-c("All obs","Remaining obs","Proportion")

na_table[order(na_table$Proportion, decreasing=T),]


### Another example: Run a separate model for each year and summarize changing magnitude of effects
uy<-unique(data3$year)
yearmodels<-as.list(uy)

#create a dichotomous variable of whether a country is a democracy or an autocracy
data3$dem_indicator<-rep(0,nrow(data3))
data3$dem_indicator[data3$regime1>8]<-1

#transforming GDP per capita to be measured in thousands of dollars
data3$GDPcap1<-data3$GDPcap/1000

#creating vectors to hold the results we are interested in
dem_coef<-rep(NA,length(uy))
dem_se<-rep(NA,length(uy))

for(i in 1:length(uy)){
	tempdata<-data3[data3$year==uy[i],]
	res_temp<-lm(GDPcap1 ~ dem_indicator + oil, data=tempdata)
	dem_coef[i]<-coef(res_temp)[2]
	dem_se[i]<-sqrt(diag(vcov(res_temp)))[2]
}
### What is this loop doing?

plot(uy,dem_coef,ylim=c(0,10), type="n", xlab="Year", ylab="Coefficient for Democracy Indicator",
main="Association between Democracy and Development in each Year")
segments(x0=uy,
	y0=dem_coef - 1.96*dem_se,
	x1=uy,
	y1=dem_coef + 1.96*dem_se,
	lwd=2, col="gray50")
points(uy, dem_coef, pch=19)
abline(h=0, col="red")

### Another example: Using simulations to summarize a regression model:
### This is basically an alternate way to work through part 1.e. of Homework 2
## ('Example 2' for data online)

data <- read.csv ("sprinters.csv", na.strings=".")
model2 <- lm(finish~year*women, data=data)

year.range<-seq.int(from=min(data$year), to=max(data$year), by=2)
EVs.male<-rep(NA,53) # point estimates from model for men
lowerCIs.male<-rep(NA,53)
upperCIs.male<-rep(NA,53)
EVs.female<-rep(NA,53) # point estimates for women
lowerCIs.female<-rep(NA,53)
upperCIs.female<-rep(NA,53)

# get the coefficients and vcmatrix from the model:
pe<-coef(model2)
vc<-vcov(model2)
# Take 1000 draws from the multivariate normal distribution:
library(MASS)
simbetas<-mvrnorm(1000, pe, vc)

# Set up a loop that goes through all  alues in year.range, with FEMALE set to 0
for (i in 1:length(year.range)){
  # define the covariate values for the current scenario  - must be in the same order as in model2$coefficientsorder: (Int) year women data$year:data$women
  x.current<-c(1,    #(Intercept)
               year.range[i],  #year
               0,    # women
               year.range[i]*0   # year*women
  )
  # calculate the 1000 predictions:
  pred.current<- simbetas %*% x.current
  # Now slot the mean, lowerCI and upperCI values into the appropriate positions in the results vectors:
  EVs.male[i]<-mean(pred.current)
  lowerCIs.male[i]<-sort(pred.current)[25] #for illustration; quantile is a better way to do this, see CIs for women below
  upperCIs.male[i]<-sort(pred.current)[975]
} # close i loop

# Now repeat that same loop, but change to FEMALE=1 (both in the base term and the int. term)
for (i in 1:length(year.range)){
  # define the covariate values for the current scenario
  x.current<-c(1,
               year.range[i],
               1,
               year.range[i]*1
  )
  # calculate the 1000 predictions:
  pred.current<- simbetas %*% x.current
  # Now slot the mean, lowerCI and upperCI values into the appropriate positions in the results vectors:
  EVs.female[i]<-mean(pred.current)
  lowerCIs.female[i]<-quantile(pred.current,.025)
  upperCIs.female[i]<-quantile(pred.current,.975)
} # close i loop

#Plotting
pdf("sprinters.pdf",
           height=5,
           width=5)
plot(year.range, EVs.male, type="n", bty="n", xlab="Year of Competition", main="Linear Model of Finishing Times,\n including interaction Year*Female", ylab="Finishing Time (seconds)", ylim=c(9, 13.5), las=1)
polygon(c(year.range, rev(year.range)),c(lowerCIs.male, rev(upperCIs.male)), border=NA, col="light green")
polygon(c(year.range, rev(year.range)),c(lowerCIs.female, rev(upperCIs.female)), border=NA, col="lightblue")
points(x=data$year[data$women==0], y=data$finish[data$women==0], col="green", pch=16)
points(x=data$year[data$women==1], y=data$finish[data$women==1], col="blue", pch=16)
lines(year.range, EVs.male, lwd=2, col="dark green")
lines(year.range, EVs.female, lwd=2, col="dark blue")
legend(1970,13,c("Women","Men"),lwd=2,col=c("blue","green"),cex=.8)
dev.off()


#### 4. SIMULATING THE MONTY HALL PROBLEM

#On Let's Make a Deal, host Monty Hall offers you the following choice:

    #1. There are 3 doors. Behind one is a car. Behind the other two are goats.
    #2. You choose a door. It stays closed.
    #3. Monty picks one of the two remaining doors, and opens it to reveal a goat.
    #4. Your choice: Keep the door you chose in step 1, or switch to the third door.

#What should you do?

#What is the probability of a car from staying?
#What is the probability of a car from switching?

# The simulation approach:

# Set up the doors, goats, and car
# Contestant picks a door
# Monty "picks" a remaining door
# Record where the car and goats were
# Do all of the above many many times
# Print the fraction of times a car was found


sims <- 10000 # Simulations run
doors <- c(1,0,0) # The car (1) and the goats (0)
cars.stay <- 0 # Save times cars won with first choice here
cars.switch <- 0 # Save times cars won from switching here
for (i in 1:sims) {
	random.doors <- sample(doors,3,replace=F)
	cars.stay <- cars.stay + random.doors[1] #First choose "door number 1"
	cars.switch <- cars.switch + sort(random.doors[2:3])[2] #Do you understand what this line of code is doing?
  #cars.switch <- cars.switch + (sum(random.doors[2:3])) # an alternative approach
}

paste("Probability of a car from staying with 1st door", cars.stay/sims, sep=": ")
paste("Probability of a car from switching to 2nd door", cars.switch/sims, sep=": ")


## A slightly different solution from years ago....

# Monty Hall Problem
# Chris Adolph
# 1/6/2005
sims <- 10000 # Simulations run
doors <- c(1,0,0) # The car (1) and the goats (0)
cars.chosen <- 0 # Save cars from first choice here
cars.rejected <- 0 # Save cars from switching here
for (i in 1:sims) { # Loop through simulations
# First, contestant picks a door
first.choice <- sample(doors,3,replace=F)
# Choosing a door means rejecting the other two
chosen <- first.choice[1]
rejected <- first.choice[2:3]
# Monty Hall removes a goat from the rejected doors
rejected <- sort(rejected)
if (rejected[1]==0)
rejected <- rejected[2]
# Record keeping: where was the car?
cars.chosen <- cars.chosen + chosen
cars.rejected <- cars.rejected + rejected
}
cat("Probability of a car from staying with 1st door",
cars.chosen/sims,"\n")
cat("Probability of a car from switching to 2nd door",
cars.rejected/sims,"\n")



### 5. EXERCISE: THE BIRTHDAY PROBLEM

# Question: What is the probability that at least two students will share the same birthday in a class of 20?
# Use a simulation method to answer this.  (Ignore leap years.)

# Bonus question: Modify your quote to answer the question for varying class sizes.


#### Here is one solution, as talked through in class:

size <- 20
sims <- 100000
score <- 0
for (i in 1:sims) {
  class <- sample(1:365, size, replace=TRUE)
  unique <- length(unique(class))
  if (length(unique(class)) < size) score <- score+1
}
prob <- score/sims
paste("The probability of at least one shared birthday in a class of 20 students is", round(prob,2))

