W3

Q1:    Using a subquery, find the names of all the tracks for the album "Californication".

SELECT t.AlbumId, t.TrackId, t.Name, al.Title
FROM Tracks as t
LEFT JOIN Albums as al on al.AlbumId=t.AlbumId
WHERE al.Title="Californication"
--GROUP BY t.Name



SELECT t.TrackId, t.Name, al.Title
FROM Tracks as t
LEFT JOIN Albums as al on t.AlbumId=al.AlbumId
--WHERE al.Title="Californication"

Q2: Find the total number of invoices for each customer along with the 
customer's full name, city and email.

SELECT  i.InvoiceId, c.FirstName, c.LastName, c.City, c.Email
FROM Invoices as i
LEFT JOIN Customers as c on c.CustomerId=i.CustomerId

Consider the resulting table as a separate entity as a 
and now fetch a.FirstName, a.LastName, a.City, a.Email, and count on invoiceID as total_invoices
count(a.InvoiceId) as total_invoices from a

the final code is:

SELECT a.FirstName, a.LastName, a.City, a.Email, count(a.InvoiceId) as total_invoices
FROM (SELECT  i.InvoiceId, c.FirstName, c.LastName, c.City, c.Email
FROM Customers as c
LEFT JOIN Invoices as i on c.CustomerId=i.CustomerId) as a
group by a.FirstName
having a.FirstName="František"





q3: Retrieve the track name, album, artistID, 
and trackID for all the albums.

SELECT t.Name, t.TrackId, al.Title, al.AlbumId, al.ArtistId
FROM Tracks as t
LEFT JOIN Albums as al on al.AlbumId=t.AlbumId

What is the song title of trackID 12 
from the "For Those About to Rock We Salute You" album? Enter the answer below.

--SELECT t.Name, t.TrackId, al.Title, al.AlbumId, al.ArtistId
--FROM Tracks as t
--LEFT JOIN Albums as al on al.AlbumId=t.AlbumId
--WHERE al.Title like "For Those About to Rock We Salute You" and t.TrackId=12

SELECT tracks.TrackId,
       tracks.Name,
       Albums.Title,
       Albums.ArtistId
FROM tracks INNER JOIN Albums
  ON tracks.AlbumId = Albums.AlbumId
  WHERE tracks.TrackId=12 and Albums.Title like "For Those About to Rock We Salute You"



Q4:  Retrieve a list with the managers last name, and 
the last name of the employees who report to him or her.

SELECT em.LastName, em.FirstName, em.ReportsTo
FROM Employees as em
LEFT JOIN Customer as c on  em.LastName=c.LastName


After running the query described above, 
who are the reports for the manager named Mitchell (select all that apply)?


select a.LastName as EmployeeLast,a.ReportsTo,b.LastName as ManagerLast
from Employees as a
left join Employees as b
on a.ReportsTo=b.EmployeeId
where b.LastName like "Mitchell"

other one is:

SELECT M.LastName AS Managers,
       E.LastName AS Employees
FROM Employees E INNER JOIN Customers M
  ON E.ReportsTo = M.EmployeeId;


Q5: 
Find the name and ID of the artists who do not have albums.

SELECT ar.ArtistId, ar.Name, al.AlbumId, al.Title
FROM Artists as ar
LEFT JOIN Albums as al on ar.ArtistId=al.ArtistId
WHERE al.AlbumId is null

since this query gives us a table with all we asked for,
we, now, count the tracks for all the names
for this consider the above table as a
and then ask for a.Name, count(a.Name) FROM a GROUP BY a.Name 
ORDER BY COUNT(a.Name) asc

The Code is:

SELECT a.Name, COUNT(a.Name) as total_tracks
FROM (SELECT ar.ArtistId, ar.Name, al.AlbumId, al.Title
FROM Artists as ar
LEFT JOIN Albums as al on ar.ArtistId=al.ArtistId
WHERE al.AlbumId is null) as a
GROUP BY a.Name
ORDER BY total_tracks asc

After running the query described above, 
two of the records returned have the same last name. Enter that name below.



Q6:  
Use a UNION to create a list of all the employee's and customer's first names 
and last names ordered by the last name in descending order.

SELECT FirstName, LastName FROM Employees
UNION 
SELECT FirstName, LastName FROM Customers
ORDER BY LastName DESC


Q7: See if there are any customers who have a different 
city listed in their billing city versus their customer city.

SELECT c.FirstName, c.LastName, i.BillingCity, c.City
FROM Customers as c
LEFT JOIN Invoices as i on c.CustomerId=i.CustomerId
WHERE  c.City <> i.BillingCity

select Customers.FirstName,Customers.City,Invoices.BillingCity
from Customers
left join Invoices
on Customers.CustomerId=Invoices.CustomerId
where Customers.City<>Invoices.BillingCity
