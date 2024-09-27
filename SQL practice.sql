CREATE DATABASE sqlPractice;
USE sqlPractice;

CREATE TABLE booking_table(
Booking_id VARCHAR(3) NOT NULL,
Booking_date date NOT NULL,
User_id VARCHAR(5) NOT NULL,
Line_of_business VARCHAR(6) NOT NULL );

INSERT INTO booking_table 
VALUES
("b1", '2024-03-01', "u1", "Flight"),
("b2", '2024-03-02', "u2", "Flight"),
("b3", '2024-03-03', "u3", "Flight"),
("b4", '2024-03-04', "u4", "Hotel"),
("b5", '2024-03-05', "u5", "Flight"),
("b6", '2024-03-06', "u6", "Hotel"),
("b7", '2024-03-07', "u7", "Flight"),
("b8", '2024-03-08', "u8", "Flight"),
("b9", '2024-03-09', "u9", "Hotel"),
("b10", '2024-03-10', "u4","Flight"),
("b11", '2024-03-11', "u8", "Hotel"),
("b12", '2024-03-12', "u2", "Hotel"),
("b13", '2024-03-13', "u3", "Flight"),
("b14", '2024-03-14', "u3", "Hotel"),
("b15", '2024-03-15', "u5", "Flight"),
("b16", '2024-03-16', "u5", "Flight"),
("b17", '2024-03-17', "u7", "Hotel"),
("b18", '2024-03-18', "u8", "Flight"),
("b19", '2024-03-19', "u9", "Hotel"),
("b20", '2024-03-20', "u9", "Flight");

SELECT *
FROM booking_table;

CREATE TABLE User_table(
User_id VARCHAR(3) NOT NULL,
Segment VARCHAR(3) NOT NULL);

INSERT INTO User_table 
VALUES 
("u1", "s1"),
("u2", "s1"),
("u3", "s1"),
("u4", "s2"),
("u5", "s2"),
("u6", "s3"),
("u7", "s3"),
("u8", "s3"),
("u9", "s3"),
("u10", "s3");

/* Q1: Create the Table */
SELECT u.segment, count(distinct u.user_id) as no_of_users,
count(distinct case when b.line_of_business = 'Flight' then b.User_id end) as user_who_booked_flight
FROM User_table as u
left join booking_table as b on u.User_id= b.User_id
group by u.segment;


/* Q3: Write a query to identify users whose first booking was a hotel booking */
 SELECT * from (
 select *
 , rank() over (partition by user_id order by booking_date) as rn
 FROM booking_table) as a
 where rn = 1 and Line_of_business = 'Hotel';

 select * from(
 select *
 , first_value(Line_of_business) over (partition by user_id order by booking_date) as first_booking
 FROM booking_table) as a
 where first_booking = 'Hotel';
 
 
  /* Q3: Write a query to calculate the days between first and last booking of each user*/
 select user_id, min(booking_date), max(booking_date),
 datediff(max(booking_date),min(booking_date)) as no_of_days
 from booking_table
 group by user_id;
 
 
  /* Q4: Write a query to count the number of flight and hotel bookings in each of the user segment*/
 select segment
 , sum(case when Line_of_business= 'Flight' then 1 else 0 end) as flight_booking
  , sum(case when Line_of_business= 'Hotel' then 1 else 0 end) as hotel_booking
   from booking_table as b
 inner join user_table as u on b.User_id = u.User_id
 group by segment
 
 
 
 
 
 
 
 
 
 
 
 
 
 
