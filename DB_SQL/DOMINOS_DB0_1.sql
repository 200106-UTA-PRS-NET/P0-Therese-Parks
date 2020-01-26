CREATE DATABASE DOMINOS_DB0;
USE DOMINOS_DB0;
-----------------------------FIRST PARENT OF TREE----------------------------
CREATE TABLE IRestaurant(
IRestaurantId INT IDENTITY(1,1), --PK
IRestaurantName VARCHAR(45)
IRestaurantPhone VARCHAR(12),
IRestaurantLocation VARCHAR(45),
PRIMARY KEY(IRestaurantId),
);

-------------------DIRECT IMPLEMENTATIONS OF TREE, NO CHILDREN--------------------

-- Directly Implements IRestaurant by FK_IRestaurantID,Leaf
CREATE TABLE PizzaSaleOrder(
PizzaSaleOrderId INT IDENTITY(1,1),--PK
TimeCountDown TIME,
SaleDateTime DATETIME,
SumOfPizzaSaleOrders FLOAT,
CountOfPizzaOrders INT,
FK_IRestaurantID INT,--FK
PRIMARY KEY(PizzaSaleOrderId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),
);

-- Directly Implements IRestaurant by FK_IRestaurantID,Leaf
CREATE TABLE Pizza(
PizzaId INT IDENTITY(1,1),--PK
Size VARCHAR(45),
Price FLOAT,
FK_PizzaSaleOrderId INT,
FK_IRestaurantID INT,--FK
Name VARCHAR(45),
CrustType VARCHAR(45),
CheeseType VARCHAR(45),
Extra VARCHAR(45),
Extra2 VARCHAR(45),
Extra3 VARCHAR(45),
PRIMARY KEY(PizzaId),
FOREIGN KEY(FK_PizzaSaleOrderId)REFERENCES PizzaSaleOrder(PizzaSaleOrderId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),

); 

-- Directly Implements IRestaurant by FK_IRestaurantID,Leaf
CREATE TABLE Inventory(
InventoryId INT IDENTITY(1,1),--FK
lbsOfCrustBatter INT,
lbsOfCheese INT,
lbsOfSauce INT,
lbsOfMeat INT,
lbsOfVegetables INT,
FK_IRestaurantID INT,--FK
PRIMARY KEY(InventoryId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),
);

-------------------------COMPONENTS AND CHILDREN----------------------------

-- Directly Implements IRestaurant by FK_IRestaurantID, Abstract has Children
CREATE TABLE Component(
ComponentId INT,--PK
FK_IRestaurantID INT,--FK
ThinCrust VARCHAR(45),
ThickCrust VARCHAR(45),
CheddarCheese VARCHAR(45),
RegualarSauce VARCHAR(45),
SpicySauce VARCHAR(45),
Olives VARCHAR(45),
Onions VARCHAR(45),
Mushrooms VARCHAR(45),
PRIMARY KEY(ComponentId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),
)

--Giving Componenet options to store 1
Insert into Component(ComponentId, FK_IRestaurantID,ThinCrust,ThickCrust,CheddarCheese,RegualarSauce,SpicySauce,Olives,Onions,Mushrooms)
VALUES(1, 1, 'Thin','Thick','Cheddar','Rugular','Spicy', 'Olivles','Onions', 'Mushrooms');

--Giving Component options to store 2
Insert into Component(ComponentId, FK_IRestaurantID,ThinCrust,ThickCrust,CheddarCheese,RegualarSauce,SpicySauce,Olives,Onions,Mushrooms)
VALUES(2, 2, 'Thin','Thick','Cheddar','Rugular','Spicy', 'Olivles','Onions', 'Mushrooms');
SELECT * FROM Component;

INsert into pizza(Size,price, FK_PizzaSaleOrderId, FK_IRestaurantID, Name, CrustType, CheeseType, Extra, Extra2, Extra3)
VALUES('Small', 5.00, 1, 1, 'Custom', 'Thick','Cheddar', 'Onion', 'Olive', NULL);
INsert into pizza(Size,price, FK_PizzaSaleOrderId, FK_IRestaurantID, Name, CrustType, CheeseType, Extra, Extra2, Extra3)
VALUES('Large', 9.00, 1, 1, 'Custom', 'Thick','Cheddar', 'Onion', 'Olive', NULL);
Select * From PizzaSaleOrder;
Select * From Pizza where FK_PizzaSaleOrderId = 1;

SELECT * FROM Pizza;
--Directly Implements Component by FK_CrustComponentId which is both a PK and FK

---------------------------PERSON AND CHILDREN----------------------------
--SCENARIO NOTE: If an attendent is using the app in store, placeholder fields
--would be used for customer infromation. E.g.--> the restaurant's phone number would act as a placedholder

--Directly Implements IRestaurant by FK_IRestaurantID which is FK
CREATE TABLE Person(
PersonId INT IDENTITY(1,1) NOT NULL,--PK
FirstName VARCHAR(45) NOT NULL,
LastName VARCHAR(45) NOT NULL,
PhoneNumber VARCHAR(12) NOT NULL,
EmailAddress VARCHAR(45),
FK_IRestaurantID INT,--FK
PRIMARY KEY(PersonId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),
);

