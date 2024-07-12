use OrderHub;
GO 

--Insert into Customer table 
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPassword, CustomerContactNo) VALUES 
('John', 'Doe', 'johndoe@gmail.com', 'pA5sw0rd1!', '9123456780'),
('Jane', 'Smith', 'janesmith@yahoo.com', 'S3cr3tPwd2!', '9123456765'),
('Alice', 'Johnson', 'alicejohnson@hotmail.com', 'Un1qu3P@ss3', '9123456709'),
('Bob', 'Brown', 'bobbrown@gmail.com', 'P@ssword#4', '9123456564'),
('Michael', 'Davis', 'michaeldavis@yahoo.com', 'MyPass5^55', '8573456784'),
('Linda', 'Miller', 'lindamiller@hotmail.com', 'Saf3Pwd#6', '8573456765'),
('Chris', 'Wilson', 'chriswilson@gmail.com', 'Secure7*7*', '9123456980'),
('Emma', 'Moore', 'emmamoore@yahoo.com', 'PwdE1ght8', '8523456453'),
('James', 'Taylor', 'jamestaylor@hotmail.com', 'Nin3Pass9', '9123456734'),
('Laura', 'Anderson', 'lauraanderson@gmail.com', 'PassTen_10', '8573456789'),
('David', 'Thomas', 'davidthomas@yahoo.com', 'ElevenPwd1', '8573456701'),
('Sarah', 'Jackson', 'sarahjackson@hotmail.com', 'P@ssword12', '8123456745'),
('Kevin', 'White', 'kevinwhite@gmail.com', 'Password13', '8123456704'),
('Jessica', 'Harris', 'jessicaharris@yahoo.com', 'Secr3t#14', '8153456793'),
('Daniel', 'Martin', 'danielmartin@hotmail.com', 'PwdFifteen', '8523456782'),
('Lisa', 'Thompson', 'lisathompson@gmail.com', 'Sixteen16', '8823456378'),
('Matthew', 'Garcia', 'matthewgarcia@yahoo.com', 'Seventeen7', '8123456900'),
('Nancy', 'Martinez', 'nancymartinez@hotmail.com', '18Password', '8123456123'),
('Gary', 'Robinson', 'garyrobinson@gmail.com', 'Nineteen19', '8123456367'),
('Susan', 'Clark', 'susanclark@yahoo.com', 'Passw0rd20', '8573456799'),
('Joe', 'Rodriguez', 'joerodriguez@hotmail.com', '21PassWord', '8323459028'),
('Karen', 'Lewis', 'karenlewis@gmail.com', 'P@ssword22', '8523456801'),
('Steven', 'Lee', 'stevenlee@yahoo.com', 'Password23', '8123456904'),
('Olivia', 'Walker', 'oliviawalker@hotmail.com', 'Secr3t24!', '8723456898'),
('Brian', 'Hall', 'brianhall@gmail.com', '25P@ssword', '8573456789'),
('Rachel', 'Allen', 'rachelallen@yahoo.com', 'Password26', '8123456123'),
('Edward', 'Young', 'edwardyoung@hotmail.com', '27Pass!@#', '9173456487'),
('Rebecca', 'Hernandez', 'rebeccahernandez@northeastern.edu', 'Pass282828', '9123456831'),
('Mark', 'King', 'markking@bu.edu', 'Password29', '9523456867'),
('Patricia', 'Wright', 'patriciawright@gmail.com', '30P@ssw0rd', '9523456654'),
('Charles', 'Lopez', 'charleslopez@yahoo.com', 'PassWord31', '9623456810'),
('Jennifer', 'Hill', 'jenniferhill@hotmail.com', '32Pass##90', '9223456789'),
('Joshua', 'Scott', 'joshuascott@gmail.com', 'P@ss33Word', '8123456908'),
('Betty', 'Green', 'bettygreen@yahoo.com', 'Pass34!@#$', '8123456823'),
('Gregory', 'Adams', 'gregoryadams@hotmail.com', 'WordPass35', '8123456810');



--Insert into CustomerAddress
INSERT INTO CustomerAddress (CustomerID, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode)
VALUES 
(1000, '1 Newbury St', 'Boston', 'MA', '02116'),
(1001, '10 Park Plaza', 'Boston', 'MA', '02116'),
(1002, '115 Stuart St', 'Boston', 'MA', '02116'),
(1003, '500 Boylston St', 'Boston', 'MA', '02116'),
(1004, '200 Boylston St', 'Boston', 'MA', '02116'),
(1005, '15 Arlington St', 'Boston', 'MA', '02116'),
(1006, '120 Huntington Ave', 'Boston', 'MA', '02115'),
(1007, '10 Huntington Ave', 'Boston', 'MA', '02115'),
(1008, '100 Huntington Ave', 'Boston', 'MA', '02116'),
(1009, '235 Park Drive', 'Boston', 'MA', '02135'),
(1010, '123 Beacon St', 'Brookline', 'MA', '02445'),
(1011, '456 Harvard St', 'Brookline', 'MA', '02446'),
(1012, '789 Coolidge St', 'Brookline', 'MA', '02447'),
(1013, '123 Main St', 'Brighton', 'MA', '02135'),
(1014, '456 Elm St', 'Brighton', 'MA', '02136'),
(1015, '1220 5th Ave', 'New York', 'NY', '10029'),
(1016, '236 W 135th St', 'New York', 'NY', '10030'),
(1017, '245 E 124th St', 'New York', 'NY', '10035'),
(1018, '302 E 96th St', 'New York', 'NY', '10128'),
(1019, '505 E 75th St', 'New York', 'NY', '10021'),
(1020, '420 E 23rd St', 'New York', 'NY', '10010'),
(1021, '430 W 34th St', 'New York', 'NY', '10001'),
(1022, '520 8th Ave', 'New York', 'NY', '10018'),
(1023, '750 3rd Ave', 'New York', 'NY', '10017'),
(1024, '900 7th Ave', 'New York', 'NY', '10019'),
(1025, '123 Main St', 'Jersey City', 'NJ', '07302'),
(1026, '456 Elm St', 'Hoboken', 'NJ', '07030'),
(1027, '789 Oak St', 'Newark', 'NJ', '07102'),
(1028, '1010 Maple St', 'Paterson', 'NJ', '07501'),
(1029, '1313 Pine St', 'Elizabeth', 'NJ', '07201'),
(1030, '1515 Cedar St', 'Edison', 'NJ', '08817'),
(1031, '1717 Birch St', 'Toms River', 'NJ', '08753'),
(1032, '1919 Walnut St', 'Clifton', 'NJ', '07011'),
(1033, '2121 Oakwood St', 'Camden', 'NJ', '08102'),
(1034, '2323 Pinecrest St', 'Atlantic City', 'NJ', '08401');


