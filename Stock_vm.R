library(alphavantager)
library(jsonlite)

#Syed
#key = 34a99316
#av_key = 8O2HOV0F5K39AXOJ

# To pull the profile table and assign the counter column to be zero and the budget to be zero.

profile <- "https://www.projectrex.net/stocks/?key=34a99316&av_key=8O2HOV0F5K39AXOJ&request=profile"
profileFull <- fromJSON(profile)
profile.syed <- profileFull$shares
profile.syed$counter = 0
profile.syed
BUDGET <- 0

# To set the budget above the maximum price of share owned.
max_price <- max(profile.syed$price)
max_price

# To define the vector of symbols to trade with
stocks.s <- c("F", "JNJ","NUGT","AAPL", "SPCE","TRQ","AEO",  "UA","V", "INST")

# To specify the script to run in a while loop for almost 6 hours
end_time <- Sys.time() + 20000

# To specify alphavantage key for pulling the ema.
av_api_key("8O2HOV0F5K39AXOJ")


# To execute the model for the next 6 hours with a while loop iterating through the above defined vector of stock symbols
while (Sys.time() <= end_time) {
  
  SLEEP <- seq(from = 0, to = 10, by = 2)
  x=1
  for (i in stocks.s) {
    ema.30.open = as.data.frame(av_get(symbol = i,
                                       av_fun = "EMA",
                                       interval = "5min",
                                       time_period = 30,
                                       series_type = "open"))
    ema.100.open = as.data.frame(av_get(symbol = i,
                                        av_fun = "EMA",
                                        interval = "5min",
                                        time_period = 100,
                                        series_type = "open"))

    # To check for the cross over of 30 day ema with the 100 day ema
    
    EMA_POINT <- ema.30.open$ema[[1]] - ema.100.open$ema[[1]]
    
if( EMA_POINT >= 0 && profile.syed$counter [profile.syed$symbol == i] <=30 ) {
# Sell if the short term ema is leading 
  if (profile.syed$quantity[profile.syed$symbol == i] > 1 && profile.syed$counter [profile.syed$symbol == i] <=30) {
    Transaction <- fromJSON(sell <- paste("https://www.projectrex.net/stocks/?key=34a99316&av_key=8O2HOV0F5K39AXOJ&request=sell&quantity=1&symbol=",i, sep = ""))
    # Update Profile
    profile.syed$quantity[profile.syed$symbol == i] <- profile.syed$quantity[profile.syed$symbol == i] - 1
    profile.syed$counter[profile.syed$symbol == i] <- profile.syed$counter[profile.syed$symbol == i] + 1
    # Update Budget
    BUDGET <- BUDGET +Transaction$price
  }
  
 
} else if(BUDGET > max_price && profile.syed$counter [profile.syed$symbol == i] <=30 ) {
  # Buy if the long term ema is leading
  Transaction <- fromJSON(buy <- paste("https://www.projectrex.net/stocks/?key=34a99316&av_key=8O2HOV0F5K39AXOJ&request=buy&quantity=1&symbol=",i, sep = ""))
  # Update Profile
  profile.syed$quantity[profile.syed$symbol == i] <- profile.syed$quantity[profile.syed$symbol == i] + 1
  profile.syed$counter[profile.syed$symbol == i] <- profile.syed$counter[profile.syed$symbol == i] + 1
  # Update Budget
  BUDGET <- BUDGET - Transaction$price 
}
    # To put the loop in a sleep for a minute to avoid exceeding the allowed api calls per minute.
    
if (x %in% SLEEP){
  Sys.sleep(60)
}  
x <- x+1
  }
}