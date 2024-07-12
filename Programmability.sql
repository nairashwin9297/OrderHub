USE OrderHub;
GO 

----------Encryption---------

-- Adding Encrypted Column to Customer table
ALTER TABLE Customer
ADD EncryptedPassword VARBINARY(MAX);

-- Encrypting existing passwords
UPDATE Customer
SET EncryptedPassword = ENCRYPTBYPASSPHRASE('YourEncryptionKey', CustomerPassword);

-- Example of encrypting a value
SELECT ENCRYPTBYPASSPHRASE('YourEncryptionKey', 'mysecretpassword');
GO

-- Create a stored procedure for inserting customer data with encrypted password
CREATE PROCEDURE sp_InsertCustomer
    @CustomerFirstName VARCHAR(255),
    @CustomerLastName VARCHAR(255),
    @CustomerEmail VARCHAR(255),
    @CustomerPassword VARCHAR(255),
    @CustomerContactNo VARCHAR(20)
AS
BEGIN

    DECLARE @EncryptedPassword VARBINARY(MAX);

    -- Encrypt the password
    SET @EncryptedPassword = ENCRYPTBYPASSPHRASE('YourEncryptionKey', @CustomerPassword);

    -- Insert the customer with the encrypted password
    INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPassword, EncryptedPassword, CustomerContactNo)
    VALUES (@CustomerFirstName, @CustomerLastName, @CustomerEmail, @CustomerPassword, @EncryptedPassword, @CustomerContactNo);

    -- Select all customer details along with the encrypted password
    SELECT CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPassword, EncryptedPassword, CustomerContactNo 
    FROM Customer 
    WHERE CustomerEmail = @CustomerEmail;
END;
GO

-- Example usage:
EXEC sp_InsertCustomer 'Vaibhavee', 'Gamit', 'gamit.v@example.com', 'password@123', '1234567893';

SELECT * FROM Customer;
GO



--------Triggers-------

--DML Trigger1

/*Trigger To check that Order cannot be placed if the Restaurant is closed and 
Customer and Restaurant don't belong to same State*/

-- Create combined trigger
CREATE TRIGGER PreventOrderPlacement
ON CustomerOrder
INSTEAD OF INSERT
AS
BEGIN
    -- Check if the restaurant is open before allowing order placement
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Restaurant r ON i.RestaurantID = r.RestaurantID
        WHERE r.IsOpen = 'No'
    )
    BEGIN
        RAISERROR ('Orders cannot be placed for restaurants that are closed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Check for state mismatch between customer address and restaurant
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN CustomerAddress ca ON i.CustomerID = ca.CustomerID
        INNER JOIN Restaurant r ON i.RestaurantID = r.RestaurantID
        WHERE ca.CustomerState <> r.RestaurantState
    )
    BEGIN
        RAISERROR ('Orders cannot be placed for restaurants located in different states.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- If conditions are met, allow the insertion of orders
    INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID)
    SELECT CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID
    FROM inserted;
END
GO

--Checking for closed restaurant
INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID)
VALUES
    (1003, 1011, '2024-04-08', '13:00:00', 'Delivered', '13:15:00', '13:37:00', 'No special comments', 1009);

--Checking for restaurant and customer in different state
INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID)
VALUES
    (1011, 1006, '2024-04-08', '15:00:00', 'Delivered', '15:16:00', '15:37:00', 'No special comments', 1013);


INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID)
VALUES
    (1013, 1016, '2024-04-08', '12:00:00', 'Preparing', '12:15:00', '12:36:00', 'No special comments', 1004);

INSERT INTO CustomerOrderItems (MenuItemsID, CustomerOrderID, Quantity)
VALUES
    (1078, 1037, 1);

SELECT * FROM CustomerOrder;
GO


--DML Trigger 2

/* Trigger to check if the Order delivery has not completed then Customer cannot give a review for particular Order*/

CREATE TRIGGER prevent_review_without_orderdelivered
ON Review
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare a variable to store the count of completed orders
    DECLARE @order_count INT;

    -- Check if there is a completed order associated with the CustomerOrderID from the inserted row
    SELECT @order_count = COUNT(*)
    FROM CustomerOrder
    INNER JOIN inserted i ON CustomerOrder.CustomerOrderID = i.CustomerOrderID
    WHERE CustomerOrder.OrderStatus = 'delivered';

    -- If no completed order exists, throw an error and prevent the insert
    IF @order_count = 0
    BEGIN
        RAISERROR ('Cannot leave a review without a completed order.', 16, 1);
        RETURN;
    END
    ELSE
    BEGIN
        -- If a completed order exists, insert the new row into the Review table
        INSERT INTO Review (ReviewDescription, Rating, CustomerOrderID)
        SELECT ReviewDescription, Rating, CustomerOrderID
        FROM inserted;
        PRINT 'Review updated';
    END