--Insert into Restaurant
INSERT INTO Restaurant (RestaurantName, RestaurantContactNo, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantType, IsOpen)
VALUES 
('Taste of India', '8577079129', '100 Lexington Ave', 'New York', 'NY', '10016', 'Indian', 'Yes'),
('El Patron', '9876543210', '200 Park Ave', 'New York', 'NY', '10017', 'Mexican', 'Yes'),
('La Bella Vita', '4567890123', '300 Madison Ave', 'New York', 'NY', '10018', 'Italian', 'Yes'),
('Gourmet Delight', '3216549870', '400 5th Ave', 'New York', 'NY', '10019', 'Continental', 'No'),
('Seoul Kitchen', '6543217890', '500 6th Ave', 'New York', 'NY', '10020', 'Korean', 'Yes'),
('Spice Garden', '8569082156', '100 Main St', 'Jersey City', 'NJ', '07302', 'Indian', 'Yes'),
('Taqueria Mexicana', '9127456834', '200 Elm St', 'Hoboken', 'NJ', '07030', 'Mexican', 'Yes'),
('Cucina Italiana', '9127456210', '300 Oak St', 'Newark', 'NJ', '07102', 'Italian', 'No'),
('Continental Bistro', '8577899123', '400 Maple St', 'Paterson', 'NJ', '07501', 'Continental', 'Yes'),
('Korean BBQ House', '6543217450', '500 Cedar St', 'Elizabeth', 'NJ', '07201', 'Korean', 'Yes'),
('Spice Junction', '8570982308', '100 Main St', 'Boston', 'MA', '02108', 'Indian', 'Yes'),
('Taco Town', '9876543734', '200 Elm St', 'Boston', 'MA', '02109', 'Mexican', 'No'),
('Pasta Palace', '8547890110', '300 Oak St', 'Boston', 'MA', '02110', 'Italian', 'Yes'),
('Bistro 3000', '3256549886', '400 Maple St', 'Boston', 'MA', '02111', 'Continental', 'Yes'),
('Seoul Kitchen', '6553237878', '500 Cedar St', 'Boston', 'MA', '02112', 'Korean', 'No'),
('Curry House', '3214567890', '100 Main St', 'Brookline', 'MA', '02445', 'Indian', 'Yes'),
('Taco Time', '9876543429', '200 Elm St', 'Brookline', 'MA', '02446', 'Mexican', 'Yes'),
('Pasta Perfect', '8567890183', '300 Oak St', 'Brookline', 'MA', '02447', 'Italian', 'Yes'),
('Spice Island', '6354567891', '100 Main St', 'Brighton', 'MA', '02135', 'Indian', 'No'),
('Taco Fiesta', '9876549210', '200 Elm St', 'Brighton', 'MA', '02136', 'Mexican', 'Yes');

SELECT * FROM Restaurant;

--Insert into Restaurant
INSERT INTO Menu (RestaurantID, MenuType) VALUES
(1000, 'Food'),
(1000, 'Beverages'),
(1000, 'Dessert'),
(1001, 'Food'),
(1001, 'Beverages'),
(1001, 'Dessert'),
(1002, 'Food'),
(1002, 'Beverages'),
(1002, 'Dessert'),
(1003, 'Food'),
(1003, 'Beverages'),
(1003, 'Dessert'),
(1004, 'Food'),
(1004, 'Beverages'),
(1004, 'Dessert'),
(1005, 'Food'),
(1005, 'Beverages'),
(1005, 'Dessert'),
(1006, 'Food'),
(1006, 'Beverages'),
(1006, 'Dessert'),
(1007, 'Food'),
(1007, 'Beverages'),
(1007, 'Dessert'),
(1008, 'Food'),
(1008, 'Beverages'),
(1008, 'Dessert'),
(1009, 'Food'),
(1009, 'Beverages'),
(1009, 'Dessert'),
(1010, 'Food'),
(1010, 'Beverages'),
(1010, 'Dessert'),
(1011, 'Food'),
(1011, 'Beverages'),
(1011, 'Dessert'),
(1012, 'Food'),
(1012, 'Beverages'),
(1012, 'Dessert'),
(1013, 'Food'),
(1013, 'Beverages'),
(1013, 'Dessert'),
(1014, 'Food'),
(1014, 'Beverages'),
(1014, 'Dessert'),
(1015, 'Food'),
(1015, 'Beverages'),
(1015, 'Dessert'),
(1016, 'Food'),
(1016, 'Beverages'),
(1016, 'Dessert'),
(1017, 'Food'),
(1017, 'Beverages'),
(1017, 'Dessert'),
(1018, 'Food'),
(1018, 'Beverages'),
(1018, 'Dessert'),
(1019, 'Food'),
(1019, 'Beverages'),
(1019, 'Dessert');


--Insert data for Restaurant No 1000
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES 
    (1000, 'Chicken Tikka Masala', 'Tender chicken pieces marinated in yogurt and spices, cooked in a rich tomato-based sauce.', 12.99),
    (1000, 'Paneer Butter Masala', 'Cubes of paneer cooked in a creamy tomato and butter sauce.', 10.99),
    (1000, 'Naan Bread', 'Traditional Indian bread baked in a tandoor oven.', 3.99),
    (1001, 'Mango Lassi', 'Refreshing yogurt-based drink with mango pulp and spices.', 4.49),
    (1001, 'Masala Chai', 'A traditional Indian tea made with black tea, milk, spices such as cinnamon, cardamom, and ginger.', 3.49),
    (1002, 'Gulab Jamun', 'Deep-fried dough balls soaked in sugar syrup.', 3.99),
    (1002, 'Rasmalai', 'Soft, spongy cottage cheese dumplings soaked in sweetened, thickened milk, garnished with almonds and pistachios.', 6.99);

