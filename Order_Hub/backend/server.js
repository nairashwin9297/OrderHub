const express = require('express');
const sql = require('mssql');
const cors = require('cors');
// require('dotenv').config();

const crypto = require('crypto'); 

const app = express();

// Middleware to parse JSON bodies
app.use(express.json());

app.use(cors());

// MSSQL database connection configuration
const dbConfig = {
    user: 'sa',
    password: 'Ashwin@123',
    server: 'localhost', // You can use 'localhost\\instance' to connect to named instance
    database: 'OrderHub',
    options: {
        encrypt: false, // Use this if you're on Windows Azure
        // trustServerCertificate: false // True if you're on local development and using self-signed certs
    }
};

// Test database connection
sql.connect(dbConfig)
    .then(pool => {
        if (pool.connecting) {
            console.log('Connecting to the SQL Server...');
        }

        if (pool.connected) {
            console.log('Connected to SQL Server successfully.');
        }
    })
    .catch(err => {
        console.error('Failed to connect to SQL Server:', err);
    });

// Basic route for testing the server
app.get('/', (req, res) => {
    res.send('Food Ordering App Backend is running...');
});

app.get('/api/employees', async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig); // Establish connection
        const result = await pool.request().query('SELECT * FROM employee');
        res.json(result.recordset); // Send the retrieved data as JSON
    } catch (err) {
        console.error('Error fetching employees:', err);
        res.status(500).send('Error retrieving employees');
    }
});


app.post('/api/createusers', async (req, res) => {
    const { firstName, lastName, email, password, contactNo } = req.body;
    try {
        const pool = await sql.connect(dbConfig);
        const query = `
            INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPassword, CustomerContactNo)
            VALUES (@firstName, @lastName, @email, @password, @contactNo);
        `;
        await pool.request()
            .input('firstName', sql.VarChar, firstName)
            .input('lastName', sql.VarChar, lastName)
            .input('email', sql.VarChar, email)
            .input('password', sql.VarChar, password)
            .input('contactNo', sql.VarChar, contactNo)
            .query(query);
        res.status(201).send('User created successfully');
    } catch (err) {
        console.error('Error creating user:', err);
        res.status(500).send('Error creating user');
    }
});

app.post('/api/users/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const pool = await sql.connect(dbConfig);
        const result = await pool.request()
            .input('email', sql.VarChar, email)
            .input('password', sql.VarChar, password)
            .query('SELECT CustomerID FROM Customer WHERE CustomerEmail = @email AND CustomerPassword = @password');
        if (result.recordset.length > 0) {
            res.json({ success: true, message: 'Login successful', userId: result.recordset[0].CustomerID });
        } else {
            res.status(401).send('Invalid credentials');
        }
    } catch (err) {
        console.error('Error logging in:', err);
        res.status(500).send('Error logging in');
    }
});
// Import the crypto module for encryption

// app.post('/api/users/login', async (req, res) => {
//     const { email, password } = req.body;

//     console.log('Insideee')
//     try {
//         const pool = await sql.connect(dbConfig);
//         const result = await pool.request()
//             .input('email', sql.VarChar, email)
//             .query('SELECT CustomerID, PasswordProtected FROM Customer WHERE CustomerEmail = @email');
//         if (result.recordset.length > 0) {
//             console.log('Seccesssssss')
//             console.log(result)
//             const encryptedPasswordFromDB = result.recordset[0].PasswordProtected;
//             const symmetricKey = crypto.createDecipheriv('aes-256-cbc', 'password@2023', Buffer.alloc(16)); // Use the same encryption algorithm and key as used during encryption
//             const decryptedPasswordFromDB = symmetricKey.update(encryptedPasswordFromDB, 'hex', 'utf8') + symmetricKey.final('utf8');
            
//             if (password === decryptedPasswordFromDB) {
//                 res.json({ success: true, message: 'Login successful', userId: result.recordset[0].CustomerID });
//             } else {
//                 res.status(401).send('Invalid credentials');
//             }
//         } else {
//             res.status(401).send('Invalid credentials');
//         }
//     } catch (err) {
//         console.error('Error logging in:', err);
//         res.status(500).send('Error logging in');
//     }
// });