END;

--Generating error as order has not been delivered
INSERT INTO Review (ReviewDescription, Rating, CustomerOrderID)
VALUES
    ('Excellent food!', 4, 1035);


INSERT INTO Review (ReviewDescription, Rating, CustomerOrderID)
VALUES
    ('The food was delicious!', 4, 1001);
GO

SELECT * FROM Review;
GO



----------User Defined Functions------------

--Function1

--Function to calculate Total Price of the Customer Order

CREATE FUNCTION dbo.CalculateTotalOrderPrice(@CustomerOrderID INT) 
RETURNS DECIMAL(10, 2) 
AS 
BEGIN 

    DECLARE @TotalPrice DECIMAL(10, 2) = 0; 

    SELECT @TotalPrice = SUM(mi.ItemPrice * coi.Quantity) 
        FROM CustomerOrderItems AS coi 
        JOIN MenuItem AS mi ON coi.MenuItemsID = mi.MenuItemsID 
        WHERE coi.CustomerOrderID = @CustomerOrderID;

    RETURN ISNULL(@TotalPrice, 0); 
END; 
GO 

ALTER TABLE CustomerOrder 
ADD TotalPrice AS dbo.CalculateTotalOrderPrice(CustomerOrderID);
GO 

SELECT * FROM CustomerOrder;
GO

ALTER TABLE Payment 
ADD PaymentAmount AS dbo.CalculateTotalOrderPrice(CustomerOrderID);

SELECT * FROM Payment;
GO


--Function 2

--Function to calculate Average Delivery Time for a particular Delivery Executive

CREATE FUNCTION dbo.CalculateAverageDeliveryTime(@DeliveryExecutiveID INT)
RETURNS INT -- Returns average delivery time in minutes
AS
BEGIN
    DECLARE @AverageTime INT;
 
    -- Calculate the average delivery time in minutes
    SELECT @AverageTime = AVG(DATEDIFF(MINUTE, PickupTime, DeliveryTime))
    FROM CustomerOrder
    WHERE DeliveryExecutiveID = @DeliveryExecutiveID AND PickupTime IS NOT NULL AND DeliveryTime IS NOT NULL;
 
    RETURN ISNULL(@AverageTime, 0);
END;
GO

ALTER TABLE DeliveryExecutive
ADD AverageDeliveryTime1 AS dbo.CalculateAverageDeliveryTime(DeliveryExecutiveID);
GO

SELECT * FROM DeliveryExecutive;
GO


--Function 3

