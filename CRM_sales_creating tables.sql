use CRM_sales
drop table Sales_Opportunity
CREATE TABLE Sales_Opportunity (
    Manager VARCHAR(100),          -- Adjust size as needed
    Regional_Office VARCHAR(100),  -- Adjust size as needed
    Sales_Agent VARCHAR(100)       -- Adjust size as needed
);
drop table Accounts
CREATE TABLE Accounts (
    --id INT PRIMARY KEY IDENTITY(1,1),        -- Adding an ID column as the primary key
    account NVARCHAR(100) NOT NULL,         -- Column for the account name
    sector NVARCHAR(100),                    -- Column for the sector
    year_established INT,                    -- Column for the year the account was established
    revenue DECIMAL(18, 2),                  -- Column for revenue (with 2 decimal places)
    employees INT,                           -- Column for the number of employees
    office_location NVARCHAR(100),
	subsidiary_of NVARCHAR(100)              -- Column for the office location
);
drop table Products
CREATE TABLE Products (
    --id INT PRIMARY KEY IDENTITY(1,1),        -- Adding an ID column as the primary key
    product NVARCHAR(100) NOT NULL,         -- Column for the product name
    series NVARCHAR(100),                    -- Column for the product series
    sales_price DECIMAL(18, 2)                     -- Column for the product price (with 2 decimal places)
);
drop table Sales_Pipeline
CREATE TABLE Sales_Pipeline (
    --id INT PRIMARY KEY IDENTITY(1,1),         -- Adding an ID column as the primary key
    opportunity_id NVARchar (100) NOT NULL,              -- Column for the opportunity ID (foreign key reference)
    sales_agent NVARCHAR(100),                -- Column for the sales agent's name
    product NVARCHAR(100),                    -- Column for the product name
    account NVARCHAR(100),                    -- Column for the account name
    deal_stage NVARCHAR(100),                 -- Column for the deal stage
    engage_date DATE,                         -- Column for the engagement date
    close_date DATE,                          -- Column for the close date
    revenue DECIMAL(18, 2),                   -- Column for revenue (with 2 decimal places)
    dealtime INT                              -- Column for the deal time (in days or appropriate unit)
);
drop table merged_sales
CREATE TABLE merged_sales (
    account NVARCHAR(255) NOT NULL,
    sector NVARCHAR(255) NOT NULL,
    year_established INT NOT NULL,
    account_revenue FLOAT NOT NULL,
    employees INT NOT NULL,
    office_location NVARCHAR(255) NOT NULL,
    subsidiary_of NVARCHAR(255) NOT NULL,
    opportunity_id NVARCHAR(255) NOT NULL,
    sales_agent NVARCHAR(255) NOT NULL,
    product NVARCHAR(255) NOT NULL,
    deal_stage NVARCHAR(255) NOT NULL,
    engage_date DATETIME NULL,  -- Allows NULL values
    close_date DATETIME NULL,   -- Allows NULL values
    agent_revenue FLOAT NULL,         -- Allows NULL values
	dealtime FLoat Null
);