app.post('/api/users/:userId/addresses', async (req, res) => {
    const { userId } = req.params;
    const { street, city, state, zipcode } = req.body;
    
    // Validate input
    if (!street || !city || !state || !zipcode) {
        return res.status(400).send('All address fields are required.');
    }

    try {
        const pool = await sql.connect(dbConfig);
        const query = `
            INSERT INTO CustomerAddress (CustomerID, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode)
            VALUES (@userId, @street, @city, @state, @zipcode);
        `;
        await pool.request()
            .input('userId', sql.Int, userId)
            .input('street', sql.VarChar, street)
            .input('city', sql.VarChar, city)
            .input('state', sql.VarChar, state)
            .input('zipcode', sql.VarChar, zipcode)
            .query(query);
        res.status(201).send('Address added successfully');
    } catch (err) {
        console.error('Error adding address:', err);
        res.status(500).send('Error adding address');
    }
});


// app.get('/api/restaurants', async (req, res) => {
//     try {
//         const pool = await sql.connect(dbConfig);
//         const result = await pool.request().query('SELECT * FROM Restaurant');
        
//         res.json(result.recordset);
//     } catch (err) {
//         console.error('Error fetching restaurants:', err);
//         res.status(500).send('Error retrieving restaurants');
//     }
// });

app.get('/api/restaurants', async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig);

        // Fetch restaurant details
        const restaurantsResult = await pool.request().query('SELECT * FROM Restaurant');

        // Fetch restaurant order summary from the view
        const orderSummaryResult = await pool.request().query('SELECT * FROM RestaurantOrderSummary');

        // Merge restaurant details with order summary
        const restaurants = restaurantsResult.recordset.map(restaurant => {
            const orderSummary = orderSummaryResult.recordset.find(summary => summary.RestaurantID === restaurant.RestaurantID);
            return {
                ...restaurant,
                TotalOrders: orderSummary ? orderSummary.TotalOrders : 0,
                TotalRevenue: orderSummary ? orderSummary.TotalRevenue : 0,
                AverageOrderValue: orderSummary ? orderSummary.AverageOrderValue : 0
            };
        });

        res.json(restaurants);
    } catch (err) {
        console.error('Error fetching restaurants:', err);
        res.status(500).send('Error retrieving restaurants');
    }
});


// app.get('/api/restaurants/:restaurantId/menus', async (req, res) => {
//     const { restaurantId } = req.params;
//     try {
//         const pool = await sql.connect(dbConfig);
//         const result = await pool.request()
//             .input('restaurantId', sql.Int, restaurantId)
//             .query('SELECT * FROM Menu WHERE RestaurantID = @restaurantId');
//         res.json(result.recordset);
//     } catch (err) {
//         console.error('Error fetching menus:', err);
//         res.status(500).send('Error retrieving menus');
//     }
// });

app.get('/api/restaurants/:restaurantId/menus', async (req, res) => {
    const { restaurantId } = req.params;
    try {
        console.log('INSIDE',restaurantId)
        const pool = await sql.connect(dbConfig);
        const result = await pool.request()
            .input('restaurantId', sql.Int, restaurantId)
            .query(`
                SELECT m.MenuID, m.MenuType, mi.MenuItemsID, mi.ItemName, mi.ItemDescription, mi.ItemPrice
                FROM Menu m
                INNER JOIN MenuItem mi ON m.MenuID = mi.MenuID
                WHERE m.RestaurantID = @restaurantId
            `);
        const menus = {};
        result.recordset.forEach(row => {
            if (!menus[row.MenuID]) {
                menus[row.MenuID] = {
                    MenuID: row.MenuID,
                    MenuType: row.MenuType,
                    MenuItems: []
                };
            }
            menus[row.MenuID].MenuItems.push({
                MenuItemsID: row.MenuItemsID,
                ItemName: row.ItemName,
                ItemDescription: row.ItemDescription,
                ItemPrice: row.ItemPrice
            });
        });
        res.json(Object.values(menus));
    } catch (err) {
        console.error('Error fetching menus:', err);
        res.status(500).send('Error retrieving menus');
    }
});



