/*48*/
CREATE OR ALTER FUNCTION dbo.getOrderTotalValue(
    @quantity smallint,
    @unit_price money
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @unit_price;
END;

CREATE OR ALTER FUNCTION dbo.getCustomerGroup(@order_value DEC(10,2))
RETURNS varchar(20)
AS 
BEGIN
    RETURN
		CASE 
			when @order_value >= 0		and @order_value  < 1000 	then 'low'
			when @order_value >= 1000	and @order_value  < 5000 	then 'medium'
			when @order_value >= 5000	and @order_value  < 10000	then 'high'
			when @order_value >= 10000				 				then 'very high'
	    END 
END;

with base as (
    SELECT
		order_.CustomerID
		, sum(dbo.getOrderTotalValue(orderDetails.Quantity, orderDetails.UnitPrice))	as allOrdersTotalValue 
      FROM dbo.Orders 			order_
inner join dbo.OrderDetails 	orderDetails on orderDetails.OrderID = order_.OrderID
     where YEAR(order_.OrderDate) = 2016
  group by order_.CustomerID
)
SELECT
		base.CustomerID
		, customer.CompanyName
		, base.allOrdersTotalValue
		, dbo.getCustomerGroup(base.allOrdersTotalValue) as CustomerGroup
      from base
inner join dbo.Customers customer on customer.CustomerID = base.CustomerID
  order by base.CustomerID

  
/* 49 
 * 
 * Aufgabe 49 ist Korrektur fuer Aufgabe 48
 * Aufgabe ist aber schon korrekt.
 * 
 * Fehler: "between" darf nicht verwendet werden, weil es keine Kommazahlen beruecksichtigt.
 * Dadurch faellt z. B. "5000.20" raus.
 * */

/* 50 
 * */

with allOrdersTotalValue as (
    SELECT
		order_.CustomerID
		, sum(dbo.getOrderTotalValue(orderDetails.Quantity, orderDetails.UnitPrice))	as allOrdersTotalValue 
      FROM dbo.Orders 			order_
inner join dbo.OrderDetails 	orderDetails on orderDetails.OrderID = order_.OrderID
     where YEAR(order_.OrderDate) = 2016
  group by order_.CustomerID
)
, CustomerGroup as (
    SELECT
		dbo.getCustomerGroup(allOrdersTotalValue.allOrdersTotalValue) 	as CustomerGroupName
		, count(1)														as TotalInGroup
      from allOrdersTotalValue
inner join dbo.Customers customer on customer.CustomerID = allOrdersTotalValue.CustomerID
  group by dbo.getCustomerGroup(allOrdersTotalValue.allOrdersTotalValue)
)
  select
		CustomerGroup.CustomerGroupName
		, CustomerGroup.TotalInGroup
		, (
			cast(CustomerGroup.TotalInGroup as float) 
			/ 
			(select cast(sum(CustomerGroup.TotalInGroup) as float) from CustomerGroup)
		) as PercentageInGroup								
    from CustomerGroup
order by CustomerGroup.TotalInGroup desc
  
/* 51 */
with allOrdersTotalValue as (
    SELECT
		order_.CustomerID
		, customer.CompanyName 
		, sum(dbo.getOrderTotalValue(orderDetails.Quantity, orderDetails.UnitPrice))	as allOrdersTotalValue 
      FROM dbo.Orders 			order_
inner join dbo.OrderDetails 	orderDetails on orderDetails.OrderID = order_.OrderID
inner join dbo.Customers 		customer	 on customer.CustomerID  = order_.CustomerID
     where YEAR(order_.OrderDate) = 2016
  group by order_.CustomerID
		  , customer.CompanyName 
)
    SELECT
    	allOrdersTotalValue.CompanyName 
    	, allOrdersTotalValue.allOrdersTotalValue
    	, groupings.CustomerGroupName 
      from allOrdersTotalValue
inner join dbo.CustomerGroupThresholds groupings on allOrdersTotalValue.allOrdersTotalValue >= groupings.RangeBottom 
												and allOrdersTotalValue.allOrdersTotalValue < groupings.RangeTop 
  
  
/* 52 */											
select distinct
	customers.Country
  from dbo.Customers customers
union
select distinct
	suppliers.Country
  from dbo.Suppliers suppliers

/* 53 */
	     select distinct
			suppliers.Country	as suppliersCountry
			, customers.Country	as customersCountry
           from dbo.Suppliers suppliers
full outer join dbo.Customers customers on customers.Country = suppliers.Country
       order by 1 asc
       
/* 53 alternative Schreibweise */
select
	suppliersCountry = suppliers.Country
 from dbo.Suppliers suppliers

											
												
												
												
												
												
												
												
												
												
												
												
												
												
												
												
												
  