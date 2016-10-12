--
-- Queries for database
--
-------------------------------------------------------------------------------
--Select all from Customer Table
-------------------------------------------------------------------------------
SELECT *
FROM Customer;
-------------------------------------------------------------------------------
--Select all from ShippingDetails Table
-------------------------------------------------------------------------------
SELECT *
FROM ShippingDetails;
-------------------------------------------------------------------------------
--Select all from CustomerOrders Table
-------------------------------------------------------------------------------
SELECT *
FROM CustomerOrders;
-------------------------------------------------------------------------------
--Select all from Purchasing Table
-------------------------------------------------------------------------------
SELECT *
FROM Purchasing;
-------------------------------------------------------------------------------
--Select all from Tracks Table
-------------------------------------------------------------------------------
SELECT *
FROM Tracks;
-------------------------------------------------------------------------------
--Select all from Albums Table
-------------------------------------------------------------------------------
SELECT *
FROM Albums;
-------------------------------------------------------------------------------
--Select all from Appears_In Table
-------------------------------------------------------------------------------
SELECT *
FROM Appears_In;
-------------------------------------------------------------------------------
--Select all from Artist Table
-------------------------------------------------------------------------------
SELECT *
FROM Artists;
-------------------------------------------------------------------------------
--A join involving at least four relations.
--Select the first AND last names of all customers who bought an album by
--Muse
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O, Purchasing P, Albums A, Appears_In I, Artists Ar
WHERE C.CustomerID = O.CustomerID AND
      O.OrderID = P.OrderID AND
      P.AlbumID = I.AlbumID AND
      I.ArtistID = Ar.ArtistID AND
      Ar.ArtistName = 'The Beatles'
ORDER BY C.LastName;
-------------------------------------------------------------------------------
--A self-join.
--Find pairs names of all customers who have the same first name
-------------------------------------------------------------------------------
SELECT C1.FirstName, C1.LastName, C2.FirstName, C2.LastName
FROM Customer C1, Customer C2
WHERE C1.FirstName = C2.FirstName AND
      C1.CustomerID <> C2.CustomerID AND
      C1.LastName < C2.LastName
ORDER BY C1.LastName;
-------------------------------------------------------------------------------
--UNION
--Find the first AND last names of all customers who have either bought Albums
--using promocodes, or bought old albums (released before 2000)
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O
WHERE C.CustomerID = O.CustomerID AND
      O.Promocode IS NOT NULL
UNION
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O, Purchasing P, Albums A
WHERE C.CustomerID = O.CustomerID AND
      O.OrderID = P.OrderID AND
      P.AlbumID = A.AlbumID AND
      A.ReleaseYear < 2000;
-------------------------------------------------------------------------------
-- INTERSECT
--Find the first AND last names of all customers who have  bought new albums
--(released after 2000) using promocodes, and who make their purchases at the
--store (which means they don't have e-mail addresses stored with the store)
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O, Purchasing P, Albums A
WHERE C.CustomerID = O.CustomerID AND
      O.Promocode IS NOT NULL AND
      O.OrderID = P.OrderID AND
      P.AlbumID = A.AlbumID AND
      A.ReleaseYear > 2000
INTERSECT
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C
WHERE C.Email IS NOT NULL;
-------------------------------------------------------------------------------
--MINUS
--Find the first and last names of all customers who have bought new Albums
--(released after 2000), but have not used promocodes
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O, Purchasing P, Albums A
WHERE C.CustomerID = O.CustomerID AND
      O.OrderID = P.OrderID AND
      P.AlbumID = A.AlbumID AND
      A.ReleaseYear > 2000
MINUS
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders O
WHERE C.CustomerID = O.CustomerID AND
      O.Promocode IS NULL;
-------------------------------------------------------------------------------
--SUM
--Find the album title and recording artist for the three longest albums
-------------------------------------------------------------------------------
SELECT *
FROM (SELECT A.AlbumTitle, Ar.ArtistName, SUM(T.Duration_Seconds) "Duration"
      FROM Albums A, Appears_In I, Artists Ar, Tracks T
      WHERE A.AlbumID = I.AlbumID AND
            I.Role LIKE '%Recording Artist%' AND
            I.ArtistID = Ar.ArtistID AND
            A.AlbumID = T.AlbumID
      GROUP BY A.AlbumTitle, Ar.ArtistName
      ORDER BY SUM(T.Duration_Seconds) DESC)
WHERE ROWNUM < 4;
-------------------------------------------------------------------------------
--AVG
--Find all artist's who's average length of song is atleast 3 minutes AND 30 seconds across an album(individual albums)
-------------------------------------------------------------------------------
SELECT DISTINCT A.AlbumTitle, A.RecordingArtist
FROM Albums A, Tracks T
WHERE T.AlbumID = A.AlbumID
GROUP BY A.RecordingArtist, A.AlbumTitle
HAVING AVG(T.Duration_Seconds) > 210
ORDER BY A.AlbumTitle;
-------------------------------------------------------------------------------
--MAX
--Find all albums who have all songs under 6 minutes long
-------------------------------------------------------------------------------
SELECT DISTINCT A.AlbumTitle, A.RecordingArtist
FROM Albums A, Tracks T
WHERE T.AlbumID = A.AlbumID
GROUP BY A.RecordingArtist, A.AlbumTitle
HAVING Max(T.Duration_Seconds) < 360
ORDER BY A.AlbumTitle;
-------------------------------------------------------------------------------
--MIN.
--Find all albums who have all song that is over 3 minutes long
-------------------------------------------------------------------------------
SELECT DISTINCT A.AlbumTitle, A.RecordingArtist
FROM Albums A, Tracks T
WHERE T.AlbumID = A.AlbumID
GROUP BY A.RecordingArtist, A.AlbumTitle
HAVING MIN(T.Duration_Seconds) > 180
ORDER BY A.AlbumTitle;
-------------------------------------------------------------------------------
--GROUP BY, HAVING, AND ORDER BY, all appearing in the same query
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
--A correlated subquery.
--Find the artists whose albums are worth more than average in the same genre
-------------------------------------------------------------------------------
SELECT DISTINCT A1.ArtistName
FROM Albums A1
WHERE A1.Price > (Select AVG(A1.Price)
                  FROM Albums A2, Genres G1, Genres G2
                  WHERE A1.AlbumID = G1.AlbumID AND A2.AlbumID = G2.AlbumID AND G1.Genre = G2.Genre;
-------------------------------------------------------------------------------
--A non-correlated subquery.
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
--A relational DIVISION query.
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
--An outer join query.
-------------------------------------------------------------------------------
--