--Function to calculate Total LifetimeValue
CREATE FUNCTION dbo.CalculateCustomerLifetimeValue(@CustomerID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @LifetimeValue DECIMAL(10, 2);
 
    SELECT @LifetimeValue = ISNULL(SUM(TotalPrice), 0)
    FROM CustomerOrder
    WHERE CustomerID = @CustomerID AND OrderStatus = 'Delivered'; -- Assuming 'Delivered' marks an order as completed
 
    RETURN @LifetimeValue;
END;
GO

ALTER TABLE Customer
ADD LifetimeValue AS dbo.CalculateCustomerLifetimeValue(CustomerID);
GO

SELECT * FROM Customer;
GO



-------------Procedures----------------

--Procedure1

--Procedure to generate Monthly Sales Report
CREATE PROCEDURE GenerateMonthlySalesReport
    @Month INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Selecting order details within the given month and year
    SELECT
        CO.CustomerOrderID,
        CO.OrderDate,
        CO.TotalPrice,
        R.RestaurantName,
        SUM(COI.Quantity) AS TotalItemsSold
    FROM
        CustomerOrder CO
    INNER JOIN Restaurant R ON CO.RestaurantID = R.RestaurantID
    INNER JOIN CustomerOrderItems COI ON CO.CustomerOrderID = COI.CustomerOrderID
    WHERE
        MONTH(CO.OrderDate) = @Month AND YEAR(CO.OrderDate) = @Year
    GROUP BY
        CO.CustomerOrderID, CO.OrderDate, CO.TotalPrice, R.RestaurantName;
END;
GO

EXEC GenerateMonthlySalesReport @Month = 4, @Year = 2024;
GO 


--Procedure 2

--Procedure to generate Invoice
CREATE PROCEDURE GenerateInvoice
    @CustomerOrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the order exists
    IF NOT EXISTS (
        SELECT 1
        FROM CustomerOrder
        WHERE CustomerOrderID = @CustomerOrderID
    )
    BEGIN
        RAISERROR ('Order not found.', 16, 1);
        RETURN;
    END;

    -- Retrieve order details for the invoice
    DECLARE @CustomerID INT,
            @RestaurantID INT,
            @TotalPrice DECIMAL(10, 2),
            @CustomerName VARCHAR(255),
            @RestaurantName VARCHAR(255);

    SELECT @CustomerID = co.CustomerID,
           @RestaurantID = co.RestaurantID,
           @TotalPrice = co.TotalPrice,
           @CustomerName = c.CustomerFirstName + ' ' + c.CustomerLastName,
           @RestaurantName = r.RestaurantName
    FROM CustomerOrder co
    INNER JOIN Customer c ON co.CustomerID = c.CustomerID
    INNER JOIN Restaurant r ON co.RestaurantID = r.RestaurantID
    WHERE co.CustomerOrderID = @CustomerOrderID;

    -- Generate the invoice
    PRINT 'Invoice for Order ID: ' + CAST(@CustomerOrderID AS VARCHAR(10));
    PRINT 'Customer Name: ' + @CustomerName;
    PRINT 'Restaurant ID: ' + CAST(@RestaurantID AS VARCHAR(10));
    PRINT 'Restaurant Name: ' + @RestaurantName;
    PRINT '---------------------------------------';
    PRINT 'Total Amount: $' + CAST(@TotalPrice AS VARCHAR(10));
    PRINT '---------------------------------------';
    PRINT 'Thank you for your order!';
END;

EXEC GenerateInvoice @CustomerOrderID = 1000;
GO


--Procedure 3

--Procedure to update status if the order gets cancelled
CREATE PROCEDURE CancelOrder
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the order exists
    IF NOT EXISTS (
        SELECT 1
        FROM CustomerOrder
        WHERE CustomerOrderID = @OrderID
    )
    BEGIN
        RAISERROR ('Order not found.', 16, 1);
        RETURN;
    END;

    -- Update the order status to 'Cancelled'
    UPDATE CustomerOrder
    SET OrderStatus = 'Cancelled'
    WHERE CustomerOrderID = @OrderID;

    -- Update the payment status to 'Payment Cancelled'
    UPDATE Payment
    SET PaymentStatus = 'Payment Cancelled'
    WHERE CustomerOrderID = @OrderID;

    -- Output a success message
    PRINT 'Order cancelled successfully.';
END;

EXEC CancelOrder @OrderID = 1036;
GO

SELECT * FROM CustomerOrder;

SELECT * FROM Payment;
GO


--Procedure 4

--Procedure to Track Customer Order
CREATE PROCEDURE TrackOrder
    @CustomerID INT,
    @CustomerOrderID INT
    AS
    BEGIN
    SET NOCOUNT ON;

    -- Check if the order belongs to the specified customer
    IF NOT EXISTS (
        SELECT 1
        FROM CustomerOrder
        WHERE CustomerID = @CustomerID AND CustomerOrderID = @CustomerOrderID
    )
    BEGIN
        RAISERROR ('Order not found for the specified customer.', 16, 1);
        RETURN;
    END;

    -- Retrieve order details
    SELECT co.CustomerOrderID,
           co.OrderDate,
           co.OrderStatus,
           r.RestaurantName
    FROM CustomerOrder co
    INNER JOIN Restaurant r ON co.RestaurantID = r.RestaurantID
    WHERE co.CustomerOrderID = @CustomerOrderID;
END;

EXEC TrackOrder @CustomerID = 1000, @CustomerOrderID = 1000;
GO


--Procedure 5

--Procedure to get Order History of particular customer
CREATE PROCEDURE GetOrderHistory
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to retrieve order history
    SELECT
        co.CustomerID,
        co.CustomerOrderID,
        r.RestaurantName,
        co.OrderDate,
        co.TotalPrice    
    FROM CustomerOrder co
    INNER JOIN Restaurant r ON co.RestaurantID = r.RestaurantID
    WHERE co.CustomerID = @CustomerID;
END;

EXEC GetOrderHistory @CustomerID = 1001; 
GO


----------Views------------

-- View 1

--- View to display Most Sold Item for each Restaurant

CREATE VIEW MostSoldMenuItem AS
WITH TotalQuantityOfMenuItemsSold AS (
    SELECT r.RestaurantID, mi.MenuItemsID, mi.ItemName AS Name, SUM(coi.Quantity) AS TotalQuantity
    FROM CustomerOrderItems coi
    JOIN CustomerOrder co ON co.CustomerOrderID = coi.CustomerOrderID
    JOIN MenuItem mi ON mi.MenuItemsID = coi.MenuItemsID
    JOIN Menu m ON m.MenuID = mi.MenuID
    JOIN Restaurant r ON r.RestaurantID = m.RestaurantID
    GROUP BY r.RestaurantID, mi.MenuItemsID, mi.ItemName
)

SELECT RestaurantID, MenuItemsID, Name, TotalQuantity
FROM (SELECT RestaurantID, MenuItemsID, Name, TotalQuantity,
           RANK() OVER (PARTITION BY RestaurantID ORDER BY TotalQuantity DESC) AS rank
    FROM TotalQuantityOfMenuItemsSold) ranked
    WHERE rank = 1;
GO

-- To display the view
SELECT * FROM MostSoldMenuItem;
GO


--View 2

-- View to display top 5 rated restaurants

CREATE VIEW HighestRatedRestaurant AS
SELECT TOP 5
    R.RestaurantID,
    R.RestaurantName,
    AVG(Rev.Rating) AS AverageRating
    FROM Restaurant r
    JOIN CustomerOrder co ON r.RestaurantID = co.RestaurantID
    JOIN Review rev ON co.CustomerOrderID = rev.CustomerOrderID
    GROUP BY r.RestaurantID, r.RestaurantName
    ORDER BY AverageRating DESC;
GO

--to display the view
SELECT * FROM HighestRatedRestaurant;
GO


--View 3

--View to display Restaurant Order Summary like Total Revenue and Average Order Value 
CREATE VIEW RestaurantOrderSummary AS
SELECT 
    r.RestaurantID,  
    r.RestaurantName,
    COUNT(*) AS TotalOrders,
    SUM(co.TotalPrice) AS TotalRevenue,  
    AVG(co.TotalPrice) AS AverageOrderValue
    FROM CustomerOrder co
    JOIN Restaurant r ON r.RestaurantID = co.RestaurantID
    GROUP BY r.RestaurantID, r.RestaurantName;
GO

--To display the view 
SELECT * FROM RestaurantOrderSummary;
GO


--View 4

--View to display Customer Order Summary
CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    CONCAT(c.CustomerFirstName, ' ', c.CustomerLastName) AS CustomerName,
    COUNT(co.CustomerOrderID) AS TotalOrders,
    SUM(p.PaymentAmount) AS TotalPurchase,
    AVG(p.PaymentAmount) AS AvgOrderValue
    FROM Customer c 
    JOIN CustomerOrder co ON c.CustomerID = co.CustomerID
    JOIN Payment p ON co.CustomerOrderID = p.CustomerOrderID
    GROUP BY c.CustomerID, c.CustomerFirstName, c.CustomerLastName;
GO

-- To display the view:
SELECT * FROM CustomerOrderSummary; 
GO


--View 5

--View to display Customer Support Executive Performance
CREATE VIEW CustomerSupportExecutivePerformance AS
SELECT 
    cse.CustomerSupportExecutiveID,
    CONCAT(cse.ExecutiveFirstName, ' ', cse.ExecutiveLastName) AS ExecutiveName,
    COUNT(cos.CustomerOrderID) AS ResolvedComplaints
    FROM CustomerSupportExecutive cse
    LEFT JOIN CustomerOrderSupport cos ON cse.CustomerSupportExecutiveID = cos.CustomerSupportExecutiveID
    WHERE cos.ComplaintStatus = 'Resolved'
    GROUP BY cse.CustomerSupportExecutiveID, cse.ExecutiveFirstName, cse.ExecutiveLastName;
GO

-- To display the view:
SELECT * FROM CustomerSupportExecutivePerformance;
GO


--View 6

--View to display Delivery Executive's Performance
CREATE VIEW AverageDeliveryTimePerExecutive AS
SELECT
    de.DeliveryExecutiveID,
    de.DeliveryExecutiveName,
    AVG(DATEDIFF(MINUTE, co.PickupTime, co.DeliveryTime)) AS AverageDeliveryTime
    FROM DeliveryExecutive de
    INNER JOIN CustomerOrder co ON de.DeliveryExecutiveID = co.DeliveryExecutiveID
    WHERE co.PickupTime IS NOT NULL AND DeliveryTime IS NOT NULL 
    GROUP BY de.DeliveryExecutiveID, de.DeliveryExecutiveName;
GO

-- To display the view:
SELECT * FROM AverageDeliveryTimePerExecutive;
GO


--View 7

--View to display time taken to complete Complete Order
CREATE VIEW CompleteOrderTime AS
SELECT
    co.CustomerOrderID,
    AVG(DATEDIFF(MINUTE, co.OrderTime, co.DeliveryTime)) AS TotalTime
    FROM CustomerOrder co
    WHERE co.OrderTime IS NOT NULL AND DeliveryTime IS NOT NULL 
    GROUP BY co.CustomerOrderID;
GO

-- To display the view:
SELECT * FROM CompleteOrderTime;
