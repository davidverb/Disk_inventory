/**********************************************************************
* This script creates the database named disk_inventoryDV 
* Date		Programmer		Notes
* -------------------------------------------------------
* 10/4/2019 David Verbeck	Assignment 2 inital development
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
group_name varchar(60) NOT NULL
);

Create table CD_inventory (
CD_ID int NOT NULL PRIMARY KEY,
borrowerID int NOT NULL references Borrower_info(borrowerID),
artist_id int NOT NULL references Artist_info(artistID),
group_id int NOT NULL references Group_info(groupID),
CD_name varchar(60) NOT NULL,
status_type varchar(60) NOT NULL,
genre varchar(30) NOT NULL
);

Create table Borrowed_CD (
borrowerID int NOT NULL references Borrower_info(borrowerID),
CD_ID int NOT NULL references CD_inventory(CD_ID),
borrowed_date datetime NOT NULL,
returned_date datetime NOT NULL,
);


-- createing read-only user
create login diskUserDV with password = 'MSPress#1', default_database = disk_inventoryDV;

alter role db_datareader add member diskUserDV;