--Insert data for Restaurant No 1001
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES 
    (1003, 'Taco', 'A traditional Mexican dish consisting of a corn or wheat tortilla folded or rolled around a filling.', 6.99),
    (1003, 'Enchiladas', 'Corn tortillas rolled around a filling and covered with a savory sauce, usually containing chili.', 8.99),
    (1003, 'Burrito', 'A flour tortilla wrapped or folded around a filling, typically made with beans, meat, cheese, and spices.', 7.49),
    (1004, 'Margarita', 'A cocktail consisting of tequila, triple sec, and lime or lemon juice, often served with salt on the rim of the glass.', 9.99),
    (1004, 'Mexican Soda', 'A carbonated soft drink often flavored with fruit extracts or natural flavors.', 2.49),
    (1005, 'Churros', 'Deep-fried dough pastry typically rolled in cinnamon sugar.', 4.99),
    (1005, 'Flan', 'A creamy caramel custard dessert with a layer of soft caramel on top.', 5.49);

--Insert data for Restaurant No 1002
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES 
    (1006, 'Margherita Pizza', 'A classic pizza topped with tomato sauce, mozzarella cheese, and fresh basil leaves.', 12.99),
    (1006, 'Spaghetti Carbonara', 'A pasta dish made with eggs, cheese, bacon (pancetta), and black pepper.', 14.99),
    (1006, 'Chicken Parmesan', 'Breaded chicken topped with marinara sauce and melted mozzarella cheese.', 16.49),
    (1007, 'Red Wine', 'A selection of red wine varieties from Italy.', 8.99),
    (1007, 'Espresso', 'A concentrated coffee beverage brewed by forcing hot water under pressure through finely-ground coffee beans.', 3.49),
    (1008, 'Tiramisu', 'A popular Italian dessert made with layers of coffee-soaked ladyfingers and mascarpone cheese.', 7.99),
    (1008, 'Cannoli', 'Tube-shaped shells of fried pastry dough filled with a sweet, creamy filling containing ricotta.', 5.49);

--Insert data for Restaurant No 1003
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES 
    (1009, 'Beef Wellington', 'Tender beef fillet wrapped in puff pastry, often served with a mushroom duxelles and a red wine sauce.', 24.99),
    (1009, 'Chicken Caesar Salad', 'Grilled chicken breast served on a bed of romaine lettuce with Caesar dressing, croutons, and Parmesan cheese.', 16.99),
    (1009, 'Salmon with Lemon Butter Sauce', 'Pan-seared salmon fillet topped with a creamy lemon butter sauce, served with steamed vegetables.', 22.49),
    (1010, 'White Wine Spritzer', 'A refreshing cocktail made with white wine, soda water, and a splash of citrus juice.', 8.49),
    (1010, 'Sparkling Water', 'Carbonated water served chilled with or without a slice of lemon or lime.', 3.99),
    (1011, 'Chocolate Lava Cake', 'A decadent chocolate cake with a gooey molten center, often served with vanilla ice cream.', 9.99),
    (1011, 'Creme Brulee', 'A rich custard topped with a layer of caramelized sugar, creating a crunchy topping.', 8.49);

--Insert data for Restaurant No 1004
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES 
    (1012, 'Bibimbap', 'A mixed rice dish served with assorted vegetables, meat (usually beef), a fried egg, and spicy sauce (gochujang).', 14.99),
    (1012, 'Bulgogi', 'Thinly sliced marinated beef or pork, grilled or stir-fried, often served with rice and lettuce wraps (ssam).', 16.99),
    (1012, 'Kimchi Jjigae', 'A spicy Korean stew made with kimchi, tofu, pork, and vegetables, often served bubbling hot.', 13.49),
    (1013, 'Soju', 'A clear, colorless distilled beverage of Korean origin, typically made from rice, wheat, or barley.', 7.99),
    (1013, 'Korean Green Tea', 'A traditional Korean tea made from roasted green tea leaves, often served hot.', 3.49),
    (1014, 'Bingsu', 'A popular Korean shaved ice dessert topped with sweetened condensed milk, fruit, and syrup.', 9.99),
    (1014, 'Hotteok', 'A sweet Korean pancake filled with brown sugar, honey, cinnamon, and chopped peanuts.', 6.49);

--Insert data for Restaurant No 1005
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1015, 'Palak Paneer', 'Paneer (Indian cottage cheese) cooked with spinach, onions, tomatoes, and spices.', 14.99),
    (1015, 'Butter Chicken', 'Tender chicken pieces cooked in a rich and creamy buttery tomato sauce.', 16.49),
    (1015, 'Chana Masala', 'Spicy chickpea curry cooked with onions, tomatoes, and a blend of Indian spices.', 12.99),
    (1016, 'Mango Lassi', 'A refreshing yogurt-based drink blended with ripe mangoes and flavored with cardamom.', 4.99),
    (1016, 'Thandai', 'A traditional Indian cold drink made with milk, almonds, spices, and saffron, usually served during festivals.', 5.49),
    (1017, 'Gulab Jamun', 'Deep-fried dumplings made of milk solids, soaked in sugar syrup and flavored with rose water.', 5.99),
    (1017, 'Kulfi', 'A rich and creamy Indian ice cream made with condensed milk, nuts, and flavored with saffron and cardamom.', 4.99);

--Insert data for Restaurant No 1006
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1018, 'Beef Burrito', 'Seasoned ground beef, beans, rice, and cheese wrapped in a flour tortilla, served with salsa and sour cream.', 11.99),
    (1018, 'Quesadillas', 'Flour tortillas filled with melted cheese and your choice of chicken, beef, or vegetables, served with salsa and guacamole.', 10.99),
    (1018, 'Guacamole and Chips', 'Freshly made guacamole served with crispy tortilla chips, perfect for dipping.', 8.99),
    (1019, 'Horchata', 'A refreshing rice milk beverage flavored with cinnamon and sweetened with sugar.', 3.49),
    (1019, 'Mexican Coke', 'A traditional Mexican cola made with cane sugar, served in a glass bottle for an authentic taste.', 2.99),
    (1020, 'Churros', 'Deep-fried dough pastry dusted with cinnamon sugar, served with chocolate dipping sauce.', 5.99),
    (1020, 'Tres Leches Cake', 'A light and airy sponge cake soaked in three types of milk (evaporated milk, condensed milk, and heavy cream), topped with whipped cream and fresh fruit.', 6.49);

