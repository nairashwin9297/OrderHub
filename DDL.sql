CREATE DATABASE OrderHub;
GO

USE OrderHub;
GO

-- Customer Table
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1000,1) PRIMARY KEY,
    CustomerFirstName VARCHAR(255),
    CustomerLastName VARCHAR(255),
    CustomerEmail VARCHAR(255),
    CustomerPassword VARCHAR(255),
    CustomerContactNo VARCHAR(20)
);

CREATE NONCLUSTERED INDEX IX_Customer_CustomerEmail ON Customer (CustomerEmail);

-- CustomerAddress Table
CREATE TABLE CustomerAddress (
    AddressID INT IDENTITY(1000,1) PRIMARY KEY,
    CustomerID INT,
    CustomerStreet VARCHAR(255),
    CustomerCity VARCHAR(255),
    CustomerState VARCHAR(255),
    CustomerZipcode VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Restaurant Table
CREATE TABLE Restaurant (
    RestaurantID INT IDENTITY(1000,1) PRIMARY KEY,
    RestaurantName VARCHAR(255),
    RestaurantContactNo VARCHAR(20),
    RestaurantStreet VARCHAR(255),
    RestaurantCity VARCHAR(255),
    RestaurantState VARCHAR(255),
    RestaurantZipCode VARCHAR(10),
    RestaurantType VARCHAR(100) CHECK(RestaurantType IN ('Indian', 'Mexican', 'Italian', 'Continental', 'Korean')),
    IsOpen CHAR(3) CHECK (IsOpen IN ('Yes','No')) 
);

CREATE NONCLUSTERED INDEX IX_Restaurant_RestaurantType ON Restaurant (RestaurantType);

-- Menu Table
CREATE TABLE Menu (
    MenuID INT IDENTITY(1000,1) PRIMARY KEY,
    RestaurantID INT,
    MenuType VARCHAR(100) CHECK(MenuType IN ('Food', 'Beverages', 'Dessert')),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE NONCLUSTERED INDEX IX_Menu_MenuType ON Menu (MenuType);

-- MenuItem Table
CREATE TABLE MenuItem (
    MenuItemsID INT IDENTITY(1000,1) PRIMARY KEY,
    MenuID INT,
    ItemName VARCHAR(255),
    ItemDescription TEXT,
    ItemPrice DECIMAL(10, 2),
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)
);

-- Delivery Executive Table
CREATE TABLE DeliveryExecutive (
    DeliveryExecutiveID INT IDENTITY(1000,1) PRIMARY KEY,
    DeliveryExecutiveName VARCHAR(255),
    DeliveryExecutiveContactNo VARCHAR(20),
);

-- Customer Support Executive Table
CREATE TABLE CustomerSupportExecutive (
    CustomerSupportExecutiveID INT IDENTITY(1000,1) PRIMARY KEY,
    ExecutiveFirstName VARCHAR(255),
    ExecutiveLastName VARCHAR(255),
);

-- Customer Order Table
CREATE TABLE CustomerOrder (
    CustomerOrderID INT IDENTITY(1000,1) PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    OrderTime TIME,
    OrderStatus VARCHAR(50),
    PickupTime TIME ,
    DeliveryTime TIME,
    Comments TEXT,
    DeliveryExecutiveID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
    FOREIGN KEY (DeliveryExecutiveID) REFERENCES DeliveryExecutive(DeliveryExecutiveID),
    CONSTRAINT CheckDeliveryTime CHECK (DeliveryTime > PickupTime)
);

CREATE NONCLUSTERED INDEX IX_CustomerOrder_CustomerID ON CustomerOrder (CustomerID);

CREATE NONCLUSTERED INDEX IX_CustomerOrder_RestaurantID ON CustomerOrder (RestaurantID);

CREATE NONCLUSTERED INDEX IX_CustomerOrder_DeliveryExecutiveID ON CustomerOrder (DeliveryExecutiveID);

-- Customer Order Support Table
CREATE TABLE CustomerOrderSupport (
    CustomerSupportExecutiveID INT,
    CustomerOrderID INT,
    ComplaintStatus VARCHAR(255),
    PRIMARY KEY (CustomerSupportExecutiveID, CustomerOrderID),
    FOREIGN KEY (CustomerSupportExecutiveID) REFERENCES CustomerSupportExecutive(CustomerSupportExecutiveID),
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder(CustomerOrderID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT IDENTITY(1000,1) PRIMARY KEY,
    TypeOfPayment VARCHAR(50),
    PaymentStatus VARCHAR(50),
    CustomerOrderID INT,
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder(CustomerOrderID)
);

CREATE NONCLUSTERED INDEX IX_Payment_CustomerOrderID ON Payment (CustomerOrderID);

-- Review Table
CREATE TABLE Review (
    ReviewID INT IDENTITY(1000,1) PRIMARY KEY,
    ReviewDescription TEXT,
    Rating INT,
    CustomerOrderID INT,
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder(CustomerOrderID)
);

CREATE NONCLUSTERED INDEX IX_Review_CustomerOrderID ON Review (CustomerOrderID);

-- Customer Order Items Table
CREATE TABLE CustomerOrderItems (
    MenuItemsID INT,
    CustomerOrderID INT,
    Quantity INT CHECK (Quantity>0),
    PRIMARY KEY (MenuItemsID, CustomerOrderID),
    FOREIGN KEY (MenuItemsID) REFERENCES MenuItem(MenuItemsID),
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder(CustomerOrderID)
);

CREATE NONCLUSTERED INDEX IX_CustomerOrderItems_MenuItemsID ON CustomerOrderItems (MenuItemsID);

CREATE NONCLUSTERED INDEX IX_CustomerOrderItems_CustomerOrderID ON CustomerOrderItems (CustomerOrderID);

