-- CREATING DATABASES:
CREATE DATABASE udemy;
CREATE DATABASE testing;
-- ----------------------------------------
-- DELETING DATABASES:
DROP DATABASE testing;
-- ---------------------------------------
-- USING DATABASES:
USE udemy;
SELECT DATABASE();-- tells you which database is being used
-- ---------------------------------------
-- CREATING A TABLE:
CREATE TABLE tweets (
    username VARCHAR(15),
    tweet_content VARCHAR(140),
    number_favorites INT
);

SHOW TABLES; -- showing all tables:
SHOW COLUMNS FROM tweets; -- show all columns and datatypes in a table
DESC tweets; -- same as above him

-- deleting a table:
DROP TABLE tweets;

-- --------------------------------------------
CREATE TABLE cats (
    name VARCHAR(40),
    age INT
);

-- ----------------------------------------------
-- INSERTING DATA INTO TABLE:
INSERT INTO cats(name, age)
VALUES
(
	"Blue", 1
);

INSERT INTO cats(age, name)
VALUES
(
	11, "Draco"
);

SELECT 
    *
FROM
    cats; -- how to show data in a table

-- inserting multiple values into table:
INSERT INTO cats
VALUES
("Charlie", 10), ("Sadie", 2), ("Peanut", 4);

SELECT 
    *
FROM
    cats;
-- -------------------------------------------------------------
-- NULL / NOT NULL:
-- NULL means that a value is unknown
-- It does not mean 0 !!
INSERT INTO cats(name)
VALUES
(
	"Alabama"
);-- this will produce a NULL value in the age column in this row

CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
-- now if you don't insert a value, it will insert a default value instead of NULL
-- ------------------------------------------------------------
-- DEFAULT VALUES:
-- you set a default value when creating the table
CREATE TABLE cats3 (
    name VARCHAR(100) DEFAULT 'no name',
    age INT DEFAULT 99
);
-- those will now be the values of a row if no values are provided
-- can combine above with NOT NULL as well
-- ----------------------------------------------------------------
-- PRIMARY KEYS:
-- A primary key is a unique identifier that you add when creating a table
CREATE TABLE unique_cats (
    cat_id INT NOT NULL,
    name VARCHAR(20),
    age INT,
    PRIMARY KEY (cat_id)
);

INSERT INTO unique_cats
VALUES
(
	1, "Sniffles", 4
);

INSERT INTO unique_cats
VALUES
(
	1, "James", 14
);-- this will give an error since there is already an id of 1 and the can only be one

CREATE TABLE unique_cats (
    cat_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    age INT,
    PRIMARY KEY (cat_id)
);
-- ----------------------------------------------------
-- CRUD:
-- CREATE - READ - UPDATE - DELETE
-- CREATE is creating tables and databases and inserting data into them like 'insert into...'
-- READ is viewing all of the data in tables etc , like 'select from ..'
-- UPDATE is updating the data already in tables etc 
-- DELETE is permanently removing data from your tables and databases.
-- ----------------------------------------------------------------
-- READING FROM DATABASE:
-- this is done with the select statement:
SELECT 
    *
FROM
    cats;-- shows all columns in table

SELECT 
    name
FROM
    cats;
SELECT 
    age
FROM
    cats;
SELECT 
    cat_id
FROM
    cats;

-- can select more than one specific column:
SELECT 
    name, age
FROM
    cats;

-- to select specific rows in a table use the WHERE statement:
SELECT 
    *
FROM
    cats
WHERE
    age = 4;-- gives a matching row of data

SELECT 
    *
FROM
    cats
WHERE
    name = 'Egg';
-- ---------------------------------------------------------------
-- ALIASES:
-- can assign a table or column name an alias to make it easier to read etc:
SELECT 
    cat_id AS id, name
FROM
    cats;-- now the column name will say id instead of cat_id in the result
-- it doesn't change the names permanently
-- --------------------------------------------------------------
-- UPDATE:
-- this will update existing data in rows
UPDATE cats 
SET 
    breed = 'Shorthair'
WHERE
    breed = 'Tabby';
-- this command will update all the tabby breeds to shorthairs

SELECT 
    *
FROM
    cats;

UPDATE cats 
SET 
    age = 14
WHERE
    name = 'Misty';

SELECT 
    *
FROM
    cats
WHERE
    name = 'Misty';

-- always make sure that you are targeting the correct data before updating , so do a select first to see
-- ---------------------------------------------------------------------
-- DELETE:
-- this will permanently delete/destroy existing data in your tables:
DELETE FROM cats 
WHERE
    name = 'Egg';