--Insert data for Restaurant No 1007
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1021, 'Margherita Pizza', 'Classic pizza topped with tomato sauce, fresh mozzarella cheese, and basil leaves.', 12.99),
    (1021, 'Lasagna', 'Layers of pasta sheets, meat sauce, ricotta cheese, and mozzarella cheese, baked to perfection.', 16.99),
    (1021, 'Caprese Salad', 'Fresh salad made with tomatoes, mozzarella cheese, basil leaves, olive oil, and balsamic glaze.', 10.99),
    (1022, 'Espresso', 'Strong black coffee brewed by forcing hot water under pressure through finely-ground coffee beans.', 2.49),
    (1022, 'Limoncello', 'An Italian lemon liqueur made from the zest of Sorrento lemons, served chilled as a digestif.', 6.99),
    (1023, 'Cannoli', 'Crispy pastry tubes filled with sweetened ricotta cheese and chocolate chips, dusted with powdered sugar.', 5.49),
    (1023, 'Gelato', 'Italian-style ice cream made with milk, sugar, and flavorings such as fruit and nuts.', 4.99);

--Insert data for Restaurant No 1008
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1024, 'Chicken Caesar Salad', 'Classic salad made with romaine lettuce, grilled chicken breast, Parmesan cheese, croutons, and Caesar dressing.', 14.99),
    (1024, 'Vegetable Risotto', 'Creamy Arborio rice cooked with seasonal vegetables, Parmesan cheese, and vegetable broth.', 12.99),
    (1024, 'Eggplant Parmesan', 'Slices of breaded eggplant fried until golden, layered with marinara sauce and mozzarella cheese, then baked.', 10.49),
    (1025, 'Chardonnay', 'A dry white wine with flavors of green apple, citrus, and oak, perfect for pairing with seafood and poultry.', 9.99),
    (1025, 'Cabernet Sauvignon', 'A full-bodied red wine with notes of blackberry, plum, and spice, ideal for pairing with red meat and hearty dishes.', 11.49),
    (1026, 'Creme Brulee', 'Classic French dessert consisting of rich custard topped with caramelized sugar, served chilled.', 7.99),
    (1026, 'Chocolate Lava Cake', 'Warm chocolate cake with a gooey molten center, served with vanilla ice cream and raspberry sauce.', 8.49);

--Insert data for Restaurant No 1009
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1027, 'Kimchi Jjigae', 'Spicy stew made with fermented kimchi, pork, tofu, and vegetables, served with rice.', 12.99),
    (1027, 'Japchae', 'Stir-fried glass noodles with vegetables, beef, and mushrooms, seasoned with soy sauce and sesame oil.', 13.49),
    (1027, 'Tteokbokki', 'Spicy rice cakes stir-fried with fish cakes and scallions in a sweet and spicy sauce.', 10.99),
    (1028, 'Makgeolli', 'Cloudy rice wine with a slightly sweet and tangy flavor, often served in a bowl with a wooden ladle.', 7.49),
    (1028, 'Yuzu Tea', 'Hot tea made from yuzu fruit and honey, known for its refreshing citrus flavor and health benefits.', 5.99),
    (1029, 'Hotteok', 'Sweet Korean pancake filled with brown sugar, honey, chopped peanuts, and cinnamon, pan-fried until crispy.', 6.49),
    (1029, 'Bungeoppang', 'Fish-shaped pastry filled with sweet red bean paste, often enjoyed as a street food snack.', 4.99);

--Insert data for Restaurant No 1010
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1030, 'Paneer Tikka', 'Marinated cubes of paneer cheese grilled with bell peppers, onions, and tomatoes, served with mint chutney.', 14.49),
    (1030, 'Butter Chicken', 'Boneless chicken simmered in a rich and creamy sauce made with butter, tomatoes, and spices.', 16.99),
    (1030, 'Vegetable Biryani', 'Fragrant basmati rice cooked with mixed vegetables, aromatic spices, and saffron, served with raita.', 13.49),
    (1031, 'Mango Lassi', 'Refreshing yogurt-based drink blended with ripe mangoes, sugar, and a hint of cardamom.', 4.99),
    (1031, 'Saffron Rose Lassi', 'Lassi made with yogurt, saffron, rose water, and a touch of honey, garnished with pistachios.', 5.49),
    (1032, 'Gajar Halwa', 'A sweet dessert made with grated carrots cooked in ghee, milk, sugar, and flavored with cardamom and nuts.', 6.49),
    (1032, 'Jalebi', 'Deep-fried pretzel-shaped dough soaked in sugar syrup, often served warm and crispy.', 5.99);

--Insert data for Restaurant No 1011
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1033, 'Tacos al Pastor', 'Marinated pork cooked on a vertical spit, served in corn tortillas with pineapple, onions, and cilantro.', 10.99),
    (1033, 'Chicken Quesadillas', 'Grilled flour tortillas filled with seasoned chicken, cheese, onions, and peppers, served with salsa and sour cream.', 9.49),
    (1033, 'Enchiladas Verdes', 'Corn tortillas filled with shredded chicken, topped with green tomatillo sauce, cheese, and sour cream, served with rice and beans.', 11.49),
    (1034, 'Classic Margarita', 'Tequila, triple sec, lime juice, and simple syrup, served over ice with a salted rim.', 8.99),
    (1034, 'Horchata', 'A sweet, creamy rice milk drink flavored with cinnamon, vanilla, and sugar, served over ice.', 4.49),
    (1035, 'Churros', 'Deep-fried pastry dough dusted with cinnamon sugar, served with chocolate dipping sauce.', 5.99),
    (1035, 'Tres Leches Cake', 'Sponge cake soaked in three types of milk (evaporated milk, condensed milk, and heavy cream), topped with whipped cream and strawberries.', 6.49);