--Directly Inherits from Person by FK_PersonId which is FK
CREATE TABLE Employee(
EmployeeId INT IDENTITY(1,1) NOT NULL, --PK
Role VARCHAR(45),
FK_PersonId INT, --FK
PRIMARY KEY(EmployeeId),
FOREIGN KEY(FK_PersonId)REFERENCES Person(PersonId),
);
--Directly Inherits from Manager by FK_Manager_EmployeeId which is FK and PK
CREATE TABLE Manager(
FK_Manager_EmployeeId INT NOT NULL,  --PK, FK
PRIMARY KEY(FK_Manager_EmployeeId),
FOREIGN KEY(FK_Manager_EmployeeId)REFERENCES Employee(EmployeeId),
);
--Directly Inherits from Manager by FK_Attendent_Employee which is FK and PK
CREATE TABLE Attendant(
FK_Attendent_Employee INT NOT NULL, --PK, FK
PRIMARY KEY(FK_Attendent_Employee),
FOREIGN KEY(FK_Attendent_Employee)REFERENCES Employee(EmployeeId),
);


--Directly Inherits from Person by FK_PersonId which is FK
CREATE TABLE Customer(
CustomerId INT NOT NULL, --PK
FK_PersonId INT, --FK
PRIMARY KEY(CustomerId),
FOREIGN KEY(FK_PersonId)REFERENCES Person(PersonId),
);

--Directly Inherits from Customer by FK_CustomerId which is FK
CREATE TABLE PassCredentials(
PassName INT NOT NULL, --PK
PassPin INT NOT NULL,
FK_CustomerId INT, --FK
FOREIGN KEY(FK_CustomerId)REFERENCES Person(PersonId),
);

--Alter table PassCredentials add  PassName VARCHAR(45);

SELECT * FROM IRestaurant;
SELECT * FROM Inventory;
SELECT * FROM PizzaSaleOrder;

SELECT * FROM Pizza;
SELECT * FROM Component;
SELECT * FROM Crust;
SELECT * FROM Sauce;
SELECT * FROM Meat;
SELECT * FROM Cheese;
SELECT * FROM Vegetable;

SELECT * FROM Person;
SELECT * FROM Employee;
SELECT * FROM Manager;
SELECT * FROM Attendant;

SELECT * FROM Customer;
SELECT * FROM PassCredentials;

--Adding new IRestaurant
INSERT INTO IRestaurant(IRestaurantName,IRestaurantPhone,IRestaurantLocation) VALUES ('Dominos Pizza', '111-111-1111', 'Austin, TX');
INSERT INTO IRestaurant(IRestaurantName,IRestaurantPhone,IRestaurantLocation) VALUES ('Dominos Pizza', '222-222-2222', 'Dallas, TX');

--Adding new PizzaSaleOrder
INSERT INTO PizzaSaleOrder(TimeCountDown,SaleDateTime,SumOfPizzaSaleOrders,CountOfPizzaOrders,FK_IRestaurantID) 
VALUES('1:00', NULL, 0, 0, 1);
INSERT INTO PizzaSaleOrder(TimeCountDown,SaleDateTime,SumOfPizzaSaleOrders,CountOfPizzaOrders,FK_IRestaurantID) 
VALUES('1:00', NULL, 1, 1, 1);

--Adding new Inventory
INSERT INTO Inventory(lbsOfCrustBatter,lbsOfCheese,lbsOfSauce,lbsOfMeat,lbsOfVegetables,FK_IRestaurantID)
VALUES(20, 15, 16, 30, 15, 1);

--Adding new Pizza
INSERT INTO Pizza(Size,Price,FK_PizzaSaleOrderId, FK_IRestaurantID) VALUES('Small', 5.00, 1, 1);
INSERT INTO Pizza(Size,Price,FK_PizzaSaleOrderId, FK_IRestaurantID) VALUES('Medium', 7.00, 1, 1);
INSERT INTO Pizza(Size,Price,FK_PizzaSaleOrderId, FK_IRestaurantID) VALUES('Large', 9.00, 1, 1);


INSERT INTO Pizza(Size,Price,FK_PizzaSaleOrderId, FK_IRestaurantID) VALUES('Medium', 7.00, 2,2);
INSERT INTO Pizza(Size,Price,FK_PizzaSaleOrderId, FK_IRestaurantID) VALUES('Large', 9.00, 2,2);
--Adding new Component
--thin crust id is 1
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(1, 1);--thin
--thick crust id is 2
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(2, 1);--thick
--Adding a Crust
INSERT INTO Crust(Type) VALUES('Thin');
INSERT INTO Crust( Type)VALUES('Thick');


--sauce is regular id is 3
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(3, 1);--regular
--Adding a Sauce
INSERT INTO Sauce(Type) VALUES('Regular');
--Adding a Meat

