/**********************************************************************
* This script creates the database named disk_inventoryDV 
* Date		Programmer		Notes
* -------------------------------------------------------
* 10/11/2019 David Verbeck	Assignment 4 creating select queries
*
***********************************************************************/
USE master;
GO
-- Drop the database if it exists
IF  DB_ID('disk_inventoryDV ') IS NOT NULL
    DROP DATABASE disk_inventoryDV;
GO

-- creates the database
create database disk_inventoryDV;
go

use disk_inventoryDV;
go

--createing tables for database
create table Borrower_Info (
borrowerID int NOT NULL PRIMARY KEY,
borrower_name varchar(60) NOT NULL,
);

create table Artist_info (
artistID int NOT NULL PRIMARY KEY,
artist_name varchar(60) NOT NULL
);

create table Group_info (
groupID int NOT NULL PRIMARY KEY,
artistID int NOT NULL references artist_info(artistID),
group_name varchar(60) NOT NULL,
);

Create table CD_inventory (
CD_ID int NOT NULL PRIMARY KEY,
borrowerID int references Borrower_info(borrowerID),
artist_id int NOT NULL references Artist_info(artistID),
group_id int references Group_info(groupID),
CD_name varchar(60) NOT NULL,
status_type varchar(60) NOT NULL,
genre varchar(30) NOT NULL
);

Create table Borrowed_CD (
borrowerID int NOT NULL references Borrower_info(borrowerID),
CD_ID int NOT NULL references CD_inventory(CD_ID),
borrowed_date date,
returned_date date,
);


-- createing read-only user
create login diskUserDV with password = 'MSPress#1', default_database = disk_inventoryDV;

alter role db_datareader add member diskUserDV;


--Insering information into tables
--Borrower table
INSERT INTO [dbo].[Borrower_Info]
           ([borrowerID]
           ,[borrower_name])
     VALUES
           (1,'John Doe')
		   ,(2,'Jane Doe')
		   ,(3,'Mike Smith')
		   ,(4,'Sam James')
		   ,(5,'Penny Numan')
		   ,(6,'Hailey Comet')
		   ,(7,'Abby Gale')
		   ,(8,'Alex Anderson')
		   ,(9,'Seb Bastian')
		   ,(10,'Clint Westwood')
		   ,(11,'Dora Explorer')
		   ,(12,'Harry Potter')
		   ,(13,'Gus Odo')
		   ,(14,'Lin Dorf')
		   ,(15,'Jodi Barker')
		   ,(16,'Marnie Hays')
		   ,(17,'Demitrius Redman')
		   ,(18,'Harvey Mann')
		   ,(19,'Elliot Dawson')
		   ,(20,'Jas Pickett')
GO

--Inserting information to Artist table
INSERT INTO [dbo].[Artist_info]
           ([artistID]
           ,[artist_name])
     VALUES
           (1,'Kaia Lloyd')
		   ,(2,'Caelan Downes')
		   ,(3,'Kelsea Villa')
		   ,(4,'Aaliya Hardin')
		   ,(5,'Ruth Dodson')
		   ,(6,'Mahima Lester')
		   ,(7,'Rudi Edge')
		   ,(8,'Cora Mccray')
		   ,(9,'Norma Hamer')
		   ,(10,'Wendy Timms')
		   ,(11,'Sullivan Mcgill')
		   ,(12,'Alima Patel')
		   ,(13,'Aaminah Griffith')
		   ,(14,'Samanta Mcnally')
		   ,(15,'Talhah Norris')
		   ,(16,'Ayse Benjamin')
		   ,(17,'Makenzie Paul')
		   ,(18,'Ikra Bowler')
		   ,(19,'Cynthia Mcfarland')
		   ,(20,'Danial Le')
GO

--Inserting information into group_info table
INSERT INTO [dbo].[Group_info]
           ([groupID]
           ,[artistID]
           ,[group_name]
		   ,[artistName])
     VALUES
           (1 ,3 ,'Los cantantes', 'Kelsea Villa')
		   ,(2, 14, 'Bright Fairy')
		   ,(3, 8, 'Cosmic Banjo')
GO

-- Inseting information into CD_inventory table
INSERT INTO [dbo].[CD_inventory]
           ([CD_ID]
           ,[borrowerID]
           ,[artist_id]
           ,[group_id]
           ,[CD_name]
           ,[status_type]
           ,[genre])
     VALUES
           (1 ,1 ,1 ,null ,'Rainy Days' ,'Borrowed' ,'Alternative')
		   ,(2 ,null ,2 ,null ,'Dime in two dozen' ,'Available' ,'Rock')
		   ,(3 ,2 ,3 ,1 ,'Two to tango' ,'Borrowed' ,'Latin')
		   ,(4 ,3 ,4 ,null ,'Damage control' ,'Borrowed' ,'Eletronic/Dance')
		   ,(5 ,4 ,5 ,null ,'Time flies' ,'Borrowed' ,'Country')
		   ,(6 ,null ,6 ,null ,'Moonquake' ,'Available' ,'Rock')
		   ,(7 ,null ,7 ,null ,'Dreams and nightmares' ,'Available' ,'Rock')
		   ,(8 ,7 ,8 ,3 ,'Your graciousness' ,'Borrowed' ,'Country')
		   ,(9 ,9 ,9 ,null ,'Rainy Days' ,'Borrowed' ,'Alternative')
		   ,(10 ,null ,10 ,null ,'Methodical madness' ,'Available' ,'Electronic/Dance')
		   ,(11 ,null ,11 ,null ,'Crazy eyes' ,'Available' ,'Rock')
		   ,(12 ,null ,12 ,null ,'Blinded by fame' ,'Available' ,'Country')
		   ,(13 ,10 ,13 ,null ,'Honestly' ,'Borrowed' ,'Country')
		   ,(14 ,15 ,14 ,2 ,'Wild goose chase' ,'Borrowed' ,'Folk')
		   ,(15 ,14 ,15 ,null ,'Drawing board' ,'Borrowed' ,'Electronic/Dance')
		   ,(16 ,20 ,16 ,null ,'Experience required' ,'Borrowed' ,'Electronic/Dance')
		   ,(17 ,19 ,17 ,null ,'Eye of the camera' ,'Borrowed' ,'Electronic/Dance')
		   ,(18 ,11 ,18 ,null ,'The fat lady sings' ,'Borrowed' ,'Alternative')
		   ,(19 ,5 ,19 ,null ,'No justice' ,'Borrowed' ,'Rock')
		   ,(20 ,8 ,20 ,null ,'No discounts' ,'Borrowed' ,'Rock')

