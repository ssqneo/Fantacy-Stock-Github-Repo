# Fantacy-Stock-Github-Repo
Team Syed and Zimin
CIS-544-11
2/23/2020

About: 

Fantasy stock was a stock trading competition conducted by our professor in which we utilized data mining and machine learning algorithms. 
Teams of 2 were created to compete against each other, each individual received $100,000 big data dollars (BDD) to start with the trading competition calling projectrex; a mediator to execute commands such as buying, selling, viewing profile and viewing the transaction log.
The API utilized to obtain the real time and historical stock data was Alpha Vantage. 
The script is written in R, see the R Markdown for a list of required packages.

Models: 

Two different models were created to make the decision of buying and selling based on historical and current data.

The first model utilizes the exponential moving average as a techincal indicator to analyze the historical data points by creating a series of average of different subsets of the dataset, but there is a catch: In a Simple Moving Average, each value in the time period carries equal weight, and values outside of the time period are not included in the average. However, the Exponential Moving Average is a cumulative calculation, including all data such that the past values have a diminishing contribution to the average, while more recent values have a greater contribution. This method allows the moving average to be more responsive to changes in the data. 
The model uses a 30 day exponential moving average and a 100 day exponential moving average and checks the series for the opening market value, when the two averages cross over bullish or bearish cross over. The shorter time span we chose the more sensitive the model was to price changes, so the reason why we chose a 30 and 100 day was to ensure that the model is in the middle of being less sensitive and being too sensitive to market price fluctuations. If the short term average is located above the long term average in the crossover this is an indication of an upward momentum which would call the selling function in the script and vice versa. The script is designed to check from a given  portfolio of stocks every minute moving on to the next symbol in the portfolio with a constraint of not exceeding more than 30 transactions for the same symbol, to not buy unless the budget is above the highest priced share owned and to not sell if the quantiy of owned shares for a symbol is not more than one.

The second model utilizes time series data to forecast the future price for the next
minutes if the actual price matches the predicted and is less than it executed the 
function

This not so complex algorithm helped us secure a poition in the top 3 which sparks a thought in our mind that is the stock market just a gamble? Both involve risk and look to maximize profit, but at what cost? 