--meat Pepperoni is 4, Bacon is 5, Beef is 6
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(4, 1);--pepperoni
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(5, 1);--bacon
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(6, 1);--beef
INSERT INTO Meat(Type) VALUES('Pepperoni');
INSERT INTO Meat(Type) VALUES('Bacon');
INSERT INTO Meat(Type) VALUES('beef');

--Adding a Cheese
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(7, 1);--cheddar
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(8, 1);--provolone
INSERT INTO Cheese(Type) VALUES('Cheddar');
INSERT INTO Cheese(Type) VALUES('Provolone');

--Adding a Vegetable
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(9, 1);--onion
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(10, 1);--black peeper
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(11, 1);--black olives
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(12, 1);--green olives
INSERT INTO Component(ComponentId, FK_IRestaurantID) VALUES(13, 1);--mushrooms
INSERT INTO Vegetable(Type) VALUES('Onion');
INSERT INTO Vegetable(Type) VALUES('Bell Pepper');
INSERT INTO Vegetable(Type) VALUES('Black Olives');
INSERT INTO Vegetable(Type) VALUES('Green Olives');
INSERT INTO Vegetable(Type) VALUES('Mushrooms');

--adding Person for Employees
INSERT INTO Person(FirstName,LastName,PhoneNumber,EmailAddress, FK_IRestaurantID)
VALUES('First1','Last1','111-111-1111','first1@dominos.com', 1);
INSERT INTO Person(FirstName,LastName,PhoneNumber,EmailAddress, FK_IRestaurantID)
VALUES('Test2','Last2','222-222-2222','test2@dominos.com', 2);
INSERT INTO Person(FirstName,LastName,PhoneNumber,EmailAddress, FK_IRestaurantID)
VALUES('Test3','Last3','333-333-3333','test3@dominos.com', 1);
--adding persons for customers
INSERT INTO Person(FirstName,LastName,PhoneNumber,EmailAddress, FK_IRestaurantID)
VALUES('Test4','Last4','444-444-4444','test4@dominos.com', 2);
INSERT INTO Person(FirstName,LastName,PhoneNumber,EmailAddress, FK_IRestaurantID)
VALUES('Test5','Last5','555-555-5555','test5@dominos.com', 1);


--adding Employee
INSERT INTO Employee(Role,FK_PersonId)VALUES('Cashier',3 );--restaurant 1
INSERT INTO Employee(Role,FK_PersonId)VALUES('Kitchen', 4);--restaurant 1
INSERT INTO Employee(Role,FK_PersonId)VALUES('Office', 6);--restaurant 2

--adding manager
INSERT INTO Manager(FK_Manager_EmployeeId)VALUES( 11);--This makes Employee with id 11 a manager
--adding attendant
INSERT INTO Attendant(FK_Attendent_Employee)VALUES( 5);--This makes Employee with id 5 an attendant
INSERT INTO Attendant(FK_Attendent_Employee)VALUES( 6);--This makes Employee with id 6 an attendant

--adding customer
INSERT INTO Customer(CustomerId, FK_PersonId)VALUES(1, 9);
INSERT INTO Customer(CustomerId,FK_PersonId)VALUES(2, 10);
--adding PassCredentials
INSERT INTO PassCredentials(PassPin,FK_CustomerId,PassName) VALUES (1111, 9, 'Test4');
INSERT INTO PassCredentials(PassPin,FK_CustomerId,PassName) VALUES (1111, 10, 'Test4');

Select * FROM Component;
Select * FROM Pizza;
------------------------------Testing Requirements------------------------------------------------------
--1.Restaurant should be able to view it's completed orders.
SELECT * FROM PizzaSaleOrder
WHERE FK_IRestaurantID = 1;
--2.Restaurant should be able to view its completed orders
SELECT * From PizzaSaleOrder Where FK_IRestaurantID = 1;
--3.Restaurant should be able to view it's sales
SELECT PizzaId,Size,Price FROM Pizza Where FK_IRestaurantID = 1;
--4.Restaurant should be able to view its inventory
SELECT * FROM Inventory WHERE FK_IRestaurantID = 1;
--5.Restaurant should be able to view its People
Select * from Person where FK_IRestaurantID = 1;
Select * from Person where FK_IRestaurantID = 2;
-- 6.I can delete a  pizza store and all persons with specified id

--7.Customer should be able to view order history
Select * FROM PizzaSaleOrder Where PizzaSaleOrderId = 1;
-- 8.PizzaSaleOrder should be able to view its pizzas
Select PizzaSaleOrderId, SumOfPizzaSaleOrders,PizzaId,Size,Price
FROM PizzaSaleOrder, Pizza WHERE PizzaSaleOrderId  = 1;
--9.PizzaSaleOrder should be able to compute its cost
Select SUM(Price) FROM  Pizza WHERE FK_PizzaSaleOrderId = 1;
--10.Should be able to limit its cost to no more thatn $250
Select SUM(Price) FROM Pizza WHERE FK_PizzaSaleOrderId = 1; --finish with BL
--11.Should be able to limit its pizza count to no more than 100;
Select COUNT(PizzaId) FROM Pizza where FK_PizzaSaleOrderId = 1; -- use BL to complete