-- make sure you're targeting the correct data by selecting first!
-- -------------------------------------------------------------------
-- STRING FUNCTIONS:

SELECT CONCAT('Hello ', 'World');-- example ... check spaces etc

SELECT 
    CONCAT(author_fname, ' ', author_lname)
FROM
    books;

-- can add alias
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS Author
FROM
    books;

SELECT 
    author_fname AS first,
    author_lname AS last,
    CONCAT(author_fname, ' ', author_lname) AS fullname
FROM
    books;

-- SELECT CONCAT(title, "-", author_lname,"-",.....) -- this could become a lot, so instead 
-- if you want to use a lot of seperators , use concat_ws():
SELECT 
    CONCAT_WS(' - ', title, author_fname, author_lname)
FROM
    books;-- this will add the seperator between every thing you select

SELECT SUBSTRING('Hello World', 1, 4);-- starts at the first letter and gives back up until the fourth letter
-- output -> 'Hell'
-- do not start counting from 0 in sql

SELECT SUBSTR('Hello World', 7);-- this will start at letter 7 and return everything after it 
-- output -> 'World'

SELECT SUBSTR('Hello World', - 3);-- will move from back

SELECT 
    SUBSTR(title, 1, 10) AS short_title
FROM
    books;

-- can combine concat + subst:
SELECT 
    CONCAT(SUBSTR(title, 1, 10), '...') AS short_name
FROM
    books;

-- REPLACE:
-- this replaces parts of strings
SELECT REPLACE('Hello World', 'Hell', '%$#@');
-- so you choose the string you want, then the part you want to change, then what you want to change it to.

SELECT REPLACE('Hello World', 'l', '4');
-- this will replace all 'l' with 4

SELECT 
    REPLACE('Cheese bread coffee milk',
        ' ',
        ' and ');
-- replaces all the spaces with and

SELECT 
    REPLACE(title, 'e', 3)
FROM
    books;

-- can also combine with other functions:
SELECT 
    SUBSTR(REPLACE(title, 'e', 3), 1, 10)
FROM
    books;

-- REVERSE:
-- this reverses a string you enter
SELECT REVERSE('Hello World');

-- CHAR_LENGTH:
-- tells you how many characters are in a given string
SELECT CHAR_LENGTH('Hello World');
-- 33

SELECT 
    author_lname, CHAR_LENGTH(author_lname)
FROM
    books;

-- UPPER , LOWER:
-- changes a string's casing
SELECT UPPER('hello world');-- converts to all caps

SELECT LOWER('HELLO WORLD'); -- converts to lower
-- ----------------------------------------------------------------------
-- REFINING OUR SEARCHES:

-- just adding some more data to books first..
INSERT INTO books(title, author_lname, author_fname, released_year, stock_quantity, pages)
VALUES
("10% Happier", "Dan", "Harris", 2014, 29, 256),
("fake_book", "Freida", "Harris", 2001, 287, 428),
("Lincoln In The Bardo", "George", "Saunders", 2017, 1000, 367);

-- DISTINCT:
-- this will only return a unique item (only 1 of each/ no duplicates)
SELECT DISTINCT
    author_lname
FROM
    books;

-- works with int as well
SELECT DISTINCT
    released_year
FROM
    books;

-- to get a distinct full name
SELECT DISTINCT
    CONCAT(author_fname, ' ', author_lname)
FROM
    books;

-- easier way --
SELECT DISTINCT
    author_fname, author_lname
FROM
    books;

-- ORDER BY:
-- this sorts results
SELECT 
    author_lname
FROM
    books
ORDER BY author_lname;
 -- by default is is stored ascending 
-- can change to descending
SELECT 
    author_lname
FROM
    books
ORDER BY author_lname DESC;

-- works with numbers as well
SELECT 
    released_year
FROM
    books
ORDER BY released_year;

-- you down have to order by something that you are selecting

SELECT 
    title, author_fname, author_lname
FROM
    books
ORDER BY 2;-- 2 is a shortcut to say author_fname ( so title will be 1 and author_lname is 3)

SELECT 
    author_fname, author_lname
FROM
    books
ORDER BY author_lname , author_fname;

-- LIMIT:
-- allows us to specify how many results we want to select
SELECT 
    title
FROM
    books
LIMIT 3;-- will only return first 3 results

SELECT 
    title, released_year
FROM
    books
ORDER BY released_year DESC
LIMIT 5;