--Insert data for Restaurant No 1012
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1036, 'Pepperoni Pizza', 'Classic pizza topped with tomato sauce, mozzarella cheese, and slices of pepperoni.', 13.99),
    (1036, 'Margarita Pizza', 'Italian pizza topped with tomato sauce, fresh mozzarella cheese, sliced tomatoes, fresh basil leaves, and a drizzle of olive oil.', 14.99),
    (1036, 'Four Cheese Pizza', 'Delicious pizza topped with a blend of four cheeses: mozzarella, Parmesan, Gorgonzola, and fontina.', 15.99),
    (1037, 'Chianti', 'A dry red wine from Tuscany, Italy, with flavors of cherries, plums, and spices.', 24.99),
    (1037, 'Pinot Grigio', 'A crisp and refreshing white wine with citrus and pear flavors, perfect for pairing with seafood dishes.', 22.99),
    (1038, 'Tiramisu', 'A classic Italian dessert made with layers of coffee-soaked ladyfingers, mascarpone cheese, cocoa powder, and a hint of liqueur.', 7.99),
    (1038, 'Gelato', 'Italian-style ice cream made with milk, sugar, and various flavors such as chocolate, vanilla, and pistachio.', 5.99);


--Insert data for Restaurant No 1013
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1039, 'Grilled Salmon', 'Fresh salmon fillet seasoned with herbs and spices, grilled to perfection, served with steamed vegetables and lemon butter sauce.', 18.99),
    (1039, 'Vegetable Risotto', 'Creamy risotto cooked with Arborio rice, mixed vegetables, Parmesan cheese, and vegetable broth, finished with a drizzle of truffle oil.', 16.99),
    (1039, 'Pasta Primavera', 'Penne pasta tossed with seasonal vegetables, garlic, olive oil, and Parmesan cheese, served with garlic bread.', 13.99),
    (1040, 'Cabernet Sauvignon', 'A full-bodied red wine with rich flavors of blackcurrant, plum, and vanilla, ideal for pairing with red meat dishes.', 24.99),
    (1040, 'Mojito', 'A refreshing cocktail made with white rum, fresh mint leaves, lime juice, sugar, and soda water, served over ice.', 10.99),
    (1041, 'Apple Pie', 'Homemade apple pie with a flaky crust, filled with cinnamon-spiced apples and served warm with a scoop of vanilla ice cream.', 8.49),
    (1041, 'Cheesecake', 'Creamy New York-style cheesecake on a graham cracker crust, topped with your choice of strawberry, blueberry, or cherry compote.', 9.99);

--Insert data for Restaurant No 1014
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1042, 'Kimchi Fried Rice', 'Fried rice cooked with spicy kimchi, pork, vegetables, and gochujang sauce, topped with a fried egg.', 11.99),
    (1042, 'Dakgalbi', 'Spicy stir-fried chicken marinated in a gochujang-based sauce with vegetables, often served with rice or noodles.', 14.99),
    (1042, 'Korean BBQ Ribs', 'Grilled marinated pork or beef ribs coated in a savory and slightly sweet sauce, served with steamed rice and kimchi.', 17.99),
    (1043, 'Yuzu Ade', 'Refreshing Korean citrus drink made with yuzu fruit juice, soda water, and a hint of sweetness, served over ice.', 5.99),
    (1043, 'Sikhye', 'Sweet Korean rice beverage flavored with malt, ginger, and pine nuts, served cold as a traditional dessert drink.', 4.99),
    (1044, 'Hoddeok Ice Cream Sandwich', 'Warm Korean sweet pancakes filled with vanilla ice cream, creating a delicious contrast of hot and cold.', 8.49),
    (1044, 'Injeolmi Bingsu', 'Korean shaved ice dessert topped with chewy rice cake pieces (injeolmi), sweet red bean paste, and condensed milk.', 11.49);

--Insert data for Restaurant No 1015
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1045, 'Palak Paneer', 'Creamy spinach curry with cubes of paneer, flavored with Indian spices like cumin, coriander, and garam masala.', 13.99),
    (1045, 'Chicken Biryani', 'Fragrant Indian rice dish cooked with marinated chicken, aromatic spices, and herbs, served with raita (yogurt sauce).', 16.99),
    (1045, 'Butter Chicken', 'Tender pieces of chicken cooked in a rich and creamy tomato-based sauce, flavored with butter, cream, and Indian spices.', 15.49),
    (1046, 'Mango Lassi', 'Traditional Indian yogurt-based drink blended with ripe mango pulp, sugar, and a touch of cardamom, served chilled.', 4.99),
    (1046, 'Masala Chai', 'Spiced Indian tea made with black tea leaves, milk, sugar, and a blend of aromatic spices like cardamom, cinnamon, and ginger.', 3.99),
    (1047, 'Gulab Jamun', 'Soft and spongy Indian milk solids (khoya) dumplings soaked in a sweet syrup flavored with rose water, saffron, and cardamom.', 7.99),
    (1047, 'Rasmalai', 'Creamy Indian dessert made with soft paneer (cottage cheese) dumplings soaked in sweetened, thickened milk flavored with saffron and nuts.', 8.49);

--Insert data for Restaurant No 1016
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1048, 'Chiles Rellenos', 'Poblano peppers stuffed with cheese, dipped in egg batter, fried until golden, and served with tomato salsa.', 10.99),
    (1048, 'Carne Asada', 'Grilled marinated beef steak served with rice, beans, guacamole, pico de gallo, and warm tortillas.', 15.99),
    (1048, 'Mole Poblano', 'Chicken smothered in a rich, complex sauce made with chocolate, chilies, nuts, seeds, and spices.', 14.49),
    (1049, 'Margarita', 'Classic Mexican cocktail made with tequila, lime juice, and triple sec, served in a salt-rimmed glass over ice.', 8.99),
    (1049, 'Horchata', 'Traditional Mexican rice milk beverage flavored with cinnamon, vanilla, and sweetened with sugar, served over ice.', 4.49),
    (1050, 'Tres Leches Cake', 'Light and airy sponge cake soaked in a mixture of three milks (evaporated milk, condensed milk, and heavy cream), topped with whipped cream.', 7.99),
    (1050, 'Churros', 'Crispy fried dough pastry sprinkled with cinnamon sugar, often served with chocolate sauce or dulce de leche for dipping.', 6.49);

