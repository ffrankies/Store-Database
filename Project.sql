SPOOL project.out; --we had problems with our first line, this fixed it
SPOOL project.out;
SET ECHO ON;
/*
CIS 353 - Database Design Project - Team 7
<Frank Derry Wanye>
<Ron Patrick>
<Jordan Zomerlei>
<Kevin Bush>
*/
--
drop table Genres cascade constraints;
drop table Tracks cascade constraints;
drop table Appears_In cascade constraints;
drop table Artists cascade constraints;
drop table Awards cascade constraints;
drop table Albums cascade constraints;
drop table CustomerOrders cascade constraints;
drop table Purchasing cascade constraints;
drop table ShippingDetails cascade constraints;
drop table Customer cascade constraints;
--
CREATE TABLE Customer
(
CustomerID INTEGER,
LastName VARCHAR2(9) NOT NULL,
FirstName VARCHAR2(8) NOT NULL,
Email VARCHAR2(27),
Password VARCHAR2(32),
CONSTRAINT CustomerPrimeKey PRIMARY KEY (CustomerID),
CONSTRAINT UniqueEmail UNIQUE (Email)
);
--
CREATE TABLE ShippingDetails
(
ShippingID INTEGER,
CustomerID INTEGER,
Street VARCHAR2(22) NOT NULL,
City VARCHAR2(17),
State CHAR(2) NOT NULL,
Zip CHAR(6) NOT NULL,
CONSTRAINT ShipDetailsPrimeKey PRIMARY KEY (ShippingID),
CONSTRAINT ShipCustRelation FOREIGN KEY (CustomerID)
                REFERENCES Customer (CustomerID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE CustomerOrders
(
OrderID INTEGER,
DateOrdered DATE NOT NULL,
CustomerID INTEGER,
Promocode INTEGER,
OrderStatus CHAR(16) NOT NULL,
CONSTRAINT OrdersPrimeKey PRIMARY KEY (OrderID),
CONSTRAINT OrdersCustRelation FOREIGN KEY (CustomerID)
                REFERENCES Customer (CustomerID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT StatusCheck CHECK (OrderStatus IN ('Delivered','Shipped','Being Processed','Pending Approval'))
);
--
CREATE TABLE Purchasing
(
AlbumID INTEGER NOT NULL,
OrderID INTEGER NOT NULL,
Quantity INTEGER NOT NULL,
CONSTRAINT PurchPrimeKey PRIMARY KEY(OrderID,AlbumID),
CONSTRAINT PurchForeignKey FOREIGN KEY(OrderID)
                REFERENCES CustomerOrders(OrderID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Albums
(
AlbumID INTEGER NOT NULL,
AlbumTitle VARCHAR2(45),
RecordLabel VARCHAR2(27),
QuantityOnHand INTEGER NOT NULL,
ReleaseYear INTEGER NOT NULL,
Price NUMBER(8,2) NOT NULL,
CONSTRAINT AlbumsPrimeKey PRIMARY KEY(AlbumID),
CONSTRAINT Albums_stock CHECK (QuantityOnHand > -1 AND QuantityOnHand < 1001),
CONSTRAINT Albums_price CHECK (NOT (ReleaseYear < 2000 AND Price > 10.00))
);
--
CREATE TABLE Artists
(
ArtistID INTEGER,
ArtistName VARCHAR2(16) NOT NULL,
Nationality VARCHAR2(3),
CONSTRAINT ArtistPrimeKey PRIMARY KEY(ArtistID)
);
--
CREATE TABLE Appears_In
(
AlbumID INTEGER,
ArtistID INTEGER,
Role VARCHAR2(44),
CONSTRAINT AppearsInPrimeKey PRIMARY KEY(ArtistID,AlbumID)
);
--
CREATE TABLE Tracks
(
TNum INTEGER NOT NULL,
AlbumID INTEGER NOT NULL,
Duration_Seconds INTEGER NOT NULL,
Track_Name VARCHAR2(50),
CONSTRAINT TrackPrimeKey PRIMARY KEY(AlbumID,TNum),
CONSTRAINT TrackDurCheck CHECK (Duration_Seconds > 0),
CONSTRAINT TrackForeignKey FOREIGN KEY(AlbumID)
                REFERENCES Albums(AlbumID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Genres
(
AlbumID INTEGER NOT NULL,
Genre VARCHAR2(11),
CONSTRAINT GenresPrimeKey PRIMARY KEY(AlbumID,Genre),
CONSTRAINT GenresForeignKey FOREIGN KEY(AlbumID)
                REFERENCES Albums(AlbumID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
CREATE TABLE Awards
(
ArtistID INTEGER,
Award VARCHAR2(28),
CONSTRAINT AwardsPrimeKey PRIMARY KEY(ArtistID,Award),
CONSTRAINT AwardsForeignKey FOREIGN KEY(ArtistID)
                REFERENCES Artists(ArtistID)
                ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
--
SET FEEDBACK OFF;
INSERT INTO Awards values(984, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(981, 'Henson Award for Music');
INSERT INTO Awards values(989, 'Case Sensitive Music Award');
INSERT INTO Awards values(979, 'Richardson Death Metal Award');
INSERT INTO Awards values(991, 'Case Sensitive Music Award');
INSERT INTO Awards values(996, 'Henson Award for Music');
INSERT INTO Awards values(983, 'Kaufman Award for Loud Music');
INSERT INTO Awards values(979, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(996, 'Mcfarland Music Award');
INSERT INTO Awards values(986, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(988, 'Richardson Death Metal Award');
INSERT INTO Awards values(978, 'Mcfarland Music Award');
INSERT INTO Awards values(998, 'Stanton Anti-Grammy Award');
INSERT INTO Awards values(990, 'Henson Award for Music');
INSERT INTO Awards values(978, 'Stanton Anti-Grammy Award');
INSERT INTO Awards values(997, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(987, 'Mcfarland Music Award');
INSERT INTO Awards values(994, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(993, 'Case Sensitive Music Award');
INSERT INTO Awards values(994, 'Mendoza Latin Music Award');
INSERT INTO Awards values(982, 'Stanton Anti-Grammy Award');
INSERT INTO Awards values(978, 'Mendoza Latin Music Award');
INSERT INTO Awards values(997, 'Case Sensitive Music Award');
INSERT INTO Awards values(980, 'Kaufman Award for Loud Music');
INSERT INTO Awards values(996, 'Richardson Death Metal Award');
INSERT INTO Awards values(991, 'Kaufman Award for Loud Music');
INSERT INTO Awards values(990, 'Mendoza Latin Music Award');
INSERT INTO Awards values(980, 'Case Sensitive Music Award');
INSERT INTO Awards values(993, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(983, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(994, 'Stanton Anti-Grammy Award');
INSERT INTO Awards values(996, 'Mendoza Latin Music Award');
INSERT INTO Awards values(988, 'Mendoza Latin Music Award');
INSERT INTO Awards values(982, 'Bright Light Harmony Trophy');
INSERT INTO Awards values(980, 'Richardson Death Metal Award');
INSERT INTO Awards values(987, 'Mendoza Latin Music Award');
INSERT INTO Awards values(988, 'Case Sensitive Music Award');
INSERT INTO Awards values(989, 'Mcfarland Music Award');
--
INSERT INTO Customer values(110757, 'Bell', 'Tyler', 'TBell710@somewhere.com', 'dze9Nm8F2Sp');
INSERT INTO Customer values(109931, 'Nguyen', 'Virginia', '', '');
INSERT INTO Customer values(107901, 'Jenkins', 'Victoria', '', '');
INSERT INTO Customer values(122103, 'Ortiz', 'Amanda', 'AOrtiz846@somewhere.com', 'FdkYR5xMId8Y');
INSERT INTO Customer values(129157, 'Ross', 'Kimberly', 'KRoss581@somewhere.com', 'boTgGNwWCStDM');
INSERT INTO Customer values(123925, 'Lee', 'Adam', 'ALee53@somewhere.com', '9LCC8Pe4A');
INSERT INTO Customer values(105268, 'Adams', 'Frank', 'FAdams69@somewhere.com', 'fEvYaFq');
INSERT INTO Customer values(121958, 'Green', 'Karen', 'KGreen949@somewhere.com', 'AfPcexPA');
INSERT INTO Customer values(109019, 'Morales', 'Donna', 'DMorales913@somewhere.com', 'caNxC6Eq8MoovDHqGAd9');
INSERT INTO Customer values(129206, 'Cruz', 'Eugene', 'ECruz940@somewhere.com', 'Fvdz78EQAK2GM7i73Y3');
INSERT INTO Customer values(128714, 'Long', 'Nicole', 'NLong481@somewhere.com', 'eIOztmznsu06');
INSERT INTO Customer values(132000, 'Diaz', 'Jack', '', '');
INSERT INTO Customer values(116558, 'Bennett', 'Roy', 'RBennett460@somewhere.com', 'CSnSdiBSYf');
INSERT INTO Customer values(103459, 'Green', 'Virginia', 'VGreen527@somewhere.com', '6ponGDpT6blh5qw');
INSERT INTO Customer values(117932, 'Bell', 'Jonathan', 'JBell904@somewhere.com', 'NNQKQ7j3u9coLF8h6');
INSERT INTO Customer values(131399, 'Diaz', 'Wayne', 'WDiaz318@somewhere.com', '9wJ6A4NxEB4DT7Y');
INSERT INTO Customer values(119293, 'Watson', 'Robert', '', '');
INSERT INTO Customer values(125668, 'Allen', 'Tyler', 'TAllen530@somewhere.com', 'rTxPzX8fLpI');
INSERT INTO Customer values(112728, 'Perez', 'Howard', 'HPerez148@somewhere.com', 'v1PKKQ5UsYXWYqVTQ');
INSERT INTO Customer values(130287, 'Rodriguez', 'Bruce', 'BRodriguez627@somewhere.com', 'nBJEeujl6mQIr3GT9C');
INSERT INTO Customer values(105905, 'Gomez', 'Jennifer', 'JGomez646@somewhere.com', 'haOAq79bfYl9oLotNu');
INSERT INTO Customer values(112929, 'Hill', 'Mark', '', '');
INSERT INTO Customer values(109675, 'Campbell', 'Nathan', 'NCampbell858@somewhere.com', 'hQLyU5o8j');
INSERT INTO Customer values(128088, 'James', 'Douglas', 'DJames687@somewhere.com', 'MyA0SdGlNI');
INSERT INTO Customer values(114868, 'Wood', 'Judith', 'JWood793@somewhere.com', 'gq1ffGjuD');
INSERT INTO Customer values(127818, 'Williams', 'Karen', 'KWilliams976@somewhere.com', '1QIg2U1fyJATV4e46wvw');
INSERT INTO Customer values(119270, 'Robinson', 'Jacob', '', '');
INSERT INTO Customer values(115719, 'Edwards', 'Janice', '', '');
INSERT INTO Customer values(119658, 'Cruz', 'Sarah', '', '');
INSERT INTO Customer values(129309, 'Parker', 'Ashley', 'AParker107@somewhere.com', 'WsDGrJK');
INSERT INTO Customer values(124207, 'Smith', 'Kyle', 'KSmith296@somewhere.com', 'jkAYKft6id');
INSERT INTO Customer values(117018, 'Jackson', 'Marie', 'MJackson65@somewhere.com', 'CXBHicKipwsI');
INSERT INTO Customer values(111946, 'Barnes', 'Terry', 'TBarnes22@somewhere.com', '3xCXzjb72fYwXnwOWMku');
INSERT INTO Customer values(106555, 'Cox', 'Jack', 'JCox811@somewhere.com', 'w3gL8Rb');
INSERT INTO Customer values(119068, 'Murphy', 'Laura', '', '');
INSERT INTO Customer values(112385, 'Collins', 'Laura', '', '');
INSERT INTO Customer values(113664, 'Lewis', 'Mildred', 'MLewis522@somewhere.com', 'QpKjDLYkGOfdez');
INSERT INTO Customer values(120321, 'James', 'Kenneth', 'KJames643@somewhere.com', 'vBB9VQE66UsPEH');
INSERT INTO Customer values(116325, 'Rivera', 'Diana', '', '');
INSERT INTO Customer values(110386, 'Cook', 'Vincent', '', '');
--
--
INSERT INTO ShippingDetails values(110773, 110757, '2234 Cedar Street', 'Cape Coral', 'FL', '33904');
INSERT INTO ShippingDetails values(111849, 122103, '210 Jackson Street', 'North Olmsted', 'OH', '44070');
INSERT INTO ShippingDetails values(120388, 129157, '3835 Cherry Lane', 'Indian Trail', 'NC', '28079');
INSERT INTO ShippingDetails values(101525, 123925, '6273 Fairway Drive', 'Hopewell Junction', 'NY', '12533');
INSERT INTO ShippingDetails values(116556, 123925, '1489 River Street', 'Deerfield Beach', 'FL', '33442');
INSERT INTO ShippingDetails values(102161, 105268, '8439 Pheasant Run', 'Evansville', 'IN', '47711');
INSERT INTO ShippingDetails values(127919, 109019, '1519 Devonshire Drive', 'North Olmsted', 'OH', '44070');
INSERT INTO ShippingDetails values(106667, 128714, '1405 Route 100', 'Palm Bay', 'FL', '32907');
INSERT INTO ShippingDetails values(121699, 116558, '9909 Shady Lane', 'Manahawkin', 'NJ', '08050');
INSERT INTO ShippingDetails values(113520, 103459, '3485 Linden Avenue', 'Raleigh', 'NC', '27603');
INSERT INTO ShippingDetails values(105627, 117932, '6032 Hillside Drive', 'Ringgold', 'GA', '30736');
INSERT INTO ShippingDetails values(104678, 131399, '2802 Orchard Avenue', 'Poughkeepsie', 'NY', '12601');
INSERT INTO ShippingDetails values(125455, 125668, '201 Madison Avenue', 'Addison', 'IL', '60101');
INSERT INTO ShippingDetails values(128572, 112728, '6045 Orchard Street', 'Seymour', 'IN', '47274');
INSERT INTO ShippingDetails values(124313, 130287, '434 Elm Avenue', 'Holbrook', 'NY', '11741');
INSERT INTO ShippingDetails values(113928, 105905, '8226 Canterbury Drive', 'Cumming', 'GA', '30040');
INSERT INTO ShippingDetails values(106047, 109675, '6695 6th Avenue', 'Clayton', 'NC', '27520');
INSERT INTO ShippingDetails values(100320, 128088, '6730 Andover Court', 'Nashua', 'NH', '03060');
INSERT INTO ShippingDetails values(118896, 114868, '234 Adams Avenue', 'Cumming', 'GA', '30040');
INSERT INTO ShippingDetails values(109882, 127818, '9961 Main Street North', 'Waterford', 'MI', '48329');
INSERT INTO ShippingDetails values(127615, 129309, '3750 Park Drive', 'Smithtown', 'NY', '11787');
INSERT INTO ShippingDetails values(126085, 124207, '4745 Virginia Street', 'Evansville', 'IN', '47711');
INSERT INTO ShippingDetails values(117087, 117018, '1983 Harrison Avenue', 'Northbrook', 'IL', '60062');
INSERT INTO ShippingDetails values(104840, 111946, '6639 Cherry Street', 'Flint', 'MI', '48504');
INSERT INTO ShippingDetails values(131488, 106555, '583 Magnolia Drive', 'Hicksville', 'NY', '11801');
INSERT INTO ShippingDetails values(123385, 113664, '5744 Poplar Street', 'Youngstown', 'OH', '44512');
INSERT INTO ShippingDetails values(100522, 120321, '7942 Bayberry Drive', 'Jenison', 'MI', '49428');
--
--
INSERT INTO CustomerOrders values(129843, '6-Nov-2001', 129157, NULL, 'Delivered');
INSERT INTO CustomerOrders values(107064, '10-Jul-2014', 122103, 9, 'Being Processed');
INSERT INTO CustomerOrders values(103543, '19-Jun-2002', 128088, 15, 'Delivered');
INSERT INTO CustomerOrders values(122374, '25-Oct-2013', 112728, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(115439, '7-May-2002', 124207, NULL, 'Delivered');
INSERT INTO CustomerOrders values(127342, '21-Jul-2010', 124207, 8, 'Being Processed');
INSERT INTO CustomerOrders values(119896, '26-Oct-2011', 124207, 3, 'Pending Approval');
INSERT INTO CustomerOrders values(123752, '21-Oct-2007', 109019, NULL, 'Delivered');
INSERT INTO CustomerOrders values(100208, '27-Jan-2013', 131399, 11, 'Delivered');
INSERT INTO CustomerOrders values(122279, '12-Jan-2011', 120321, NULL, 'Shipped');
INSERT INTO CustomerOrders values(119593, '23-Jul-2004', 128088, NULL, 'Delivered');
INSERT INTO CustomerOrders values(101500, '27-Mar-2012', 105905, NULL, 'Delivered');
INSERT INTO CustomerOrders values(104311, '17-Jan-2013', 129309, 16, 'Shipped');
INSERT INTO CustomerOrders values(103207, '6-May-2014', 114868, 16, 'Pending Approval');
INSERT INTO CustomerOrders values(125106, '21-Feb-2004', 124207, 7, 'Being Processed');
INSERT INTO CustomerOrders values(117917, '4-Aug-2003', 111946, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(127493, '11-Jun-2003', 103459, 13, 'Pending Approval');
INSERT INTO CustomerOrders values(111836, '12-Jan-2010', 127818, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(113762, '12-Oct-2010', 111946, NULL, 'Delivered');
INSERT INTO CustomerOrders values(113004, '11-Oct-2007', 130287, NULL, 'Shipped');
INSERT INTO CustomerOrders values(118517, '17-Feb-2008', 117932, 3, 'Being Processed');
INSERT INTO CustomerOrders values(122789, '3-Nov-2009', 130287, 13, 'Being Processed');
INSERT INTO CustomerOrders values(125705, '6-Sep-2008', 105268, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(114110, '2-Dec-2011', 106555, NULL, 'Shipped');
INSERT INTO CustomerOrders values(125147, '4-Nov-2013', 109675, NULL, 'Delivered');
INSERT INTO CustomerOrders values(114660, '21-Mar-2005', 123925, 15, 'Shipped');
INSERT INTO CustomerOrders values(115668, '10-Jul-2009', 117932, 9, 'Pending Approval');
INSERT INTO CustomerOrders values(109763, '10-Apr-2001', 125668, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(132124, '17-May-2010', 112728, NULL, 'Pending Approval');
INSERT INTO CustomerOrders values(124230, '27-Mar-2013', 128714, NULL, 'Pending Approval');
INSERT INTO CustomerOrders values(112777, '24-May-2008', 120321, 12, 'Delivered');
INSERT INTO CustomerOrders values(131449, '18-Jun-2006', 114868, NULL, 'Pending Approval');
INSERT INTO CustomerOrders values(126799, '10-May-2000', 124207, NULL, 'Delivered');
INSERT INTO CustomerOrders values(114898, '3-Aug-2007', 116558, 2, 'Pending Approval');
INSERT INTO CustomerOrders values(122116, '25-Oct-2011', 131399, 3, 'Pending Approval');
INSERT INTO CustomerOrders values(120401, '27-Jul-2012', 106555, NULL, 'Pending Approval');
INSERT INTO CustomerOrders values(129236, '16-Jun-2011', 128714, NULL, 'Delivered');
INSERT INTO CustomerOrders values(129328, '3-Apr-2000', 116558, NULL, 'Pending Approval');
INSERT INTO CustomerOrders values(102898, '25-Aug-2004', 109019, NULL, 'Being Processed');
INSERT INTO CustomerOrders values(123167, '23-Aug-2002', 122103, 7, 'Pending Approval');
--
INSERT INTO Purchasing values(9,129843,14);
INSERT INTO Purchasing values(1,107064,18);
INSERT INTO Purchasing values(1,103543,1);
INSERT INTO Purchasing values(8,122374,12);
INSERT INTO Purchasing values(7,115439,12);
INSERT INTO Purchasing values(4,127342,13);
INSERT INTO Purchasing values(9,119896,7);
INSERT INTO Purchasing values(9,123752,3);
INSERT INTO Purchasing values(5,100208,18);
INSERT INTO Purchasing values(3,122279,20);
INSERT INTO Purchasing values(9,119593,1);
INSERT INTO Purchasing values(10,101500,5);
INSERT INTO Purchasing values(7,104311,1);
INSERT INTO Purchasing values(8,103207,5);
INSERT INTO Purchasing values(5,125106,3);
INSERT INTO Purchasing values(7,117917,15);
INSERT INTO Purchasing values(3,127493,7);
INSERT INTO Purchasing values(10,111836,11);
INSERT INTO Purchasing values(3,113762,4);
INSERT INTO Purchasing values(7,113004,20);
INSERT INTO Purchasing values(10,118517,3);
INSERT INTO Purchasing values(8,122789,6);
INSERT INTO Purchasing values(3,125705,5);
INSERT INTO Purchasing values(8,114110,18);
INSERT INTO Purchasing values(3,125147,9);
INSERT INTO Purchasing values(1,114660,11);
INSERT INTO Purchasing values(9,115668,13);
INSERT INTO Purchasing values(4,109763,14);
INSERT INTO Purchasing values(4,132124,19);
INSERT INTO Purchasing values(2,124230,9);
INSERT INTO Purchasing values(10,112777,3);
INSERT INTO Purchasing values(3,131449,19);
INSERT INTO Purchasing values(9,126799,18);
INSERT INTO Purchasing values(7,114898,11);
INSERT INTO Purchasing values(8,122116,2);
INSERT INTO Purchasing values(4,120401,19);
INSERT INTO Purchasing values(4,129236,1);
INSERT INTO Purchasing values(10,129328,4);
INSERT INTO Purchasing values(7,102898,20);
INSERT INTO Purchasing values(9,123167,11);
INSERT INTO Purchasing values(7,109763,14);
INSERT INTO Purchasing values(2,132124,19);
INSERT INTO Purchasing values(7,124230,9);
INSERT INTO Purchasing values(1,112777,3);
INSERT INTO Purchasing values(5,131449,19);
INSERT INTO Purchasing values(7,126799,18);
INSERT INTO Purchasing values(4,114898,11);
INSERT INTO Purchasing values(3,122116,2);
INSERT INTO Purchasing values(2,120401,19);
INSERT INTO Purchasing values(1,129236,1);
INSERT INTO Purchasing values(1,129328,4);
INSERT INTO Purchasing values(6,102898,20);
INSERT INTO Purchasing values(7,123167,11);
--
INSERT INTO Albums VALUES(1 ,'Quantum Jump','Apple Records', 397, 1976 , 2.11);
--
INSERT INTO Artists VALUES (999,'John G. Perry','USA');
INSERT INTO Artists VALUES (998,'Quantum Jump','USA');
INSERT INTO Artists VALUES (997,'Trevor Smith','USA');
INSERT INTO Artists VALUES (996,'Trevor Morais','USA');
INSERT INTO Artists VALUES (995,'Rupert Hine','USA');
--
INSERT INTO Appears_In VALUES(1,999,'Recording Artist, Vocals, Bass Guitar');
INSERT INTO Appears_In VALUES(1,998,'Composer');
INSERT INTO Appears_In VALUES(1,997,'Artwork');
INSERT INTO Appears_In VALUES(1,996,'Drums/Percussion');
INSERT INTO Appears_In VALUES(1,995,'Producer');
--
INSERT INTO Genres VALUES(1,'Electronic');
INSERT INTO Genres VALUES(1,'Jazz');
INSERT INTO Genres VALUES(1,'Rock');
INSERT INTO Genres VALUES(1,'Funk / Soul');
--
INSERT INTO Tracks VALUES(1,1,525,'Captain Boogaloo');
INSERT INTO Tracks VALUES(2,1,586,'Over Rio');
INSERT INTO Tracks VALUES(3,1,122,'The Lone Ranger');
INSERT INTO Tracks VALUES(4,1,563,'No American Starship (Looking For The Next World)');
INSERT INTO Tracks VALUES(5,1,505,'Alta Loma Road');
INSERT INTO Tracks VALUES(6,1,581,'Cocabana Havana');
INSERT INTO Tracks VALUES(7,1,111,'Constant Forest');
INSERT INTO Tracks VALUES(8,1,69,'Something At The Bottom Of The Sea');
INSERT INTO Tracks VALUES(9,1,551,'Stepping Stones');
INSERT INTO Tracks VALUES(10,1,288,'The Roving Finger');
INSERT INTO Tracks VALUES(11,1,151,'Stepping Rocks');
--
INSERT INTO Albums VALUES(2,'Enigmatic Ocean','Atlantic',271,1977,6.84);
--
INSERT INTO Artists VALUES(994,'Jean-Luc Ponty','USA');
INSERT INTO Artists VALUES(993,'Allan Zavod','USA');
INSERT INTO Artists VALUES(992,'Steve Smith','USA');
INSERT INTO Artists VALUES(991,'Ralphe Armstrong','USA');
--
INSERT INTO Appears_In VALUES(2,994,'Conductor, Composer, Recording Artist, Bells');
INSERT INTO Appears_In VALUES(2,993,'Clavinet');
INSERT INTO Appears_In VALUES(2,992,'Drums');
INSERT INTO Appears_In VALUES(2,991,'Electric Bass');
--
INSERT INTO Genres VALUES(2,'Electronic');
INSERT INTO Genres VALUES(2,'Jazz');
INSERT INTO Genres VALUES(2,'Rock');
--
INSERT INTO Tracks VALUES(1,2,292,'Overture');
INSERT INTO Tracks VALUES(2,2,240,'The Trans-Love Express');
INSERT INTO Tracks VALUES(3,2,64,'Mirage');
INSERT INTO Tracks VALUES(4,2,455,'Enigmatic Ocean (Part I)');
INSERT INTO Tracks VALUES(5,2,518,'Enigmatic Ocean (Part II)');
INSERT INTO Tracks VALUES(6,2,47,'Enigmatic Ocean (Part III)');
INSERT INTO Tracks VALUES(7,2,109,'Enigmatic Ocean (Part IV)');
INSERT INTO Tracks VALUES(8,2,614,'Nostalgic Lady');
INSERT INTO Tracks VALUES(9,2,595,'The Struggle Of The Turtle To The Sea (Part I)');
INSERT INTO Tracks VALUES(10,2,320,'The Struggle Of The Turtle To The Sea (Part II)');
INSERT INTO Tracks VALUES(11,2,282,'The Struggle Of The Turtle To The Sea (Part III)');
--
INSERT INTO Artists VALUES(990,'Indochine','USA');
--
INSERT INTO Albums VALUES(3,'Paradize','Indochine Records',100,2016,6.93);
--
INSERT INTO Appears_In VALUES(3,990,'Recording Artist');
--
INSERT INTO Genres VALUES(3,'Rock');
INSERT INTO Genres VALUES(3,'Pop');
--
INSERT INTO Tracks VALUES(1,3,534,'Paradize');
INSERT INTO Tracks VALUES(2,3,439,'Electrastar');
INSERT INTO Tracks VALUES(3,3,534,'Punker');
INSERT INTO Tracks VALUES(4,3,277,'Mao boy');
INSERT INTO Tracks VALUES(5,3,411,'J`ai demandÃ© Ã  la lune ');
INSERT INTO Tracks VALUES(6,3,95,'Dunkerque');
INSERT INTO Tracks VALUES(7,3,126,'Like a monster');
INSERT INTO Tracks VALUES(8,3,415,'Le grand secret');
INSERT INTO Tracks VALUES(9,3,240,'La nuit des fÃ©es');
INSERT INTO Tracks VALUES(10,3,393,'Marilyn');
INSERT INTO Tracks VALUES(11,3,369,'La manoir');
INSERT INTO Tracks VALUES(12,3,581,'Popstitute');
INSERT INTO Tracks VALUES(13,3,142,'Dark');
INSERT INTO Tracks VALUES(14,3,583,'Comateen 1 ');
INSERT INTO Tracks VALUES(15,3,202,'Un singe en hiver');
--
INSERT INTO Artists VALUES(989,'B.B. King','USA');
--
INSERT INTO Albums VALUES(4,'B.B. King Brought to You By Rockport','Universal Music Enterprises',1,1998,2.09);
--
INSERT INTO Appears_In VALUES(4,989,'Recording Artist');
------------------------------------------------------------------------------
INSERT INTO Genres VALUES(4,'Blues');
------------------------------------------------------------------------------
INSERT INTO Tracks VALUES(1,4,587,'(I Love You) For Sentimental Reasons');
INSERT INTO Tracks VALUES(2,4,547,'The Thrill Is Gone');
INSERT INTO Tracks VALUES(3,4,551,'I`ll Survive');
--
------------------------------------------------------------------------------
INSERT INTO Artists VALUES(988,'Elton John','USA');
INSERT INTO Artists VALUES(987,'Dylan Hart','USA');
INSERT INTO Artists VALUES(986,'Nigel Olsson','USA');
INSERT INTO Artists VALUES(985,'Kim Bullard','USA');
------------------------------------------------------------------------------
INSERT INTO Albums VALUES(5,'Wonderful Crazy Night','Island Records',11,2016,10.35);
------------------------------------------------------------------------------
INSERT INTO Appears_In VALUES(5,986,'Harmony Vocals, Drums');
INSERT INTO Appears_In VALUES(5,987,'French Horn');
INSERT INTO Appears_In VALUES(5,985,'Keyboards');
INSERT INTO Appears_In VALUES(5,988,'Recording Artist, Lead Vocals');
------------------------------------------------------------------------------
INSERT INTO Genres VALUES(5,'Rock');
INSERT INTO Genres VALUES(5,'Pop');
------------------------------------------------------------------------------
INSERT INTO Tracks VALUES(1,5,52,'Wonderful Crazy Night');
INSERT INTO Tracks VALUES(2,5,216,'In The Name Of You');
INSERT INTO Tracks VALUES(3,5,148,'Claw Hammer');
INSERT INTO Tracks VALUES(4,5,151,'Blue Wonderful');
INSERT INTO Tracks VALUES(5,5,213,'I`ve Got 2 Wings');
INSERT INTO Tracks VALUES(6,5,323,'A Good Heart');
INSERT INTO Tracks VALUES(7,5,195,'Looking Up');
INSERT INTO Tracks VALUES(8,5,400,'Guilty Pleasure');
INSERT INTO Tracks VALUES(9,5,546,'Tambourine');
INSERT INTO Tracks VALUES(10,5,309,'The Open Chord');
INSERT INTO Tracks VALUES(11,5,225,'Free And Easy');
INSERT INTO Tracks VALUES(12,5,321,'England And America');
INSERT INTO Tracks VALUES(13,5,149,'Looking Up (Live)');
INSERT INTO Tracks VALUES(14,5,362,'Wonderful Crazy Night (Live)');
--
INSERT INTO Artists VALUES(984,'Seges Findere','USA');
-------------------------------------------------------------------------------
INSERT INTO Albums VALUES(6,'Mortal Grinder','Behold Barbarity',911,2016,8.65);
-------------------------------------------------------------------------------
INSERT INTO Appears_In VALUES(6,984,'Lead Vocals, Recording Artist');
-------------------------------------------------------------------------------
INSERT INTO Genres VALUES(6,'Rock');
-----------------------------------------------------------------------------
INSERT INTO Tracks VALUES(1,6,251,'Mortal Grinder');
INSERT INTO Tracks VALUES(2,6,86,'Volunteers Of Victory');
INSERT INTO Tracks VALUES(3,6,460,'The Multicunts Misery');
INSERT INTO Tracks VALUES(4,6,199,'Terrornoise');
INSERT INTO Tracks VALUES(5,6,523,'Total Warsphere');
INSERT INTO Tracks VALUES(6,6,462,'Disciples Of The Black Sun');
INSERT INTO Tracks VALUES(7,6,442,'Hatestrike');
INSERT INTO Tracks VALUES(8,6,234,'Intolerance Is Right');
INSERT INTO Tracks VALUES(9,6,217,'Crush, Kill and Destroy The Antifa Trannies');
INSERT INTO Tracks VALUES(10,6,54,'Scoriam Mortis');
INSERT INTO Tracks VALUES(11,6,560,'Hollyjude Shit');
INSERT INTO Tracks VALUES(12,6,434,'Indominus');
INSERT INTO Tracks VALUES(13,6,374,'Unrivalled');
INSERT INTO Tracks VALUES(14,6,260,'Guts For The Wardemons');
INSERT INTO Tracks VALUES(15,6,68,'Fire On Diaspora Pest');
INSERT INTO Tracks VALUES(16,6,225,'Strategema Letalis');
INSERT INTO Tracks VALUES(17,6,497,'Aggressive Reaction');
INSERT INTO Tracks VALUES(18,6,128,'No Abolition');
INSERT INTO Tracks VALUES(19,6,499,'Repulsive Trash');
INSERT INTO Tracks VALUES(20,6,197,'Coprophagic Wiesentales');
INSERT INTO Tracks VALUES(21,6,434,'Protocol of Extinction');
INSERT INTO Tracks VALUES(22,6,610,'VÃ´mito AtÃ´mico');
--
INSERT INTO Artists VALUES(983,'Fleetwood Mac','USA');
--
INSERT INTO Albums VALUES(7,'Live At The Boston Tea Party Part Two','Snapper Music Inc.',97,1998,3.62);
--
INSERT INTO Appears_In VALUES(7,983,'Lead Vocals, Recording Artist');
--
INSERT INTO Genres VALUES(7,'Rock');
--
INSERT INTO Tracks VALUES(1,7,142,'World In Harmony');
INSERT INTO Tracks VALUES(2,7,423,'Oh Well');
INSERT INTO Tracks VALUES(3,7,338,'Rattlesnake Shake');
INSERT INTO Tracks VALUES(4,7,73,'Stranger Blues');
INSERT INTO Tracks VALUES(5,7,554,'Red Hot Mama');
INSERT INTO Tracks VALUES(6,7,317,'Teenage Darling');
INSERT INTO Tracks VALUES(7,7,382,'Keep A-Knocking');
INSERT INTO Tracks VALUES(8,7,237,'Jenny Jenny');
INSERT INTO Tracks VALUES(9,7,268,'Encore');
--
INSERT INTO Artists VALUES(982,'Buckner','USA');
INSERT INTO Artists VALUES(981,'Sabine Kaufmann','USA');
--
INSERT INTO Albums VALUES(8,'Sinfonieorchester Des Norddeutschen Rundfunks','RCA Victor Red Seal',463,1989,3.81);
--
INSERT INTO Appears_In VALUES(8,982,'Composer, Recording Artist');
INSERT INTO Appears_In VALUES(8,981,'Editor');
--
INSERT INTO Genres VALUES(8,'Classical');
--
INSERT INTO Tracks VALUES(1,8,290,'Sinfonie Nr. 6 A-Dur');
INSERT INTO Tracks VALUES(2,8,260,'Majestoso');
INSERT INTO Tracks VALUES(3,8,286,'Adagio. Sehr Feierlich');
INSERT INTO Tracks VALUES(4,8,321,'Scherzo. Nicht Schnell. Trio');
INSERT INTO Tracks VALUES(5,8,73,'Finale. Bewegt, Doch Nicht Zu Schnell');
--
INSERT INTO Artists VALUES (980,'The Beatles','UK');
--
INSERT INTO Albums VALUES(9,'Abbey Road','Apple Records',657,1969,9.98);
--
INSERT INTO Appears_In VALUES(9,980,'Recording Artist');
--
INSERT INTO Genres VALUES(9,'Rock');
INSERT INTO Genres VALUES(9,'Pop');
--
INSERT INTO Tracks VALUES (1,9,260,'Come Together');
INSERT INTO Tracks VALUES (2,9,183,'Something');
INSERT INTO Tracks VALUES (3,9,207,'Maxwell`s Silver Hammer');
INSERT INTO Tracks VALUES (4,9,206,'Oh! Darling');
INSERT INTO Tracks VALUES (5,9,171,'Octopus`s Garden');
INSERT INTO Tracks VALUES (6,9,467,'I Want You (She`s So Heavy)');
INSERT INTO Tracks VALUES (7,9,185,'Here Comes The Sun');
INSERT INTO Tracks VALUES (8,9,165,'Because');
INSERT INTO Tracks VALUES (9,9,242,'You Never Give Me Your Money');
INSERT INTO Tracks VALUES (10,9,146,'Sun King');
INSERT INTO Tracks VALUES (11,9,66,'Mean Mr. Mustard');
-------------------------------------------------------------------------------
INSERT INTO Artists VALUES(979,'Kwanza Unit','USA');
INSERT INTO Artists VALUES(978,'Master Jay','USA');
INSERT INTO Artists VALUES(977,'Rhymson','USA');
-------------------------------------------------------------------------------
INSERT INTO Albums VALUES(10,'Kwanza Unit','Madunia Foundation',121,2000,3.24);
-------------------------------------------------------------------------------
INSERT INTO Appears_In VALUES(10,979,'Lead Vocals, Recording Artist');
INSERT INTO Appears_In VALUES(10,978,'Co-Producer');
INSERT INTO Appears_In VALUES(10,977,'Producer');
-----------------------------------------------------------------------------
INSERT INTO Genres VALUES(10,'Hip Hop');
------------------------------------------------------------------------------
INSERT INTO Tracks VALUES(1,10,305,'Intro');
INSERT INTO Tracks VALUES(2,10,540,'Kwanzanianz');
INSERT INTO Tracks VALUES(3,10,57,'Inahouse');
INSERT INTO Tracks VALUES(4,10,247,'Interlude');
INSERT INTO Tracks VALUES(5,10,446,'Beyond Belief');
INSERT INTO Tracks VALUES(6,10,362,'Interlude');
INSERT INTO Tracks VALUES(7,10,378,'Msafiri');
INSERT INTO Tracks VALUES(8,10,611,'Friction');
INSERT INTO Tracks VALUES(9,10,419,'Interlude');
INSERT INTO Tracks VALUES(10,10,160,'Man To Man');
INSERT INTO Tracks VALUES(11,10,419,'Check Navyoflow');
INSERT INTO Tracks VALUES(12,10,436,'Interlude');
INSERT INTO Tracks VALUES(13,10,81,'Beyond Belief (Remix)');
INSERT INTO Tracks VALUES(14,10,208,'Acha');
INSERT INTO Tracks VALUES(15,10,352,'Interlude');
INSERT INTO Tracks VALUES(16,10,442,'Kamari');
INSERT INTO Tracks VALUES(17,10,418,'Yippy Yapping');
INSERT INTO Tracks VALUES(18,10,602,'Kivingine');
INSERT INTO Tracks VALUES(19,10,359,'Interlude');
INSERT INTO Tracks VALUES(20,10,525,'Nakuja');
INSERT INTO Tracks VALUES(21,10,451,'Runtingz');
INSERT INTO Tracks VALUES(22,10,618,'So Why');
INSERT INTO Tracks VALUES(23,10,103,'Outtro');
INSERT INTO Tracks VALUES(24,10,192,'Beyond Belief (Posse Remix)');
SET FEEDBACK ON;
COMMIT;
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
--Q1-A join involving at least four relations.
--Select the first AND last names of all customers who bought an album by
--The Beatles
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
--Q2-A self-join.
--Find pairs names of all customers who have the same first name
-------------------------------------------------------------------------------
SELECT C1.FirstName, C1.LastName, C2.FirstName, C2.LastName
FROM Customer C1, Customer C2
WHERE C1.FirstName = C2.FirstName AND
      C1.CustomerID <> C2.CustomerID AND
      C1.LastName < C2.LastName
ORDER BY C1.LastName;
-------------------------------------------------------------------------------
--Q3-UNION
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
-- Q4-INTERSECT
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
--Q5-MINUS
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
--Q6-SUM
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
--Q7-AVG
--Find all artist's whose average length of song is at least 3 minutes AND 30
--seconds across an album(individual albums)
-------------------------------------------------------------------------------
SELECT DISTINCT B.ArtistName, AVG(T.Duration_Seconds) AS "Avg Duration"
FROM Albums A, Tracks T, Artists B, Appears_in C
WHERE T.AlbumID = A.AlbumID AND
      A.AlbumID=C.AlbumID AND
      C.ArtistID=B.ArtistID
GROUP BY B.ArtistName
HAVING AVG(T.Duration_Seconds) > 210
ORDER BY B.ArtistName;
-------------------------------------------------------------------------------
--Q8-MAX
--Find all albums whose longest song is under 10 minutes long
-------------------------------------------------------------------------------
SELECT DISTINCT A.AlbumTitle
FROM Albums A, Tracks T
WHERE T.AlbumID = A.AlbumID
GROUP BY A.AlbumTitle
HAVING MAX(T.Duration_Seconds) < 600
ORDER BY A.AlbumTitle;
-------------------------------------------------------------------------------
--Q9-MIN.
--Find all albums whose shortest song that is less than 3 minutes long
-------------------------------------------------------------------------------
SELECT DISTINCT A.AlbumTitle
FROM Albums A, Tracks T
WHERE T.AlbumID = A.AlbumID
GROUP BY A.AlbumTitle
HAVING MIN(T.Duration_Seconds) < 60
ORDER BY A.AlbumTitle;
-------------------------------------------------------------------------------
--GROUP BY, HAVING, AND ORDER BY, all appearing in the same query
-------------------------------------------------------------------------------
--(see previous query - Q9)
-------------------------------------------------------------------------------
--Q10-A correlated subquery.
--Find all customers with an email address who haven't ordered online.
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C
WHERE C.email IS NOT NULL AND
      NOT EXISTS (SELECT *
                  FROM CustomerOrders D
				          WHERE C.CustomerID=D.CustomerID);
-------------------------------------------------------------------------------
--Q11-A non-correlated subquery.
--Find all customers whose orders of "Quantum Jump" have been delivered
-------------------------------------------------------------------------------
SELECT DISTINCT C.FirstName, C.LastName
FROM Customer C, CustomerOrders D, Purchasing P, Albums F
WHERE C.CustomerID=D.CustomerID AND
      P.OrderID=D.OrderID AND
      P.AlbumID=F.AlbumID AND
      F.AlbumTitle='Quantum Jump' AND
      D.CustomerID IN (SELECT CustomerID
                       FROM CustomerOrders
				               WHERE OrderStatus='Delivered');
-------------------------------------------------------------------------------
--Q12-A relational DIVISION query.
--Find all customers who ordered every album by 'Apple Records' (Record Label)
-------------------------------------------------------------------------------
SELECT C.FirstName, C.LastName
FROM Customer C
WHERE NOT EXISTS((SELECT  B.AlbumID
                   FROM Albums B
                   WHERE B.RecordLabel = 'Apple Records')
                  MINUS
                  (SELECT  D.AlbumID
                   FROM    CustomerOrders R, Purchasing B, Albums D
                   WHERE   R.OrderID=B.OrderID AND
			                     R.CustomerID = C.CustomerID AND
                           B.AlbumID = D.AlbumID AND
                           D.RecordLabel = 'Apple Records'));
-------------------------------------------------------------------------------
--Q13-An outer join query.
--Find First and Last name of every customer whose last name is less than 'j'.
--Also include their shipping address if they provided one.
-------------------------------------------------------------------------------
SELECT C.FirstName, C.LastName, S.Street, S.City, S.Zip
FROM Customer C LEFT OUTER JOIN ShippingDetails S ON S.CustomerID=C.CustomerID
WHERE C.LastName<'J';
-------------------------------------------------------------------------------
--
--Testing of integrity constraints
--
-------------------------------------------------------------------------------
--Testing: <CustomerPrimaryKey>
-------------------------------------------------------------------------------
INSERT INTO Customer values(109931, 'First', 'Last', '', '');
-------------------------------------------------------------------------------
--Testing: <TrackForeignKey>
-------------------------------------------------------------------------------
INSERT INTO Tracks VALUES(24,20,291,'Testing');
-------------------------------------------------------------------------------
--Testing: <TrackDurCheck>
-------------------------------------------------------------------------------
INSERT INTO Tracks VALUES(24,10,0,'Testing');
-------------------------------------------------------------------------------
--Testing: <Albums_price>
-------------------------------------------------------------------------------
INSERT INTO Albums VALUES(11,'Title','Label',101,1969,11.00);
-------------------------------------------------------------------------------
COMMIT;
SPOOL OFF;