-- can specify how many rows as well by specifying a starting point and by how much you want after that point
SELECT 
    title, released_year
FROM
    books
ORDER BY released_year DESC
LIMIT 4 , 6;-- so will start at book 5 (cause start from 0) and return 5 more books after it (books 5 - 10)

SELECT 
    title
FROM
    books
LIMIT 4 , 56688225741148;-- this will give you from book 5 all the way to the end.

SELECT 
    title, author_fname
FROM
    books
WHERE
    author_fname LIKE '%da%';-- this will find all authors with a 'da' somewhere in their names

SELECT 
    title, author_fname
FROM
    books
WHERE
    author_fname LIKE '%da';

-- or names that start with a 'da'
SELECT 
    title, author_fname
FROM
    books
WHERE
    author_fname LIKE 'da%';

SELECT 
    title
FROM
    books
WHERE
    title LIKE '%the%';-- it is case INSENSITIVE
-- the % wildcard says that you want everything before or after the word as well 

SELECT 
    title, stock_quantity
FROM
    books
WHERE
    stock_quantity LIKE '____';-- says get stock where quantity is exactly 4 digits

SELECT 
    title
FROM
    books
WHERE
    title LIKE '%\%%';

SELECT 
    title
FROM
    books
WHERE
    title LIKE '%\_%';
-- ---------------------------------------------------------------
-- AGGREGATE FUNCTIONS:

SELECT 
    COUNT(*)
FROM
    books;-- this will count how many books there are in the table

SELECT 
    COUNT(DISTINCT author_fname)
FROM
    books;

SELECT 
    COUNT(title)
FROM
    books
WHERE
    title LIKE '%the%';

-- GROUP BY:
-- summarizes or aggregates identical data into single rows
SELECT 
    title, author_lname
FROM
    books
GROUP BY author_lname;-- this will group all the books together that has the same author

SELECT 
    author_lname, COUNT(*)
FROM
    books
GROUP BY author_lname;

SELECT 
    title, author_fname, author_lname
FROM
    books
GROUP BY author_lname;

SELECT 
    author_fname, author_lname, COUNT(*)
FROM
    books
GROUP BY author_lname , author_fname;

SELECT 
    released_year, COUNT(*)
FROM
    books
GROUP BY released_year;

-- MIN AND MAX:
-- gets the min or max values in a table
SELECT 
    MIN(released_year)
FROM
    books;-- shows earliest year a book was released

SELECT 
    MIN(pages)
FROM
    books;

SELECT 
    MAX(pages)
FROM
    books;

-- if you want an easy way to find the book title with the most pages
SELECT 
    *
FROM
    books
ORDER BY pages DESC
LIMIT 1;

-- using min and max with a group by:
SELECT 
    author_fname, author_lname, MIN(released_year)
FROM
    books
GROUP BY author_lname , author_fname;-- will show you all the authors and the year they released their first book

SELECT 
    author_fname, author_lname, MAX(pages)
FROM
    books
GROUP BY author_fname , author_lname;

-- clean version
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    MAX(pages) AS 'longest book'
FROM
    books
GROUP BY author_fname , author_lname
ORDER BY MAX(pages);

-- SUBQUERIES:
-- this lets you run one query inside of another, and use its results in the outer query 
SELECT 
    title
FROM
    books
WHERE
    pages = (SELECT 
            MIN(pages)
        FROM
            books);

SELECT 
    title, pages
FROM
    books
WHERE
    pages = (SELECT 
            MAX(pages)
        FROM
            books);

-- SUM:
-- sums data together (a + b)
SELECT 
    SUM(pages)
FROM
    books;-- sum of all pages in table

SELECT 
    author_fname, author_lname, SUM(pages)
FROM
    books
GROUP BY author_fname , author_lname;

-- AVG:
-- gets the average of data 
SELECT 
    AVG(released_year)
FROM
    books;

SELECT 
    AVG(pages)
FROM
    books;-- always returns nr with 4 decimal places

SELECT 
    AVG(stock_quantity)
FROM
    books
GROUP BY released_year;

SELECT 
    released_year, AVG(stock_quantity)
FROM
    books
GROUP BY released_year;

SELECT 
    author_fname, author_lname, AVG(pages)
FROM
    books
GROUP BY author_fname , author_lname;
-- -----------------------------------------------------
-- MORE DATA TYPES:

CREATE TABLE date_time (
    name VARCHAR(40),
    bday DATE,
    birthtime TIME,
    birthday DATETIME
);