--Insert data for Restaurant No 1017
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1051, 'Margherita Pizza', 'Classic Italian pizza topped with tomato sauce, fresh mozzarella cheese, basil leaves, and a drizzle of olive oil.', 10.99),
    (1051, 'Spaghetti Carbonara', 'Pasta dish made with spaghetti, eggs, pancetta, Parmesan cheese, and black pepper, creating a creamy and flavorful sauce.', 12.99),
    (1051, 'Risotto ai Funghi', 'Creamy Italian rice dish cooked with mushrooms, onions, garlic, white wine, Parmesan cheese, and fresh herbs.', 14.49),
    (1052, 'Prosecco', 'Italian sparkling wine made from Glera grapes, with fruity and floral notes, perfect for toasting or pairing with appetizers.', 9.99),
    (1052, 'Negroni', 'Classic Italian cocktail made with equal parts gin, Campari, and sweet vermouth, served over ice with an orange peel garnish.', 11.49),
    (1053, 'Tiramisu', 'Classic Italian dessert made with layers of coffee-soaked ladyfingers, mascarpone cheese, cocoa powder, and a hint of liqueur.', 7.99),
    (1053, 'Cannoli', 'Italian pastry tube filled with sweet ricotta cheese and chocolate chips, often dipped in pistachios or candied fruit.', 6.49);

--Insert data for Restaurant No 1018
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1054, 'Pav Bhaji', 'Spicy mixed vegetable curry (bhaji) served with buttered bread rolls (pav), garnished with onions, cilantro, and lemon wedges.', 10.49),
    (1054, 'Aloo Gobi', 'Classic Indian curry made with potatoes (aloo) and cauliflower (gobi), cooked with onions, tomatoes, and Indian spices.', 12.99),
    (1054, 'Fish Curry', 'Flavorful Indian curry made with tender fish fillets simmered in a spicy and tangy sauce with coconut milk and curry leaves.', 15.99),
    (1055, 'Mint Mojito', 'Refreshing mocktail made with fresh mint leaves, lime juice, sugar, and soda water, served over ice with a sprig of mint.', 6.49),
    (1055, 'Rose Falooda', 'Indian dessert beverage made with rose syrup, vermicelli, basil seeds, milk, and ice cream, garnished with nuts and cherries.', 7.49),
    (1056, 'Jalebi', 'Crispy and syrupy Indian sweet made by deep-frying batter in pretzel or circular shapes, soaked in sugar syrup, often served warm.', 6.99),
    (1056, 'Kaju Katli', 'Traditional Indian sweet made with cashew nuts, sugar, and ghee, shaped into diamond-shaped pieces, perfect for gifting and celebrations.', 9.99);

--Insert data for Restaurant No 1019
INSERT INTO MenuItem (MenuID, ItemName, ItemDescription, ItemPrice) VALUES
    (1057, 'Enchiladas Suizas', 'Corn tortillas rolled and stuffed with chicken, covered in a creamy tomatillo sauce and melted cheese, served with rice and beans.', 12.99),
    (1057, 'Tacos al Pastor', 'Soft corn tortillas filled with marinated and spit-roasted pork, pineapple, onions, and cilantro, served with salsa and lime wedges.', 14.49),
    (1057, 'Chiles Rellenos', 'Poblano peppers stuffed with cheese, battered, and fried until crispy, served with salsa roja, rice, and beans.', 13.99),
    (1058, 'Horchata', 'Sweet rice milk flavored with cinnamon and vanilla, served over ice.', 3.99),
    (1058, 'Jamaica Agua Fresca', 'Refreshing drink made from hibiscus flowers, water, and sugar, served over ice with a splash of lime juice.', 3.49),
    (1059, 'Churros con Chocolate', 'Golden fried pastry dough dusted with cinnamon sugar, served with a side of rich chocolate dipping sauce.', 7.99),
    (1059, 'Tres Leches Cake', 'Sponge cake soaked in three kinds of milk (evaporated milk, condensed milk, and heavy cream), topped with whipped cream and fresh berries.', 8.49);


--Insert into DeliveryExecutive
INSERT INTO DeliveryExecutive (DeliveryExecutiveName, DeliveryExecutiveContactNo) VALUES
('John Smith', '5551001234'),
('Sarah Johnson', '5552005678'),
('Michael Brown', '8573009101'),
('Emma Wilson', '5784001213'),
('Olivia Garcia', '5555001415'),
('James Rodriguez', '5556001617'),
('Isabella Martinez', '5557001819'),
('William Hernandez', '5558002021'),
('Sophia Lee', '5559002223'),
('Benjamin Davis', '5551002425'),
('Charlotte Wilson', '5552002627'),
('Liam Thompson', '5553002829'),
('Amelia Brown', '5554003031'),
('Ethan Anderson', '5555003233'),
('Mia Martinez', '5556003435'),
('Lucas White', '5557003637'),
('Evelyn Johnson', '5558003839'),
('Mason Lee', '5559004041'),
('Harper Gonzalez', '5551004243'),
('Alexander Young', '5552004445');


--Insert into CustomerSupportExecutive
INSERT INTO CustomerSupportExecutive (ExecutiveFirstName, ExecutiveLastName) VALUES
('John', 'Smith'),
('Jane', 'Doe'),
('Michael', 'Johnson'),
('Emily', 'Davis'),
('Christopher', 'Brown'),
('Jessica', 'Wilson'),
('Joshua', 'Miller'),
('Amanda', 'Taylor'),
('Daniel', 'Anderson'),
('Sarah', 'Thomas'),
('David', 'Moore'),
('Ashley', 'Martin'),
('James', 'Thompson'),
('Nicole', 'White'),
('Justin', 'Harris'),
('Sophia', 'Clark'),
('Ryan', 'Lewis'),
('Samantha', 'Robinson'),
('Andrew', 'Walker'),
('Brittany', 'Perez');