GO

--Inserting information into Borrowed_cd table
INSERT INTO [dbo].[Borrowed_CD]
           ([borrowerID]
           ,[CD_ID]
           ,[borrowed_date]
           ,[returned_date])
     VALUES
           (1, 1 ,10/16/2019, null)
		   ,(1, 1 ,05/21/2019, 07/28/2019)
		   ,(2, 3 ,11/14/2019, null)
		   ,(3, 4 ,8/16/2019, 11/16/2019)
		   ,(4, 5 ,9/13/2019, null)
		   ,(4, 8 ,9/14/2019, 05/21/2019)
		   ,(7, 8 ,10/17/2019, null)
		   ,(9, 9 ,10/30/2019, null)
		   ,(10, 13 ,3/03/2019, null)
		   ,(15, 14 ,6/06/2019, null)
		   ,(14, 15 ,8/27/2019, null)
		   ,(20, 16 ,3/10/2019, null)
		   ,(19, 17 ,1/19/2019, null)
		   ,(11, 18 ,7/02/2019, null)
		   ,(5, 19 ,7/09/2019, null)
		   ,(8, 20 ,7/04/2019, null)
GO

-- Updateing "Dreams and nightmares" to correct name in CD_inventory table
UPDATE [dbo].[CD_inventory]
   SET [CD_name] = 'Nightmare and Dreams'
 WHERE CD_ID = 7
GO

-- Deleteing "Mahima Lester" from Borrower table
DELETE FROM [dbo].[Borrower_Info]
      WHERE borrowerID = 6
GO

--query to select all CDs on loan
SELECT [borrowerID]
      ,[CD_ID]
      ,[borrowed_date]
      ,[returned_date]
  FROM [dbo].[Borrowed_CD]
  where returned_date is null
  order by borrowerID asc;


  ----
  INSERT INTO [dbo].[Borrowed_CD]
           ([borrowerID]
           ,[CD_ID]
           ,[borrowed_date]
           ,[returned_date])
     VALUES
           (1, 1 ,2019-10-11, null)
		   
GO

-- Select queries

-- select query for Artist Table
select CD_name as 'CD Name', release_date as 'Release Date', artist_name as 'Artist Name'
from Artist_info
inner join CD_inventory 
on Artist_info.artistID = CD_inventory.artist_id
order by [Artist Name], [CD Name] asc;
go

-- create view for Artist only
create view [View_Individual_Artist] as
select artist_name
from Artist_info
go
select * from View_Individual_Artist
order by artist_name asc;
go

--select group
select CD_name as 'CD Name', release_date as 'Release Date', group_name as 'Group Name'
from Group_info
inner join CD_inventory on Group_info.artistID = CD_inventory.artist_id
order by [Group Name], [CD Name] asc;
go

-- select disks that are borrowed
select borrower_name as 'Borrower Name', CD_name as 'CD Name', borrowed_date as 'Borrowed Date', returned_date as 'Returned Date'
from Borrowed_CD
inner join Borrower_Info on Borrowed_CD.borrowerID = Borrower_Info.borrowerID
inner join CD_inventory on Borrowed_CD.CD_ID = CD_inventory.CD_ID
order by [Borrower Name], [CD Name], [Borrowed Date], [Returned Date] asc;

-- selecting borrowed CDs and displaying times borrowed
select Borrowed_CD.CD_ID as 'CD ID', CD_name as 'CD Name', count(Borrowed_CD.CD_ID) as 'Times Borrowed'
from Borrowed_CD
inner join CD_inventory on Borrowed_CD.CD_ID = CD_inventory.CD_ID
group by Borrowed_CD.CD_ID, CD_name
order by Borrowed_CD.CD_ID asc;

--selecting cds that are on loan
select borrower_name as 'Borrower Name', CD_name as 'CD Name', borrowed_date as 'Borrowed Date', returned_date as 'Returned Date'
from Borrowed_CD
inner join Borrower_Info on Borrowed_CD.borrowerID = Borrower_Info.borrowerID
inner join CD_inventory on Borrowed_CD.CD_ID = CD_inventory.CD_ID
where returned_date is null
order by [Borrower Name], [CD Name], [Borrowed Date], [Returned Date] asc