INSERT INTO date_time
VALUES
("Padma", "1983-11-11", "10:07:35", "1983-11-11 10:07:35");

INSERT INTO date_time
VALUES
("Larry", "1943-12-25", "04:10:42", "1943-12-25 04:10:42");

-- methods with date etc
-- CURDATE() -> gives the current date
-- CURTIM() -> gives current time
-- NOW() -> gives current datetime

SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();

INSERT INTO date_time
VALUES(
	"Toaster", CURDATE(), CURTIME(), NOW()
);

-- FORMATTING DATES:
SELECT 
    name, bday, DAY(bday)
FROM
    date_time;-- > day nr

SELECT 
    name, bday, DAYNAME(bday)
FROM
    date_time;-- > name of day

SELECT 
    name, bday, DAYOFWEEK(bday)
FROM
    date_time;-- > nr of day in the week

SELECT 
    name, bday, DAYOFYEAR(bday)
FROM
    date_time;-- > nr of day in year

SELECT 
    DATE_FORMAT(bday, '%W %M %Y')
FROM
    date_time;

SELECT 
    DATE_FORMAT(bday, 'Was born on %W %M %Y')
FROM
    date_time;

-- DATE MATH:
-- datediff(exp 1, exp 2) -> returns the difference between two days
SELECT 
    name, bday, DATEDIFF(NOW(), bday)
FROM
    date_time;

-- date_add() will add to the date you pass in 
SELECT 
    birthday, DATE_ADD(birthday, INTERVAL 1 MONTH)
FROM
    date_time;-- will move up one month

SELECT 
    birthday, birthday + INTERVAL 1 MONTH
FROM
    date_time;
-- can do same with date_sub or -
-- you can use the +/- to chain together more than one interval

CREATE TABLE comments (
    content VARCHAR(40),
    created_at TIMESTAMP DEFAULT NOW ()
);

INSERT INTO comments(content)
VALUES
("LOL"),("I hate this"), ("I'm tired of this now");

SELECT 
    *
FROM
    comments
ORDER BY created_at DESC;

CREATE TABLE comments_2 (
    content VARCHAR(50),
    changed_at TIMESTAMP DEFAULT NOW () ON UPDATE CURRENT_TIMESTAMP
); -- changes timestamp when updating a comment 

INSERT INTO comments_2(content)
VALUES
("LOL"),("I hate this"), ("I'm tired of this now");

UPDATE comments_2 
SET 
    content = 'This is not blehh'
WHERE
    content = 'LOL';

SELECT 
    *
FROM
    comments_2;
-- now can track when something was inserted or updated
-- -------------------------------------------------------------
-- LOGICAL OPERATORS:

SELECT 
    title, released_year
FROM
    books
WHERE
    released_year != 2017;
-- will return books from every year except 2017

SELECT 
    title, author_lname
FROM
    books
WHERE
    author_lname != 'Harris';

-- NOT LIKE:
-- opposite of LIKE
SELECT 
    title
FROM
    books
WHERE
    title NOT LIKE 'W%';
-- will return all books that do not start with a 'W'

SELECT 
    *
FROM
    books
WHERE
    released_year > 2000;-- will return all books that were written after 2000

SELECT 
    *
FROM
    books
WHERE
    released_year < 2000;-- will return all books that were written before 2000

SELECT 
    *
FROM
    books
WHERE
    released_year >= 2000;

SELECT 
    title, stock_quantity
FROM
    books
WHERE
    stock_quantity >= 100;

-- AND / &&:
-- allows you to chain queries together, and will return results if all conditions are true/ not true
SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Eggers'
        AND released_year > 2010;

-- OR / ||:
-- also allows you tto chain queries together, but will return result if one or both conditions are true
SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Eggers'
        OR released_year > 2010;
-- will return books that are written by Eggers and books released after 2010

SELECT 
    *
FROM
    books
WHERE
    released_year >= 2004
        AND released_year <= 2015;
-- return all books between 2004 and 2015

SELECT 
    *
FROM
    books
WHERE
    released_year BETWEEN 2004 AND 2015;

-- NOT BETWEEN:
-- opposite of between
SELECT 
    *
FROM
    books
WHERE
    released_year NOT BETWEEN 2004 AND 2015;-- returns everything out of the range

SELECT CAST('2017-05-02' AS DATETIME);

SELECT 
    name
FROM
    people
WHERE
    birthday BETWEEN '1980-01-01' AND '2000-01-01';-- this will still work even tho these are strings
-- but better to cast them to actual dates

