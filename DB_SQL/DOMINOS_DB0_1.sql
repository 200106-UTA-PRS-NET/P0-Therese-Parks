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
Price VARCHAR(45),
FK_IRestaurantID INT,--FK
PRIMARY KEY(PizzaId),
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
ComponentId INT IDENTITY(1,1),--PK
ComponentType VARCHAR(45),
FK_IRestaurantID INT,--FK
PRIMARY KEY(ComponentId),
FOREIGN KEY(FK_IRestaurantID)REFERENCES IRestaurant(IRestaurantId),
);

--Directly Implements Component by FK_CrustComponentId which is both a PK and FK
CREATE TABLE Crust(
FK_CrustComponentId INT IDENTITY, --PK,FK
PRIMARY KEY(FK_CrustComponentId),
FOREIGN KEY(FK_CrustComponentId)REFERENCES Component(ComponentId),
);

--Directly Implements Component by FK_SauceComponentId which is both a PK and FK
CREATE TABLE Sauce(
FK_SauceComponentId INT IDENTITY, --PK,FK
PRIMARY KEY(FK_SauceComponentId),
FOREIGN KEY(FK_SauceComponentId)REFERENCES Component(ComponentId),
);

--Directly Implements Component by FK_MeatComponentId which is both a PK and FK
CREATE TABLE Meat(
FK_MeatComponentId INT IDENTITY,--PK,FK
PRIMARY KEY(FK_MeatComponentId),
FOREIGN KEY(FK_MeatComponentId)REFERENCES Component(ComponentId),
);
--Directly Implements Component by FK_CheeseComponentId which is both a PK and FK
CREATE TABLE Cheese(
FK_CheeseComponentId INT IDENTITY,--PK,FK
PRIMARY KEY(FK_CheeseComponentId),
FOREIGN KEY(FK_CheeseComponentId)REFERENCES Component(ComponentId),
);
--Directly Implements Component by FK_VegetableComponentId which is both a PK and FK
CREATE TABLE Vegetable(
FK_VegetableComponentId INT IDENTITY,--PK,FK
PRIMARY KEY(FK_VegetableComponentId),
FOREIGN KEY(FK_VegetableComponentId)REFERENCES Component(ComponentId),
);

---------------------------PERSON AND CHILDREN----------------------------
--SCENARIO NOTE: If an attendent is using the app in store, placeholder fields
--would be used for customer infromation. E.g.--> the restaurant's phone number would act as a placedholder

--Directly Implements IRestaurant by FK_IRestaurantID which is FK
CREATE TABLE Person(
PersonId INT IDENTITY(1,1) NOT NULL,--PK
FirstName VARCHAR(45) NOT NULL,
LastName INT NOT NULL,
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
CustomerId INT NOT NULL, --PK
PassPin INT NOT NULL,
FK_CustomerId INT, --FK
PRIMARY KEY(FK_CustomerId),
FOREIGN KEY(FK_CustomerId)REFERENCES Person(PersonId),
);

SELECT * FROM IRestaurant;
SELECT * FROM PizzaSaleOrder;
SELECT * FROM Inventory;
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