--Insert data into Customer Order
INSERT INTO CustomerOrder (CustomerID, RestaurantID, OrderDate, OrderTime, OrderStatus, PickupTime, DeliveryTime, Comments, DeliveryExecutiveID)
VALUES
    (1000, 1010, '2024-04-03', '12:00:00', 'Delivered', '12:15:00', '12:35:00', 'No special comments', 1000),
    (1001, 1010, '2024-04-03', '12:30:00', 'Delivered', '12:45:00', '13:00:00', 'Extra spicy, no onions', 1001),
    (1002, 1012, '2024-04-03', '13:00:00', 'Delivered', '13:15:00', '13:30:00', 'Gluten-free, lactose intolerant', 1002),
    (1003, 1013, '2024-04-03', '13:30:00', 'PDelivered', '13:45:00', '14:08:00', 'Extra napkins, please', 1003),
    (1004, 1015, '2024-04-03', '14:00:00', 'Delivered', '14:15:00', '14:36:00', 'Contactless delivery preferred', 1004),
    (1005, 1015, '2024-04-03', '14:30:00', 'Delivered', '14:45:00', '15:00:00', 'No cutlery needed', 1005),
    (1006, 1016, '2024-04-04', '15:00:00', 'Delivered', '15:15:00', '15:42:00', 'Spicy food warning', 1006),
    (1007, 1017, '2024-04-04', '15:30:00', 'Delivered', '15:45:00', '16:07:00', 'Delivery instructions: knock loudly', 1007),
    (1008, 1019, '2024-04-04', '16:00:00', 'Delivered', '16:15:00', '16:35:00', 'Please handle with care', 1008),
    (1009, 1019, '2024-04-04', '16:30:00', 'Delivered', '16:45:00', '17:00:00', 'Delivery address: Apartment 5B', 1009),
    (1010, 1017, '2024-04-04', '17:00:00', 'Delivered', '17:15:00', '17:45:00', 'Order for office meeting', 1010),
    (1011, 1012, '2024-04-04', '17:30:00', 'Delivered', '17:45:00', '18:00:00', 'Contact customer before delivery', 1011),
    (1012, 1013, '2024-04-05', '18:00:00', 'Delivered', '18:15:00', '18:39:00', 'Change for $50 bill required', 1012),
    (1013, 1014, '2024-04-05', '18:30:00', 'Delivered', '18:45:00', '19:00:00', 'Special request: extra sauce', 1013),
    (1014, 1016, '2024-04-05', '19:00:00', 'Delivered', '19:15:00', '19:30:00', 'Handle with care', 1014),
    (1015, 1000, '2024-04-05', '19:30:00', 'Delivered', '19:45:00', '20:00:00', 'Customer prefers spicy food', 1015),
    (1016, 1001, '2024-04-05', '20:00:00', 'Delivered', '20:15:00', '20:38:00', 'Please deliver to back entrance', 1016),
    (1017, 1002, '2024-04-05', '20:30:00', 'Delivered', '20:45:00', '21:32:00', 'Order for birthday celebration', 1017),
    (1018, 1004, '2024-04-05', '21:00:00', 'Delivered', '21:15:00', '21:30:00', 'Special instructions: vegetarian', 1018), 
    (1019, 1000, '2024-04-05', '21:30:00', 'Delivered', '21:45:00', '22:00:00', 'Delivery at doorstep', 1019),
    (1020, 1001, '2024-04-06', '12:00:00', 'Delivered', '12:15:00', '12:30:00', 'No special comments', 1000),
    (1021, 1001, '2024-04-06', '12:30:00', 'Delivered', '12:45:00', '13:10:00', 'Extra spicy, no onions', 1001), 
    (1022, 1002, '2024-04-06', '13:00:00', 'Delivered', '13:15:00', '13:40:00', 'Gluten-free, lactose intolerant', 1002),
    (1023, 1000, '2024-04-06', '13:30:00', 'Delivered', '13:45:00', '14:00:00', 'Extra napkins, please', 1018),
    (1024, 1004, '2024-04-06', '14:00:00', 'Delivered', '14:15:00', '14:30:00', 'Contactless delivery preferred', 1004),   
    (1025, 1005, '2024-04-06', '14:30:00', 'Delivered', '14:45:00', '15:00:00', 'No cutlery needed', 1005),   
    (1026, 1006, '2024-04-06', '15:00:00', 'Delivered', '15:15:00', '15:30:00', 'Spicy food warning', 1006),   
    (1027, 1008, '2024-04-06', '15:30:00', 'Delivered','15:45:00', '16:00:00', 'Delivery instructions: knock loudly', 1007),
    (1028, 1009, '2024-04-07', '16:00:00', 'Delivered', '16:15:00', '16:50:00', 'Please handle with care', 1005),   
    (1029, 1005, '2024-04-07', '16:30:00', 'Preparing', '16:45:00', NULL, 'Delivery address: Apartment 5B', 1009),  
    (1030, 1006, '2024-04-07', '17:00:00', 'On The Way', '17:15:00', NULL, 'Order for office meeting', 1013),   
    (1031, 1008, '2024-04-07', '17:30:00', 'Delivered', '17:45:00', '18:00:00', 'Contact customer before delivery', 1011), 
    (1032, 1009, '2024-04-07', '18:00:00', 'Preparing', '18:15:00', NULL, 'Change for $50 bill required', 1017), 
    (1033, 1006, '2024-04-08', '18:30:00', 'On The Way', '18:45:00', NULL, 'Special request: extra sauce', 1013),   
    (1034, 1008, '2024-04-08', '19:00:00', 'Delivered', '19:15:00', '19:30:00', 'Handle with care', 1014),
    (1000, 1010, '2024-04-08', '12:00:00', 'Preparing', '12:15:00', NULL, 'No special comments', 1004),
    (1005, 1012, '2024-04-08', '12:00:00', 'Delivered', '12:15:00', '12:36:00', 'No special comments', 1006);