SELECT 
    name
FROM
    date_time
WHERE
    birthday BETWEEN CAST('1980-01-01' AS DATE) AND CAST('2000-01-01' AS DATE);

-- IN / NOT IN:
-- allows to provide set of values, and checks whether your value is in that set of values
-- can technically use or
SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Carver'
        OR author_lname = 'Lahiri'
        OR author_lname = 'Smith';

-- using IN
SELECT 
    *
FROM
    books
WHERE
    author_lname IN ('Carver' , 'Lahiri', 'Smith');

-- NOT IN is the opposite of IN
SELECT 
    *
FROM
    books
WHERE
    released_year NOT IN (2000 , 2002,
        2004,
        2006,
        2008,
        2010,
        2012,
        2014,
        2016);

-- shorter way... testing if a number is even with % 
SELECT 
    *
FROM
    books
WHERE
    released_year >= 2000
        AND released_year % 2 != 0;

-- CASE:
-- basically if and else statements , only does something if a condition is true / false
SELECT 
    title,
    released_year,
    CASE
        WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
    END AS Genre
FROM
    books;

SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS Stock
FROM
    books;

-- shorter way to do the above
SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS Stock
FROM
    books;
-- ------------------------------------------------------------------
-- ONE TO MANY RELATIONSHIPS:
-- this is the most common releationship

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DEC(8 , 2 ),
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
);

INSERT INTO customers(first_name, last_name, email)
VALUES("Boy", "George", "george@gmail.com"),
	("George", "Michael", "gm@gmail.com"),
    ("David", "Bowie", "david@gmail.com"),
    ("Blue", "Steele", "blue@email.com"),
    ("Bette", "Davis", "bette@email.com");
    
INSERT INTO orders(order_date, amount, customer_id)
VALUES("2016/02/10", 99.99, 1),
	  ("2017/11/11", 35.50, 1),
      ("2014/12/12", 800.67, 2),
      ("2015/01/03", 12.50, 2),
      ("1999/04/11", 450.25, 5);
      
INSERT INTO orders(order_date, amount, customer_id)
VALUES("2016/02/10", 99.99, 85);-- will produce an error because the customer id being referenced does not exist yet

SELECT 
    *
FROM
    customers
        CROSS JOIN
    orders;

-- or can state like this:
SELECT 
    *
FROM
    customers,
    orders;-- since it is also called a comma join

SELECT 
    *
FROM
    customers,
    orders
WHERE
    customers.id = orders.customer_id;

-- or
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers AS c,
    orders AS o
WHERE
    c.id = o.customer_id;

-- here is an explicit inner join example with syntax:
-- this makes the code look more clean
SELECT 
    *
FROM
    customers AS c
        INNER JOIN
    orders AS o ON c.id = o.customer_id;

-- can just say 'JOIN' instead of 'INNER JOIN'
-- can do all the functions we've covered on these joint tables as well:
SELECT 
    first_name, last_name, order_date, SUM(amount) AS total
FROM
    customers AS c
        JOIN
    orders AS o ON c.id = o.customer_id
GROUP BY o.customer_id
ORDER BY total DESC;

-- LEFT JOIN (OUTTER JOIN)
-- selects everything from A , along with any matching records from B
SELECT 
    *
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id;

SELECT 
    first_name, last_name, order_date, amount
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id;
    
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id
GROUP BY c.id;
    
-- if you want to avoid a NULL and rather have a 0 in place:
SELECT 
    first_name, last_name, IFNULL(SUM(amount), 0) AS total
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.id = o.customer_id
GROUP BY c.id
ORDER BY total;
 
-- RIGHT JOINS:
-- opposite of left join
SELECT 
    *
FROM
    customers AS c
        RIGHT JOIN
    orders AS o ON c.id = o.customer_id;
    
-- how to delete a prim and f key:
-- so if you delete a primary key, it goes ahead and deletes its f key as well
-- ON DELETE CASCADE
CREATE TABLE orders_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DEC(8 , 2 ),
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
        ON DELETE CASCADE -- JUST ADD THIS AFTER THE F KEY
);
-- ------------------------------------------------------------------------------------
-- MANY TO MANY RELATIONSHIPS:
-- this requires a join table (extra table that links the two main tables)

-- CREATING THE REVIEWERS TABLE
CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- CREATING THE SERIES TABLE
CREATE TABLE series(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

-- CREATING THE REVIEWS TABLE
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

-- INSERTING DATA
INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
-- ------------------------------------------------------------------------
