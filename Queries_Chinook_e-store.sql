/*Joining the album table with the artist table*/
SELECT *
FROM Album
JOIN Artist
ON album.ArtistId = artist.ArtistId;


/*Joining the invoice table with the customer table*/
SELECT firstname, lastname, invoicedate, billingcountry, total
FROM invoice
JOIN Customer
ON customer.customerid = invoice.CustomerId;

/*Question 1: Which countries have the most Invoices?*/
SELECT BillingCountry, COUNT(total) invoices
FROM Invoice
GROUP BY 1
ORDER BY 2 DESC;


/*Country with the maximum number of invoice total*/
SELECT customer.country, MAX(invoice.total)
FROM Customer
JOIN Invoice
ON customer.customerid = invoice.customerid
ORDER BY 2 DESC;


/* Which city has the best customers?*/
SELECT billingcity, SUM(UnitPrice)
FROM invoice
JOIN InvoiceLine
ON invoice.invoiceid = invoiceline.invoiceid
GROUP BY billingcity
ORDER BY 2 DESC;

/* Who is the best customer?*/
SELECT customer.customerid, SUM(unitprice)
FROM InvoiceLine
JOIN Invoice
ON invoice.invoiceid = invoiceline.invoiceid
JOIN Customer
ON invoice.CustomerId = customer.customerid
GROUP BY customer.customerid
ORDER BY 2 DESC;


/* Which top 3 customers had the highest total of invoices?*/
SELECT Customer.CustomerId, MAX(total)
FROM Customer
JOIN Invoice
ON customer.CustomerId=invoice.CustomerId
GROUP BY customer.CustomerId
ORDER BY 2 DESC
LIMIT 3

/* Top 10 cities with the highest number of total invoices*/
SELECT City, MAX(total)
FROM Customer
JOIN Invoice
ON customer.CustomerId=invoice.CustomerId
Group by 1
ORDER by 2 DESC
LIMIT 10


/* What are the top 3 cities*/
SELECT customer.City, SUM(UnitPrice)
FROM Invoiceline
JOIN Invoice
ON invoiceline.invoiceid=invoice.invoiceid
JOIN Customer
ON Customer.customerid = invoice.customerid
GROUP BY City
ORDER BY 2 DESC
Limit 3

/* top 5 billing countries*/
SELECT invoice.BillingCountry, COUNT(UnitPrice)
FROM Invoiceline
JOIN Invoice
ON invoiceline.invoiceid=invoice.invoiceid
GROUP BY BillingCountry
ORDER BY 2 DESC
Limit 5
________________________

/* Top 10 customers*/
SELECT FirstName, LastName, SUM(total)
FROM customer
JOIN Invoice
ON customer.customerid = invoice.CustomerId
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;

/*Who are the top 5 artists to produce most albums?*/
SELECT artist.name, COUNT(album.artistid) AS Produced_albums
FROM Album
JOIN Artist
on album.ArtistId = Artist.ArtistId
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

/* Number of tracks sold per genre*/
SELECT (invoiceline.trackid * invoiceline.Quantity) AS number_of_tracks, genre.name
FROM InvoiceLine
JOIN Track
ON invoiceline.trackid = track.TrackId
JOIN Genre
ON genre.GenreId = track.GenreId
GROUP BY genre.name
ORDER BY 1 DESC


/*Rock sales per year*/

SELECT STRFTIME('%Y', invoice.InvoiceDate) AS Year,
		(invoiceline.trackid *invoiceline.Quantity) * invoiceline.UnitPrice AS Sales,
		genre.name
FROM Invoice
JOIN InvoiceLine
ON invoiceline.invoiceid = invoice.InvoiceId
JOIN Track
ON track.trackid = invoiceline.TrackId
JOIN Genre
ON track.genreid = genre.GenreId
WHERE genre.name = 'Rock'
GROUP BY genre.name, 1