app.post('/api/orders', async (req, res) => {
    console.log('ORDEr Placed')
    const { customerId, restaurantId, menuItems, comments } = req.body; // Assuming the request body contains these fields
    
    // Create a SQL table that matches the structure of MenuItemsTableType
    const menuItemsTable = new sql.Table(); // Create an instance of Table
    // Define columns that match the SQL user-defined table type structure
    menuItemsTable.columns.add('MenuItemsID', sql.Int);
    menuItemsTable.columns.add('Quantity', sql.Int);
    
    // Populate the table with menu items
    menuItems.forEach(item => {
        menuItemsTable.rows.add(item.menuItemsId, item.quantity);
    });

    try {
        const pool = await sql.connect(dbConfig);
        const request = pool.request();
        request.input('CustomerID', sql.Int, customerId);
        request.input('RestaurantID', sql.Int, restaurantId);
        request.input('MenuItems', menuItemsTable); // Pass the table as a parameter
        request.input('Comments', sql.Text, comments);
        request.output('CustomerOrderID', sql.Int); // To retrieve the output parameter
        
        // Execute the stored procedure
        await request.execute('CreateNewOrder');
        
        // Retrieve the output parameter (CustomerOrderID) from the request
        const newOrderId = request.parameters.CustomerOrderID.value;
        res.json({ success: true, message: 'Order placed successfully', orderId: newOrderId });
    } catch (err) {
        console.error('Error placing order:', err);
        res.status(500).send('Error placing order');
    }
});


// app.post('/api/payments', async (req, res) => {
//     const { customerOrderId, typeOfPayment, paymentAmount } = req.body; // Assumes these details are sent in the request body

//     // Example: Call to an external payment processing service
//     // For the sake of this example, we'll assume the payment is always successful
//     const paymentSuccessful = true; // This should be replaced with actual payment verification logic

//     if (paymentSuccessful) {
//         try {
//             const pool = await sql.connect(dbConfig);
//             const query = `
//                 INSERT INTO Payment (TypeOfPayment, PaymentAmount, PaymentStatus, CustomerOrderID)
//                 VALUES (@TypeOfPayment, @PaymentAmount, 'Completed', @CustomerOrderID);
//             `;
//             await pool.request()
//                 .input('TypeOfPayment', sql.VarChar, typeOfPayment)
//                 .input('PaymentAmount', sql.Decimal(10, 2), paymentAmount)
//                 .input('CustomerOrderID', sql.Int, customerOrderId)
//                 .query(query);
//             res.status(201).json({ success: true, message: 'Payment processed successfully' });
//         } catch (err) {
//             console.error('Error processing payment:', err);
//             res.status(500).send('Error processing payment');
//         }
//     } else {
//         // Handle failed payment
//         res.status(400).json({ success: false, message: 'Payment failed' });
//     }
// });


// app.post('/api/payment', async (req, res) => {
//     const { customerId, restaurantId, menuItems, comments, typeOfPayment, paymentAmount } = req.body;
//     const pool = await sql.connect(dbConfig);

//     try {
//         const currentDate = new Date();
//         const orderDate = currentDate.toISOString().slice(0, 10);
//         const orderTime = currentDate.getHours().toString().padStart(2, '0') + ':' +
//                           currentDate.getMinutes().toString().padStart(2, '0') + ':' +
//                           currentDate.getSeconds().toString().padStart(2, '0');
//         const orderStatus = 'Placed';
        
//         const customerOrderResult = await pool.request()
//             .input('CustomerID', sql.Int, customerId)
//             .input('RestaurantID', sql.Int, restaurantId)
//             .input('OrderDate', sql.Date, orderDate)
//             .input('OrderTime', sql.VarChar(8), orderTime)
//             .input('OrderStatus', sql.VarChar(50), orderStatus)
//             .input('Comments', sql.Text, comments)
//             .query(`
//                 INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, Comments)
//                 OUTPUT inserted.CustomerOrderID
//                 VALUES (@CustomerID, @RestaurantID, @OrderDate, @OrderTime, @OrderStatus, @Comments);
//             `);

//         const customerOrderID = customerOrderResult.recordset[0].CustomerOrderID;

