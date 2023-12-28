CREATE DATABASE AIR_CARGO ;
USE AIR_CARGO ;
-- QUESTION 1
-- (1).Write a query to create route_details table using suitable data types for the fields, such as route_id, flight_num,
 -- origin_airport,destination_airport, aircraft_id, and distance_miles. 
-- Implement the check constraint for the flight number and unique constraint for the route_id fields. 
-- Also, make sure that the distance miles field is greater than 0
CREATE TABLE ROUTE_DETAILS(ROUTE_ID INT UNIQUE,FLIGHT_NUM INT,ORIGIN_AIRPORT VARCHAR(10),
DESTINATION_AIRPORT VARCHAR(10),AIRCRAFT_ID VARCHAR(20),DISTANCE_MILES INT,CONSTRAINT FL_NUM CHECK(FLIGHT_NUM !=0),
CONSTRAINT DISMILE_CHK CHECK(DISTANCE_MILES>0));
DESC ROUTE_DETAILS;
-- QUESTION 2
-- (2).Write a query to display all the passengers (customers) who have travelled in routes 01 to 25.
-- Take data from the passengers_on_flights table
SELECT * FROM passengers_on_flights  WHERE ROUTE_ID BETWEEN 01 AND 25;
-- QUESTION 3
-- (3).Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
 SELECT COUNT(CUSTOMER_ID) AS NO_OF_PASSENGER, CLASS_ID,SUM(PRICE_PER_TICKET) AS TOTAL_REVENUE FROM ticket_details WHERE CLASS_ID='BUSSINESS' GROUP BY CLASS_ID; 
-- QUESTION 4
-- (4).Write a query to display the full name of the customer by extracting the first name and last name from the CUSTOMER TABLE.
SELECT * FROM CUSTOMER;
SELECT CONCAT(FIRST_NAME,'  ',LAST_NAME) AS FULL_NAME FROM CUSTOMER;
-- QUESTION 5
-- (5).Write a query to extract the customers who have registered and booked a ticket. 
-- Use data from the customer and ticket_details tables.
SELECT C.* FROM CUSTOMER C JOIN TICKET_DETAILS T ON C.CUSTOMER_ID = T.CUSTOMER_ID ORDER BY CUSTOMER_ID;
-- (6).Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) 
-- from the ticket_details table.
SELECT C.CUSTOMER_id,C.FIRST_NAME,C.LAST_NAME,TD.brand FROM CUSTOMER C JOIN ticket_details TD ON C.CUSTOMER_ID=TD.customer_id ORDER BY C.customer_id;
-- (7).	Write a query to identify the customers who have travelled by Economy Plus class using Group By 
-- and Having clause on the passengers_on_flights table.
SELECT COUNT(customer_id) AS Total_Customers FROM passengers_on_flights GROUP BY class_id HAVING class_id="Economy Plus";
	
-- SELECT FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE CUSTOMER_ID 
     --  IN (SELECT CUSTOMER_ID FROM PASSENGERS_ON_FLIGHTS WHERE CLASS_ID = 'Economy Plus' GROUP BY CUSTOMER_ID HAVING COUNT(CLASS_ID) <= 2);
-- (8). Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.
SELECT IF (SUM(PRICE_PER_TICKET)>10000,'REVENUE CROSSED 10000','REVENUE IS LOWER THAN 10000') AS REVENUE FROM ticket_details;

-- 9. Write a query to create and grant access to a new user to perform operations on a database.
USE `air_cargo`;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';

-- (10). Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.
SELECT class_id,MAX(PRICE_PER_TICKET) MAX_TICKET_PRICE FROM TICKET_DETAILS group by CLASS_ID ORDER BY MAX_TICKET_PRICE; 

-- 11. Write a query to extract the passengers whose route ID is 4 by improving the speed and performance 
-- of the passengers_on_flights table.
CREATE INDEX ROUTEID_INX ON passengers_on_flights(ROUTE_ID);
SELECT * FROM passengers_on_flights WHERE ROUTE_ID=4;

-- 12.	 For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.
 SELECT * FROM `passengers_on_flights` WHERE route_id=4;

 -- (13).Write a query to create a view with only business class customers along with the brand of airlines.
CREATE VIEW Bussiness_Class AS
SELECT customer_id,brand FROM `ticket_details` WHERE class_id='Bussiness';
SELECT * FROM Bussiness_Class;
