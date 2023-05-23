#Team number 2
#Edgar Zapata
#Dylan Miles
#This database project is that of a cryptocurrency market exchange
#There are users which own wallets, which contain balances and crypto transactions
# Those transactions have Cryptocurrencies which have tickers, prices, and market caps.

# Create User Table, autoincrements the user_id
# Verified bit shows if the user is verified to make trades on the exchange
# date of birth uses format DDMMYYYY
CREATE TABLE User(
user_id INT NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
Verified BIT NOT NULL,
Date_of_birth varchar(8) NOT NULL,
PRIMARY KEY (user_id));

#Create Wallet Table, autoincrement walletid
# Balance is the users cash 
CREATE TABLE Wallet(
wallet_id INT NOT NULL AUTO_INCREMENT,
Balance varchar(1000) NOT NULL,
User_ID INT,
PRIMARY KEY (wallet_id),
FOREIGN KEY (User_ID) REFERENCES User(User_ID));

#Create cryptocurrency table
#Token is the (usually 3 character) ticker such as 'btc'
#market cap is measured in millions
#price is the current price of the coin in USD
CREATE TABLE Cryptocurrency(
Token varchar(10) NOT NULL,
Market_Cap INT NOT NULL,
Price INT NOT NULL,
PRIMARY KEY (Token));

#create the transaction table
#id auto increments
#amount should be the amount of crypto handled in this transaction
#Type should only be BUY or SELL
#Date should be the day the user made the transaction in format DDMMYYYY
#Wallet_id should be a foreign key to the users walletid
#token should be a foreign key to the cryptocurrency being exchanged

CREATE TABLE Transaction(
Transaction_ID INT NOT NULL AUTO_INCREMENT,
Amount INT,
Type varchar(4),
date varchar(8),
Wallet_ID INT,
Token varchar(10),
CHECK (Type='BUY' or Type='SELL'),
PRIMARY KEY (Transaction_ID),
FOREIGN KEY (Wallet_ID) REFERENCES Wallet(wallet_id),
FOREIGN KEY (Token) REFERENCES Cryptocurrency(Token));

#Insert crypto 'BTC' into database with market cap of 328.55B and price $17090
INSERT INTO Cryptocurrency (Token, Market_Cap, Price) VALUES (
    'BTC', 328550, 17090);

# Create cryptocurrency 'ETH' with market cap 156.2B and price $1276
INSERT INTO Cryptocurrency (Token, Market_Cap, Price) VALUES (
     'ETH', 156200, 1276);

# Create user 'Anas TPM', who is verified, and was born on 11/21/2001
INSERT INTO User (Name, Verified, Date_of_birth) VALUES
 ('Anas TPM', 1, 11212001);
 
 #create anas wallet
 INSERT INTO Wallet (Balance, User_ID) VALUES(8423, LAST_INSERT_ID());
 
 #create two transactions for anas, where he sells 0.15eth and buys 0.47 ETH
INSERT INTO Transaction (Amount, Type, Date, `Wallet_ID`, `Token`) VALUES (0.15, 'SELL', 02122020, 1, 'BTC');
INSERT INTO Transaction (Amount, Type, Date, `Wallet_ID`, `Token`) VALUES (0.47, 'BUY', 03122020, 1, 'ETH');

 # Create user dylan
 INSERT INTO User (Name, Verified, Date_of_birth) VALUES ('Dylan', 1, 07112000);
 # Create dylans wallet
 INSERT INTO Wallet (Balance, User_ID) VALUES(1052, LAST_INSERT_ID());
 
 #create dylans two transactions, where he buys 0.15 eth, and then the next day buys 0.47 more eth
INSERT INTO Transaction (Amount, Type, Date, `Wallet_ID`, `Token`) VALUES (0.15, 'BUY', 02122020, 2, 'ETH');
INSERT INTO `Transaction` (Amount, Type, Date, `Wallet_ID`, `Token`) VALUES (0.47, 'BUY', 03122020, 2, 'ETH');

# find the highest price and lowest price crypto
# and display them 
select Token, MAX(Price) as highestprice, MIN(Price) as lowestprice from Cryptocurrency GROUP BY Token;

# find crypto with market caps between 1,000 and 1,000,000
select Market_Cap, Token from Cryptocurrency where Market_Cap BETWEEN 1000 AND 1000000;

# how many user are there using the exchange
select count(name) from User;

# Finds the average balance of all wallets in the exchanged 
select AVG(Balance) from Wallet;

#Show every transaction where someone bought something
SELECT * FROM Transaction WHERE Type='BUY';

#Show every cryptocurrency that sells at a price over $200
SELECT * FROM Cryptocurrency WHERE Price>200;

# show the user the crypto the date they bought or sold it 
SELECT User.name as Name, Transaction.Date as date, Transaction.Type as user_Action
FROM User
INNER JOIN Wallet ON User.user_id=Wallet.User_ID
INNER JOIN Transaction ON Transaction.Wallet_ID=Wallet.wallet_id
WHERE Transaction.Token='ETH' or Transaction.Token = 'BTC';

#shows the user with the amount of a certain crypto they own
SELECT User.name, count(User.name) as totalamount_ETH FROM User INNER JOIN Wallet ON User.user_id=Wallet.User_ID INNER JOIN Transaction ON Transaction.Wallet_ID=Wallet.wallet_id WHERE Transaction.Token='ETH' GROUP BY User.user_id;

# select the date of birth of everyone who bought Bitcoin
SELECT User.Date_of_birth FROM User INNER JOIN Wallet ON User.user_id=Wallet.User_ID INNER JOIN Transaction ON Transaction.Wallet_ID=Wallet.wallet_id WHERE Transaction.Token='BTC';

# "select the name of everyone who bought Ethereum"
SELECT User.name FROM User INNER JOIN Wallet ON User.user_id=Wallet.User_ID INNER JOIN Transaction ON Transaction.Wallet_ID=Wallet.wallet_id WHERE Transaction.Token='ETH';
