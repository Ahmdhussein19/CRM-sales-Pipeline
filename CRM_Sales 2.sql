USE CRM_Sales



select Sales_opportunity.sales_agent, manager, count( manager) as no_of_agents_for_manager
from [dbo].[Sales_opportunity]
join Sales_pipeline on Sales_pipeline.sales_agent = Sales_opportunity.sales_agent
group by manager,Sales_opportunity.sales_agent,Sales_pipeline.sales_agent

select *
from Sales_pipeline

---- close_date  and engage_date Months.

SELECT distinct MONTH(close_date) AS MonthNumber, YEAR(close_date)
FROM Sales_pipeline
order by MonthNumber

SELECT distinct MONTH(engage_date) AS MonthNumber, YEAR(engage_date)
FROM Sales_pipeline
order by MonthNumber
------------------------------

--checking missing sales_agents in sales opportunity table.

select  count (distinct sales_agent)
from Sales_pipeline

select  count(distinct sales_agent)
from Sales_opportunity

select  count(sales_agent)
from Sales_pipeline
where sales_agent is not null

select distinct t2.sales_agent as pipeline , t1.sales_agent as opp
from Sales_pipeline as t1
full join Sales_opportunity as t2 on t1.sales_agent = t2.sales_agent
where t1.sales_agent is null

--------------------------------------------------

-- EXPLORING MANAGERS

select count(distinct manager), manager
from Sales_opportunity
group by manager


select distinct count(manager), manager --count( manager) as no_of_agents_for_manager
from [dbo].[Sales_opportunity]
join Sales_pipeline on Sales_pipeline.sales_agent = Sales_opportunity.sales_agent
group by manager

------------------------------------------------

select*
from accounts

--Removing duplicates from dbo.Accounts
WITH CTE_Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY account, sector, year_established, revenue, employees, office_location
		   order BY account ASC) AS RowNum
    FROM Accounts
)
DELETE FROM CTE_Duplicates
WHERE RowNum > 1;

----------------------------------------
--checking missing accounts in accounts table comparing with sales_pipeline table

select distinct count(account)
from Accounts

select count  (distinct account)
from merged_sales


select distinct t2.account as acc_table , t1.account as pipeline_table
from Sales_pipeline as t1
left join Accounts as t2 on t1.account = t2.account
where t2.account is null or t1.account is null

---------------------------------------

--checking revenue diff in the 2 tables

select distinct t1.account as accounts_in_sales , 
t2.account as accounts_in_account, 
t1.revenue as rev_in_acc, 
sum(t2.Revenue) as rev_in_sales
from Accounts as t1
join Sales_pipeline as t2 on t1.account = t2.account
group by t2.account, t1.account, t1.Revenue
order by t1.account

select SUM(Revenue) as acc_revenue
from Accounts

select SUM(Revenue) as sales_revenue
from Sales_pipeline

--------------------------------------

-- Exploring Products details

select *
from Products

select count( distinct product)
from Sales_pipeline

select count(distinct product)
from Products

select distinct product, max(revenue)
from Sales_pipeline
group by product
order by max(revenue) desc

select *
from Sales_pipeline
where account = 'Donquadtech'

-------------------------------------

--	EXPLORING ACCOUNTS AND COMPANIES

select *
from merged_sales

select count( distinct account)
from Sales_pipeline

select count( distinct account)
from merged_sales

select count(distinct  account)
from Accounts

select *
from Accounts
where subsidiary_of is not null

select distinct t1.account, t2.account, subsidiary_of
from Sales_pipeline as t1
left join merged_sales as t2 on t1.account = t2.account

-----updating company names in sales pipeline

UPDATE Sales_pipeline
SET head_company = (SELECT subsidiary_of FROM Accounts WHERE account = Sales_pipeline.account)
WHERE Sales_pipeline.account not in (SELECT subsidiary_of FROM Accounts);

UPDATE Sales_pipeline 
SET Sales_pipeline.head_company = Sales_pipeline.account
WHERE EXISTS (
    SELECT 1
    FROM Sales_pipeline
    WHERE account = head_company
    AND Sales_pipeline.account <> Sales_pipeline.head_company  -- Ensure we are comparing different rows
);

UPDATE Sales_pipeline
SET head_company = Sales_pipeline.account
WHERE Sales_pipeline.account IN (
    SELECT t2.account 
    FROM Sales_pipeline AS t2 
    WHERE Sales_pipeline.account <> Sales_pipeline.head_company
);

select account, head_company
from Sales_pipeline