--Insert data for CustomerOrderSupport
INSERT INTO CustomerOrderSupport (CustomerSupportExecutiveID, CustomerOrderID, ComplaintStatus)
VALUES
    (1000, 1003, 'Resolved'),
    (1001, 1004, 'Resolved'),
    (1002, 1030, 'Resolved'),
    (1003, 1021, 'Resolved'),
    (1004, 1022, 'Resolved'),
    (1005, 1010, 'Resolved'),
    (1006, 1009, 'Resolved'),
    (1007, 1020, 'Resolved'),
    (1008, 1002, 'Resolved'),
    (1009, 1005, 'Resolved'),
    (1010, 1007, 'Pending'),
    (1011, 1013, 'In Progress'),
    (1012, 1018, 'Resolved'),
    (1013, 1033, 'Resolved'),
    (1014, 1017, 'Pending'),
    (1015, 1015, 'In Progress'),
    (1016, 1006, 'Pending'),
    (1017, 1008, 'Resolved'),
    (1018, 1011, 'Resolved'),
    (1019, 1029, 'In Progress'),
    (1000, 1027, 'Resolved'),
    (1001, 1024, 'Resolved'),
    (1002, 1032, 'Resolved'),
    (1003, 1012, 'In Progress'),
    (1004, 1016, 'Pending'),
    (1005, 1023, 'Resolved');


--Insert into Payment
INSERT INTO Payment (TypeOfPayment, PaymentStatus, CustomerOrderID)
VALUES
    ('Credit Card', 'Paid', 1000),
    ('Cash',  'Paid', 1001),
    ('PayPal', 'Paid', 1002),
    ('Debit Card', 'Paid', 1003),
    ('Cash', 'Paid', 1004),
    ('Credit Card', 'Paid', 1005),
    ('PayPal', 'Paid', 1006),
    ('Cash', 'Paid', 1007),
    ('Debit Card', 'Paid', 1008),
    ('Credit Card', 'Paid', 1009),
    ('PayPal', 'Paid', 1010),
    ('Cash', 'Paid', 1011),
    ('Debit Card', 'Paid', 1012),
    ('Credit Card', 'Paid', 1013),
    ('PayPal', 'Paid', 1014),
    ('Cash',  'Paid', 1015),
    ('Debit Card', 'Paid', 1016),
    ('Credit Card',  'Paid', 1017),
    ('PayPal',  'Paid', 1018),
    ('Cash', 'Paid', 1019),
    ('Debit Card', 'Paid', 1020),
    ('Credit Card', 'Paid', 1021),
    ('PayPal', 'Paid', 1022),
    ('Cash', 'Paid', 1023),
    ('Debit Card', 'Paid', 1024),
    ('Credit Card', 'Paid', 1025),
    ('PayPal', 'Paid', 1026),
    ('Cash', 'Paid', 1027),
    ('Debit Card', 'Paid', 1028),
    ('Credit Card', 'Pending', 1029),
    ('PayPal', 'Pending', 1030),
    ('Cash',  'Paid', 1031),
    ('Debit Card',  'Pending', 1032),
    ('Credit Card', 'Pending', 1033),
    ('PayPal', 'Paid', 1034),
    ('Credit Card', 'Pending', 1000),
    ('PayPal', 'Paid', 1005);

SELECT * FROM Payment;


--Insert into Review
INSERT INTO Review (ReviewDescription, Rating, CustomerOrderID)
VALUES
    ('Excellent service and delicious food!', 5, 1000),
    ('The food was good, but delivery took longer than expected.', 3, 1002),
    ('Highly disappointed with the quality of the food.', 2, 1004),
    ('Great experience overall.', 4, 1005),
    ('The delivery was fast and the food was fresh.', 5, 1007),
    ('Food arrived cold and tasted stale.', 2, 1008),
    ('Average food quality, but timely delivery.', 3, 1009),
    ('Delicious food and excellent service!', 5, 1011),
    ('Food was not as described on the menu.', 2, 1013),
    ('Prompt delivery and tasty food.', 4, 1014),
    ('The order was messed up and delivery took forever.', 1, 1016),
    ('Exceptional service and amazing food!', 5, 1017),
    ('Food quality was disappointing.', 2, 1018),
    ('The delivery executive was rude and the food was cold.', 1, 1020),
    ('The food was okay, nothing special.', 3, 1021),
    ('Fast delivery but food quality needs improvement.', 3, 1025),
    ('Best food ever!', 5, 1026),
    ('Food was late and cold.', 2, 1028),
    ('The worst experience ever! Will never order again.', 1, 1031),
    ('Fantastic food and excellent service!', 5, 1034);



--Insert data into CustomerOrderItems
INSERT INTO CustomerOrderItems (MenuItemsID, CustomerOrderID, Quantity)
VALUES
    (1071, 1000, 1),
    (1074, 1000, 2),
    (1073, 1001, 1),
    (1085, 1002, 2),
    (1092, 1003, 1),
    (1106, 1004, 1),
    (1110, 1004, 1),
    (1107, 1005, 1),
    (1112, 1006, 2),
    (1115, 1006, 1),
    (1120, 1007, 2),
    (1133, 1008, 1),
    (1136, 1008, 1),
    (1134, 1009, 3),
    (1120, 1010, 1),
    (1121, 1010, 1),
    (1085, 1011, 2),
    (1093, 1012, 2),
    (1095, 1012, 1),
    (1099, 1013, 1),
    (1113, 1014, 3),
    (1001, 1015, 2),
    (1010, 1016, 2),
    (1115, 1017, 1),
    (1028, 1018, 3),
    (1030, 1018, 1),
    (1004, 1019, 2),  
    (1008, 1020, 2),
    (1009, 1021, 1),
    (1016, 1022, 3),
    (1003, 1023, 2),
    (1029, 1024, 2),
    (1036, 1025, 1),
    (1043, 1026, 3),   
    (1057, 1027, 2),
    (1060, 1027, 1),  
    (1064, 1028, 2),
    (1035, 1029, 1),
    (1036, 1029, 1),   
    (1044, 1030, 2), 
    (1057, 1031, 3),
    (1064, 1032, 2),
    (1044, 1033, 2),
    (1056, 1034, 1),
    (1061, 1034, 1);
