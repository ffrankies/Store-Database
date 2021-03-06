/*
Our info
*/
--Drop tables in case they already exist
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE ShippingDetails CASCADE CONSTRAINTS;
DROP TABLE Artist CASCADE CONSTRAINTS;
DROP TABLE Album CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Track CASCADE CONSTRAINTS;
DROP TABLE Purchasing CASCADE CONSTRAINTS;
DROP TABLE AppearsIn CASCADE CONSTRAINTS;
DROP TABLE ContributingArtists CASCADE CONSTRAINTS;
--
--
CREATE TABLE Customer
(
CID  INTEGER,
CName CHAR(20) NOT NULL,
Email CHAR(50),
Password CHAR(32),
--
CONSTRAINT CPRK PRIMARY KEY (CID),
CONSTRAINT CUNQ UNIQUE (Email)
);
--
--
CREATE TABLE ShippingDetails
(
SID INTEGER,
Street1 CHAR(20) NOT NULL,
Street2 CHAR(20),
State CHAR(2) NOT NULL,
Zip INTEGER NOT NULL,
CustomerID INTEGER NOT NULL,
CONSTRAINT SPRK PRIMARY KEY (SID),
CONSTRAINT SFRK FOREIGN KEY (CustomerID)
                REFERENCES Customer (CID)
                ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED
);
--
--
CREATE TABLE Artist
(
ArtistID INTEGER,
ArtistName CHAR(20) NOT NULL,
CONSTRAINT ARPRK PRIMARY KEY (ArtistID)
);
--
--
CREATE TABLE Album
(
AlbumID INTEGER,
AlbumTitle CHAR(20) NOT NULL,
Stock INTEGER NOT NULL,
Price NUMBER(18,2) NOT NULL,
ReleaseYear INTEGER NOT NULL,
ArtistID INTEGER NOT NULL,
CONSTRAINT ALPRK PRIMARY KEY(AlbumID),
CONSTRAINT ALFRK FOREIGN KEY (ArtistID)
                 REFERENCES Artist(ArtistID)
                 ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT AlSTOCK CHECK (Stock > -1 AND Stock < 1001),
CONSTRAINT AlPRICE CHECK (NOT (ReleaseYear < 2000 AND price > 10.00))
);
--
--
CREATE TABLE Orders
(
OrderID INTEGER ,
OrderDate DATE NOT NULL,
CustomerID INTEGER NOT NULL,
DestinationID INTEGER,
Status CHAR(20) NOT NULL,
CONSTRAINT OPRK PRIMARY KEY (OrderID),
CONSTRAINT OCFRK FOREIGN KEY(CustomerID)
                 REFERENCES Customer(CID)
                 ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT ODFRK FOREIGN KEY(DestinationID)
                 REFERENCES ShippingDetails(SID)
                 ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED
);
--
--
CREATE TABLE Track
(
AlbumID INTEGER NOT NULL,
TNum INTEGER NOT NULL,
TrackName char(25) NOT NULL,
Duration INTEGER NOT NULL,
CONSTRAINT TPRK PRIMARY KEY(AlbumID,TNum),
CONSTRAINT TDurChk CHECK (Duration > 0),
CONSTRAINT TFRK FOREIGN KEY(AlbumID)
                REFERENCES Album(AlbumID)
                ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED
);
--
--
CREATE TABLE ContributingArtists
(
ArtistID INTEGER,
ContributingArtist CHAR(20),
CONSTRAINT CAPrimaryKey PRIMARY KEY (ArtistID,ContributingArtist),
CONSTRAINT CAFRK FOREIGN KEY (ArtistID)
                 REFERENCES Artist(ArtistID)
                 ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED
);
--
--
CREATE TABLE Purchasing
(
OrderID INTEGER,
AlbumID INTEGER NOT NULL,
CONSTRAINT PPRK PRIMARY KEY (OrderID, AlbumID),
CONSTRAINT PFRK1 FOREIGN KEY (OrderID)
                 REFERENCES Orders(OrderID)
                 ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT PFRK2 FOREIGN KEY (AlbumID)
                 REFERENCES Album(AlbumID)
                 ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
--
CREATE TABLE AppearsIn
(
ArtistID INTEGER NOT NULL,
AlbumID INTEGER NOT NULL,
CONSTRAINT AIPRK PRIMARY KEY (ArtistID,AlbumID),
CONSTRAINT AIFRK1 FOREIGN KEY (ArtistID)
                  REFERENCES Artist(ArtistID)
                  ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT AIFRK2 FOREIGN KEY (AlbumID)
                  REFERENCES Album(AlbumID)
                  ON DELETE CASCADE  DEFERRABLE INITIALLY DEFERRED
);