//         // Insert menu items into CustomerOrderItems table
//         for (const menuItem of menuItems) {
//             await pool.request()
//                 .input('MenuItemsID', sql.Int, menuItem.MenuItemsID)
//                 .input('CustomerOrderID', sql.Int, customerOrderID)
//                 .input('Quantity', sql.Int, menuItem.Quantity)
//                 .query(`
//                     INSERT INTO CustomerOrderItems (MenuItemsID, CustomerOrderID, Quantity)
//                     VALUES (@MenuItemsID, @CustomerOrderID, @Quantity);
//                 `);
//         }

//         // Insert payment information into Payment table
//         await pool.request()
//             .input('TypeOfPayment', sql.VarChar(50), typeOfPayment)
//             .input('PaymentAmount', sql.Decimal(10, 2), paymentAmount)
//             .input('PaymentStatus', sql.VarChar(50), 'Confirmed')
//             .input('CustomerOrderID', sql.Int, customerOrderID)
//             .query(`
//                 INSERT INTO Payment (TypeOfPayment, PaymentAmount, PaymentStatus, CustomerOrderID)
//                 VALUES (@TypeOfPayment, @PaymentAmount, @PaymentStatus, @CustomerOrderID);
//             `);
//         console.log('Order confirmed')
//         res.json({ success: true, message: 'Order placed and payment confirmed successfully' });
//     } catch (error) {
//         console.error('Error placing order and completing payment:', error);
//         res.status(500).send('Error placing order and completing payment');
//     }
// });

// app.post('/api/orderItems/add', async (req, res) => {
//     const { customerOrderID, menuItemsID, quantity } = req.body;
//     const pool = await sql.connect(dbConfig);

//     try {
//         // Check if the item already exists in the order
//         const existingItem = await pool.request()
//             .input('CustomerOrderID', sql.Int, customerOrderID)
//             .input('MenuItemsID', sql.Int, menuItemsID)
//             .query(`
//                 SELECT Quantity
//                 FROM CustomerOrderItems
//                 WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
//             `);

//         if (existingItem.recordset.length > 0) {
//             // Item exists, update the quantity
//             const newQuantity = existingItem.recordset[0].Quantity + quantity;
//             await pool.request()
//                 .input('CustomerOrderID', sql.Int, customerOrderID)
//                 .input('MenuItemsID', sql.Int, menuItemsID)
//                 .input('Quantity', sql.Int, newQuantity)
//                 .query(`
//                     UPDATE CustomerOrderItems
//                     SET Quantity = @Quantity
//                     WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
//                 `);
//         } else {
//             // Item does not exist, insert as new row
//             await pool.request()
//                 .input('CustomerOrderID', sql.Int, customerOrderID)
//                 .input('MenuItemsID', sql.Int, menuItemsID)
//                 .input('Quantity', sql.Int, quantity)
//                 .query(`
//                     INSERT INTO CustomerOrderItems (CustomerOrderID, MenuItemsID, Quantity)
//                     VALUES (@CustomerOrderID, @MenuItemsID, @Quantity);
//                 `);
//         }
//         res.status(200).json({ success: true, message: 'Item added or updated successfully' });
//     } catch (error) {
//         console.error('Error adding item to order:', error);
//         res.status(500).send('Failed to add or update item in order');
//     }
// });

app.post('/api/orderItems/add', async (req, res) => {
    const { customerOrderID, menuItemsID, quantity } = req.body;
    console.log(customerOrderID,'COI')
    const pool = await sql.connect(dbConfig);

    try {
        // Check if the restaurant is open before proceeding
        const restaurantOpen = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .query(`
                SELECT r.IsOpen
                FROM CustomerOrder co
                JOIN Restaurant r ON co.RestaurantID = r.RestaurantID
                WHERE co.CustomerOrderID = @CustomerOrderID;
            `);

        if (restaurantOpen.recordset.length > 0 && restaurantOpen.recordset[0].IsOpen === 'No') {
            return res.status(400).json({ success: false, message: 'Cannot add items, restaurant is closed.' });
        }

        // Check if the item already exists in the order
        const existingItem = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .input('MenuItemsID', sql.Int, menuItemsID)
            .query(`
                SELECT Quantity
                FROM CustomerOrderItems
                WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
            `);

        if (existingItem.recordset.length > 0) {
            // Item exists, update the quantity
            const newQuantity = existingItem.recordset[0].Quantity + quantity;
            await pool.request()
                .input('CustomerOrderID', sql.Int, customerOrderID)
                .input('MenuItemsID', sql.Int, menuItemsID)
                .input('Quantity', sql.Int, newQuantity)
                .query(`
                    UPDATE CustomerOrderItems
                    SET Quantity = @Quantity
                    WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
                `);
        } else {
            // Item does not exist, insert as new row
            await pool.request()
                .input('CustomerOrderID', sql.Int, customerOrderID)
                .input('MenuItemsID', sql.Int, menuItemsID)
                .input('Quantity', sql.Int, quantity)
                .query(`
                    INSERT INTO CustomerOrderItems (CustomerOrderID, MenuItemsID, Quantity)
                    VALUES (@CustomerOrderID, @MenuItemsID, @Quantity);
                `);
        }
        res.status(200).json({ success: true, message: 'Item added or updated successfully' });
    } catch (error) {
        console.error('Error adding item to order:', error);
        res.status(500).send('Failed to add or update item in order');
    }
});



