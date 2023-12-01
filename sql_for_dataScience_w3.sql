
--How many albums does the artist Led Zeppelin have? 

select count(*) from (select * 
from artists as ar
left join albums as al
on ar.ArtistId=al.ArtistId)
where name="Led Zeppelin";

--Q2: Create a list of album titles and the unit prices for the artist "Audioslave".

select a.UnitPrice,b.Title,b.Name
from (select tracks.AlbumId,invoice_items.UnitPrice
from tracks
left join invoice_items
on tracks.TrackId=invoice_items.TrackId) as a
left join (select artists.Name,albums.Title,albums.AlbumId
from artists
left join albums
on artists.ArtistId=albums.ArtistId) as b
on a.AlbumId=b.AlbumId
where b.Name="Audioslave";

--other way to do so is:

select ar.ArtistId, ar.Name, a.Title, a.UnitPrice
from  (select al.ArtistId, al.Title, t.TrackId, t.UnitPrice
        from albums as al
        left join tracks as t on t.AlbumId=al.AlbumId) as a
left join artists as ar on ar.ArtistId=a.ArtistId
where ar.Name="Audioslave"


--q3: Find the first and last name of any customer who does not have an invoice. Are there any customers returned from the query?  

select customers.FirstName,customers.LastName,
invoices.InvoiceId
from customers
left join invoices
on customers.CustomerId=invoices.CustomerId
where invoices.InvoiceId is null;

--other way to do so is:

select c.FirstName, c.LastName, i.InvoiceId
from invoices as i
left join customers as c
on c.CustomerId=i.CustomerId
where i.InvoiceId is null

--q4: Find the total price for each album.
--What is the total price for the album “Big Ones”?

select sum(b.UnitPrice) as TotalPrice,b.Title as Title
from (select a.UnitPrice as UnitPrice,albums.Title as Title
from (select tracks.AlbumId,invoice_items.UnitPrice
from tracks
left join invoice_items
on tracks.TrackId=invoice_items.TrackId) as a 
left join albums
on a.AlbumId=albums.AlbumId
where albums.Title="Big Ones") as b

--other way to do so is:

select a.AlbumId, al.Title, a.UnitPrice, a.Quantity
from (select t.AlbumId, t.TrackId, t.UnitPrice, ii.Quantity
      from invoice_items as ii
      left join tracks as t
      on ii.TrackId=t.TrackId) as a
left join albums as al on al.AlbumId=a.AlbumId
where al.Title="Big Ones"

--untill now, we have retrieved a table with 
--AlbumId, Albums'Title, UnitPrice, and Quantity
--where Album Title is "Big Ones"

--Now to find the sum, we need to sum up the unitprice column for all the "Big Ones"
--We name this table as b and then apply the furhter query;
--The final code is:
 select count(B.AlbumId) as TotalAlbums, b.AlbumId as AlbumId, b.Title as Title, b.UnitPrice as UnitPrice, sum(b.UnitPrice) as TotalPrice
 from   (select a.AlbumId, a.TrackId, al.Title, a.UnitPrice, a.Quantity
        from (select t.AlbumId, t.TrackId, t.UnitPrice, ii.Quantity
            from invoice_items as ii
            left join tracks as t
            on ii.TrackId=t.TrackId) as a
        left join albums as al on al.AlbumId=a.AlbumId
         where al.Title="Big Ones") as b


