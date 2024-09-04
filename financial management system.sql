CREATE DATABASE financial_management_system
USE financial_management_system

 CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(50),
    AccountType VARCHAR(20),
    Balance DECIMAL(10, 2),
    CreatedAt DATE
)
INSERT INTO Accounts (AccountID, AccountName, AccountType, Balance, CreatedAt) 
VALUES
(1, 'Savings Account', 'Savings', 5000.00, '2024-01-01'),
(2, 'Checking Account', 'Checking', 1500.00, '2024-01-10'),
(3, 'Credit Card', 'Credit', -300.00, '2024-02-01'),
(4, 'Investment Account', 'Investment', 10000.00, '2024-03-01')


CREATE TABLE  Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    CategoryType VARCHAR(20)  
)
INSERT INTO Categories (CategoryID, CategoryName, categoryType) 
VALUES
(1, 'Salary', 'Income'),
(2, 'Groceries', 'Expense'),
(3, 'Rent', 'Expense'),
(4, 'Investments', 'Income')

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    CategoryID INT,
    Amount DECIMAL(10, 2),
    TransactionDate DATE,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
)

INSERT INTO Transactions (TransactionID, AccountID, CategoryID, Amount, TransactionDate) VALUES
(1, 1, 1, 2000.00, '2024-05-01'),
(2, 2, 2, -150.00, '2024-05-05'),
(3, 3, 3, -800.00, '2024-05-10'),
(4, 4, 4, -100.00, '2024-05-12')


CREATE TABLE  Budgets (
    BudgetID INT PRIMARY KEY,
    CategoryID INT,
    BudgetAmount DECIMAL(10, 2),
    Month VARCHAR(20),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
)

INSERT INTO Budgets (BudgetID, CategoryID, BudgetAmount, Month) 
VALUES
(1, 1, 500.00, 'May 2024'),
(2, 2, 800.00, 'May 2024'),
(3, 3, 150.00, 'May 2024'),
(4, 4, 3000.00, 'May 2024')


-- Select Query
SELECT * FROM accounts

SELECT * FROM categories+/

SELECT * FROM Transactions 

SELECT * FROM budgets




-- Query to select all transactions with account and category details
SELECT 
    t.TransactionID, 
    a.AccountName, 
    c.CategoryName, 
    t.Amount, 
    t.TransactionDate
FROM 
    Transactions t
JOIN 
    Accounts a ON t.AccountID = a.Account*+D
JOIN 
    Categories c ON t.CategoryID = c.CategoryID
ORDER BY 
    t.TransactionDate


-- Query to select transactions where the amount is greater than 100
SELECT 
    t.TransactionID, 
    a.AccountName, 
    c.CategoryName, 
    t.Amount
    t.AccountID
FROM 
    Transactions t
JOIN 
    Accounts a ON t.AccountID = a.AccountID
JOIN 
    Categories c ON t.CategoryID = c.CategoryID
WHERE 
    t.Amount > 100

-- Query to select Total income and expenses per account

SELECT 
    a.AccountName, 
    SUM( CASE WHEN t.Amount > 0 
		 THEN t.Amount 
		 ELSE 0
		 END) AS TotalIncome,
    SUM( CASE WHEN t.Amount < 0
		 THEN t.Amount
         ELSE 0
         END) AS TotalExpense
FROM 
    Transactions t
JOIN 
    Accounts a ON t.AccountID = a.AccountID
GROUP BY
	AccountName;


-- Compare budget vs. actual spending for each category
SELECT 
    c.CategoryName, 
    b.BudgetAmount,
   
    COALESCE(SUM(t.Amount), 0) AS ActualSpending,
    (b.BudgetAmount + COALESCE(SUM(t.Amount), 0)) AS BudgetVariance
FROM 
    Budgets b
 JOIN 
    Transactions t ON b.CategoryID = t.CategoryID 
JOIN 
    Categories c ON b.CategoryID = c.CategoryID
GROUP BY 
    c.CategoryName, b.BudgetAmount
ORDER BY 
    c.CategoryName;
    
    select sum(amount) from transactions
    
-- Query to select amount spend from cretain date

SELECT 
    c.CategoryName, 
    t. TransactionDate,
    
    SUM(t.Amount) AS TotalSpent
FROM 
    Transactions t
JOIN 
    Categories c ON t.CategoryID = c.CategoryID
WHERE 
t.TransactionDate BETWEEN '2024-05-01' AND '2024-05-2'
GROUP BY 
    c.CategoryName, t.TransactionDate
   