app.post('/api/orderItems/remove', async (req, res) => {
    const { customerOrderID, menuItemsID, quantity } = req.body;
    const pool = await sql.connect(dbConfig);

    try {
        // Fetch the current quantity first
        const queryResult = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .input('MenuItemsID', sql.Int, menuItemsID)
            .query(`
                SELECT Quantity FROM CustomerOrderItems
                WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
            `);

        if (queryResult.recordset.length > 0) {
            let currentQuantity = queryResult.recordset[0].Quantity;
            let newQuantity = currentQuantity - quantity;

            if (newQuantity > 0) {
                // Update the quantity since it's still more than zero
                await pool.request()
                    .input('CustomerOrderID', sql.Int, customerOrderID)
                    .input('MenuItemsID', sql.Int, menuItemsID)
                    .input('Quantity', sql.Int, newQuantity)
                    .query(`
                        UPDATE CustomerOrderItems
                        SET Quantity = @Quantity
                        WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
                    `);
            } else {
                // Delete the item since the new quantity is zero or less
                await pool.request()
                    .input('CustomerOrderID', sql.Int, customerOrderID)
                    .input('MenuItemsID', sql.Int, menuItemsID)
                    .query(`
                        DELETE FROM CustomerOrderItems
                        WHERE CustomerOrderID = @CustomerOrderID AND MenuItemsID = @MenuItemsID;
                    `);
            }
            res.status(200).json({ success: true, message: 'Item updated or removed successfully' });
        } else {
            res.status(404).send('Item not found');
        }
    } catch (error) {
        console.error('Error updating or removing item from order:', error);
        res.status(500).send('Failed to update or remove item from order');
    }
});


// Endpoint to process payment
app.post('/api/processPayment', async (req, res) => {
    const { typeOfPayment, paymentAmount, customerOrderID } = req.body;
    const pool = await sql.connect(dbConfig);

    try {
        await pool.request()
            .input('TypeOfPayment', sql.VarChar(50), typeOfPayment)
            .input('PaymentAmount', sql.Decimal(10, 2), paymentAmount)
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .input('PaymentStatus', sql.VarChar(50), 'Confirmed')
            .query(`
                INSERT INTO Payment (TypeOfPayment, PaymentAmount, PaymentStatus, CustomerOrderID)
                VALUES (@TypeOfPayment, @PaymentAmount, @PaymentStatus, @CustomerOrderID);
            `);

        res.json({ success: true, message: 'Payment processed successfully' });
    } catch (error) {
        console.error('Error processing payment:', error);
        res.status(500).send('Error processing payment');
    }
});
app.get('/api/getOrderHistory/:customerID', async (req, res) => {
    const { customerID } = req.params;
    const pool = await sql.connect(dbConfig);

    try {
        const result = await pool.request()
            .input('CustomerID', sql.Int, customerID)
            .execute('GetOrderHistory'); // Assuming the stored procedure name is GetOrderHistory

        res.json(result.recordset); // Assuming the stored procedure returns the order history as an array of objects
    } catch (error) {
        console.error('Error fetching order history:', error);
        res.status(500).send('Failed to fetch order history');
    }
});
// Endpoint to fetch order items by CustomerOrderID
app.get('/api/orderItems/:customerOrderID', async (req, res) => {
    const { customerOrderID } = req.params;
    const pool = await sql.connect(dbConfig);

    try {
        const result = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .query(`
                SELECT coi.CustomerOrderID, coi.MenuItemsID, coi.Quantity, mi.ItemName, mi.ItemDescription, mi.ItemPrice
                FROM CustomerOrderItems coi
                JOIN MenuItem mi ON coi.MenuItemsID = mi.MenuItemsID
                WHERE coi.CustomerOrderID = @CustomerOrderID;
            `);

        if (result.recordset.length > 0) {
            res.json(result.recordset);
        } else {
            res.status(404).send('No items found for this order');
        }
    } catch (error) {
        console.error('Error fetching order items:', error);
        res.status(500).send('Failed to fetch order items');
    }
});

