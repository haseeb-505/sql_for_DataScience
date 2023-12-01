--q1:
--Pull a list of customer ids with the customer’s full name, and address, along with combining their city and country together. 
--Be sure to make a space in between these two and make it UPPER CASE. (e.g. LOS ANGELES USA)

--select c.CustomerId, c.FirstName, c.LastName, c.Address, c.City, c.Country, 
--select CONCAT(c.CustomerId, c.FirstName, c.LastName, c.Address, c.City, c.Country)
select CustomerId, FirstName, LastName, 
(FirstName || ' ' || LastName) as FullName,  Address, 
City, Country, UPPER( City || ' ' || Country) as CityCountry
FROM Customers
where CustomerId=16

--q2:
--Create a new employee user id by combining the first 4 letters of the employee’s first name with the first 2 letters of the employee’s last name. 
--Make the new field lower case and pull each individual step to show your work.
--

select e.FirstName, e.LastName, substr(e.FirstName, 1,4) || substr(e.LastName, 1,2) as CustomerNewId
from Employees as e
--What is the final result for Robert King?
where FirstName="Robert" and LastName="King"

--q3:
--Show a list of employees who have worked for the company for 15 or more years using the current date function. 
--Sort by lastname ascending.
--

select e.FirstName, e.LastName, e.HireDate,
(strftime('%Y', 'now') - strftime('%Y', HireDate))
- (strftime('%m-%d', 'now')<strftime('%m-%d', HireDate)) as WorkingYears
from Employees as e
--who have worked for the company for 15 or more years
where WorkingYears>=15
--Sort by lastname ascending.
order by LastName asc

--q4: Profiling the Customers table, answer the following question.

select c.PostalCode, c.Address, c.Company, c.FirstName, c.Fax, c.Phone
from Customers as c
--Are there any columns with null values? 
--Indicate any below. Select all that apply.
where (
    --c.PostalCode is not null 
    --c.Address is not null 
    --c.Company is not null 
    --c.FirstName is not null 
    --c.Fax is not null 
    c.Phone is not null
)

--q5: Find the cities with the most customers and rank in descending order.
--

select c.CustomerId, c.FirstName, c.LastName, c.City, count(c.CustomerId)
from Customers as c
group  by c.City
order  by count(c.CustomerId) desc
 
--other method is:
SELECT City,
       COUNT(*)
FROM Customers
GROUP BY City
ORDER BY COUNT(*) DESC


--q6:
--

SELECT C.FirstName,
       C.LastName,
       I.InvoiceId,
       C.FirstName || C.LastName || I.InvoiceID AS NewId
FROM Customers C INNER JOIN Invoices I
ON C.CustomerId = I.CustomerID
WHERE NewId LIKE 'AstridGruber%'


