app.get('/api/getTotalPrice/:customerOrderID', async (req, res) => {
    const { customerOrderID } = req.params;
    const pool = await sql.connect(dbConfig);

    try {
        const result = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .query(`
                SELECT TotalPrice FROM CustomerOrder WHERE CustomerOrderID = @CustomerOrderID;
            `);

        if (result.recordset.length > 0) {
            res.json({ success: true, totalPrice: result.recordset[0].TotalPrice });
        } else {
            res.status(404).send('Order not found');
        }
    } catch (error) {
        console.error('Error fetching total price:', error);
        res.status(500).send('Failed to fetch total price');
    }
});

app.get('/api/getTotalPrice/:customerOrderID', async (req, res) => {
    const { customerOrderID } = req.params;

    try {
        // Create a connection pool
        const pool = await sql.connect(dbConfig);

        // Execute the query to fetch total price for the given customer order ID
        const result = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .query(`
                SELECT TotalPrice FROM CustomerOrder WHERE CustomerOrderID = @CustomerOrderID;
            `);

        // Check if any record is found
        if (result.recordset.length > 0) {
            res.json({ success: true, totalPrice: result.recordset[0].TotalPrice });
        } else {
            res.status(404).send('Order not found');
        }
    } catch (error) {
        console.error('Error fetching total price:', error);
        res.status(500).send('Failed to fetch total price');
    }
});

app.post('/api/orders/new', async (req, res) => {
    const { customerID, restaurantID } = req.body;
    const pool = await sql.connect(dbConfig);

    try {
        const currentDate = new Date();
        const orderDate = currentDate.toISOString().slice(0, 10);
        const orderTime = currentDate.getHours().toString().padStart(2, '0') + ':' +
                          currentDate.getMinutes().toString().padStart(2, '0') + ':' +
                          currentDate.getSeconds().toString().padStart(2, '0');
        const orderStatus = 'Initiated';

        const result = await pool.request()
            .input('CustomerID', sql.Int, customerID)
            .input('RestaurantID', sql.Int, restaurantID)
            .input('OrderDate', sql.Date, orderDate)
            .input('OrderTime', sql.VarChar(8), orderTime)
            .input('OrderStatus', sql.VarChar(50), orderStatus)
            .query(`
                INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus)
                OUTPUT inserted.CustomerOrderID
                VALUES (@CustomerID, @RestaurantID, @OrderDate, @OrderTime, @OrderStatus);
            `);

        const newOrderID = result.recordset[0].CustomerOrderID;
        res.json({ success: true, customerOrderID: newOrderID });
    } catch (error) {
        console.error('Error creating new order:', error);
        res.status(500).send('Failed to create new order');
    }
});

app.get('/api/generateInvoice/:customerOrderID', async (req, res) => {
    const { customerOrderID } = req.params;
    const pool = await sql.connect(dbConfig); // Ensure consistent connection handling

    try {
        const result = await pool.request()
            .input('CustomerOrderID', sql.Int, customerOrderID)
            .execute('GenerateInvoice');  // Assuming GenerateInvoice is a stored procedure that SELECTs data
        
        if (result.recordset.length > 0) {
            res.json({ success: true, invoice: result.recordset[0] });
        } else {
            res.status(404).send('Invoice could not be generated or no data returned.');
        }
    } catch (error) {
        console.error('Error generating invoice:', error);
        res.status(500).send('Failed to generate invoice');
    }
});









// Import routes
// Here you would import and use your routes, for example:
// const orderRoutes = require('./routes/orderRoutes');
// app.use('/api/orders', orderRoutes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
