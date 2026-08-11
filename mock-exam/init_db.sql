-- Initial schema and seed data for ISDA Mock SQL Examination Database (isda-mock-exam)
-- Target Database: PostgreSQL 16 ANSI SQL Standard

-- Drop existing tables
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

DROP TABLE IF EXISTS recent_presidents CASCADE;
DROP TABLE IF EXISTS pres_hobby CASCADE;
DROP TABLE IF EXISTS pres_marriage CASCADE;
DROP TABLE IF EXISTS administration CASCADE;
DROP TABLE IF EXISTS state CASCADE;
DROP TABLE IF EXISTS president CASCADE;

-- 1. Table: departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

-- 2. Table: employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL
);

-- 3. Table: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL
);

-- 4. Table: orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    employee_id INT REFERENCES employees(employee_id),
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

-- 5. Table: order_items
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

-- Seed Data: departments
INSERT INTO departments VALUES
(101, 'Sales', 'New York'),
(102, 'Engineering', 'San Francisco'),
(103, 'Marketing', 'London'),
(104, 'Human Resources', 'New York'),
(105, 'Finance', 'Tokyo');

-- Seed Data: employees
INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 101, 75000.00, '2019-03-15', 'Sales Representative'),
(2, 'Bob', 'Jones', 101, 82000.00, '2018-06-01', 'Sales Manager'),
(3, 'Charlie', 'Brown', 102, 110000.00, '2020-01-10', 'Senior Software Engineer'),
(4, 'Diana', 'Prince', 102, 125000.00, '2017-11-20', 'Lead Architect'),
(5, 'Evan', 'Wright', 103, 68000.00, '2021-04-05', 'Marketing Specialist'),
(6, 'Fiona', 'Gallagher', 104, 55000.00, '2022-08-12', 'HR Assistant'),
(7, 'George', 'Clark', 101, 71000.00, '2021-09-01', 'Sales Representative'),
(8, 'Hannah', 'Abbott', 103, 64000.00, '2020-05-18', 'Marketing Coordinator');

-- Seed Data: customers
INSERT INTO customers VALUES
(201, 'Acme Corp', 'New York', 'USA', '2019-01-10'),
(202, 'Global Tech', 'London', 'UK', '2020-02-14'),
(203, 'Innovate LLC', 'San Francisco', 'USA', '2021-07-22'),
(204, 'Starlight Inc', 'Tokyo', 'Japan', '2018-11-30'),
(205, 'Apex Solutions', 'London', 'UK', '2022-03-05');

-- Seed Data: orders
INSERT INTO orders VALUES
(1001, 201, 1, '2023-01-15', 'Completed', 1500.00),
(1002, 202, 2, '2023-01-20', 'Completed', 3200.00),
(1003, 201, 1, '2023-02-05', 'Completed', 850.00),
(1004, 203, 7, '2023-02-12', 'Pending', 1200.00),
(1005, 204, 2, '2023-03-01', 'Completed', 5400.00),
(1006, 205, 5, '2023-03-10', 'Cancelled', 450.00),
(1007, 202, 7, '2023-03-15', 'Completed', 2100.00),
(1008, 201, 2, '2023-03-22', 'Completed', 4100.00);

-- Seed Data: order_items
INSERT INTO order_items VALUES
(1, 1001, 'Laptop Stand', 'Hardware', 50.00, 2),
(2, 1001, 'Wireless Mouse', 'Hardware', 25.00, 4),
(3, 1002, 'Enterprise License', 'Software', 1600.00, 2),
(4, 1003, 'Ergonomic Keyboard', 'Hardware', 85.00, 10),
(5, 1004, 'Cloud Storage Addon', 'Software', 150.00, 8),
(6, 1005, 'Server Rack 42U', 'Hardware', 1800.00, 3),
(7, 1006, 'Onboarding Session', 'Services', 450.00, 1),
(8, 1007, 'Security Audit Service', 'Services', 2100.00, 1),
(9, 1008, 'Database Optimization Tool', 'Software', 1600.00, 2),
(10, 1008, '27-inch Monitor', 'Hardware', 300.00, 3);

-- =====================================================
-- PRESIDENTIAL DATABASE (Covering SQL/DS Release 2 Textbook)
-- =====================================================

-- 6. Table: recent_presidents
CREATE TABLE recent_presidents (
    pres_name VARCHAR(50) PRIMARY KEY,
    birth_yr INT NOT NULL,
    yrs_serv INT NOT NULL,
    death_age INT,
    party VARCHAR(30) NOT NULL,
    state_born VARCHAR(30) NOT NULL
);

INSERT INTO recent_presidents VALUES
('Roosevelt F D', 1882, 12, 63, 'Democratic', 'New York'),
('Truman H S', 1884, 7, 88, 'Democratic', 'Missouri'),
('Eisenhower D D', 1890, 8, 79, 'Republican', 'Texas'),
('Kennedy J F', 1917, 3, 46, 'Democratic', 'Massachusetts'),
('Johnson L B', 1908, 5, 65, 'Democratic', 'Texas'),
('Nixon R M', 1913, 5, 81, 'Republican', 'California'),
('Ford G R', 1913, 2, 93, 'Republican', 'Nebraska'),
('Carter J E', 1924, 4, NULL, 'Democratic', 'Georgia'),
('Reagan R', 1911, 8, 93, 'Republican', 'Illinois');

-- 7. Table: president
CREATE TABLE president (
    pres_name VARCHAR(50) PRIMARY KEY,
    birth_yr INT NOT NULL,
    yrs_serv INT NOT NULL,
    death_age INT,
    party VARCHAR(30) NOT NULL,
    state_born VARCHAR(30) NOT NULL
);

INSERT INTO president VALUES
('Washington G', 1732, 8, 67, 'Federalist', 'Virginia'),
('Adams J', 1735, 4, 90, 'Federalist', 'Massachusetts'),
('Jefferson T', 1743, 8, 83, 'Democratic-Republican', 'Virginia'),
('Madison J', 1751, 8, 85, 'Democratic-Republican', 'Virginia'),
('Monroe J', 1758, 8, 73, 'Democratic-Republican', 'Virginia'),
('Adams J Q', 1767, 4, 80, 'Democratic-Republican', 'Massachusetts'),
('Jackson A', 1767, 8, 78, 'Democratic', 'North Carolina'),
('Van Buren M', 1782, 4, 79, 'Democratic', 'New York'),
('Harrison W H', 1773, 0, 68, 'Whig', 'Virginia'),
('Tyler J', 1790, 4, 71, 'Whig', 'Virginia'),
('Polk J K', 1795, 4, 53, 'Democratic', 'North Carolina'),
('Taylor Z', 1784, 1, 65, 'Whig', 'Virginia'),
('Fillmore M', 1800, 3, 74, 'Whig', 'New York'),
('Pierce F', 1804, 4, 64, 'Democratic', 'New Hampshire'),
('Buchanan J', 1791, 4, 77, 'Democratic', 'Pennsylvania'),
('Lincoln A', 1809, 4, 56, 'Republican', 'Kentucky'),
('Johnson A', 1808, 4, 66, 'Democratic', 'North Carolina'),
('Grant U S', 1822, 8, 63, 'Republican', 'Ohio'),
('Hayes R B', 1822, 4, 70, 'Republican', 'Ohio'),
('Garfield J A', 1831, 0, 49, 'Republican', 'Ohio'),
('Arthur C A', 1829, 4, 56, 'Republican', 'Vermont'),
('Cleveland G', 1837, 8, 71, 'Democratic', 'New Jersey'),
('Harrison B', 1833, 4, 67, 'Republican', 'Ohio'),
('McKinley W', 1843, 4, 58, 'Republican', 'Ohio'),
('Roosevelt T', 1858, 7, 60, 'Republican', 'New York'),
('Taft W H', 1857, 4, 72, 'Republican', 'Ohio'),
('Wilson W', 1856, 8, 67, 'Democratic', 'Virginia'),
('Harding W G', 1865, 2, 57, 'Republican', 'Ohio'),
('Coolidge C', 1872, 5, 60, 'Republican', 'Vermont'),
('Hoover H C', 1874, 4, 90, 'Republican', 'Iowa'),
('Roosevelt F D', 1882, 12, 63, 'Democratic', 'New York'),
('Truman H S', 1884, 7, 88, 'Democratic', 'Missouri'),
('Eisenhower D D', 1890, 8, 79, 'Republican', 'Texas'),
('Kennedy J F', 1917, 3, 46, 'Democratic', 'Massachusetts'),
('Johnson L B', 1908, 5, 65, 'Democratic', 'Texas'),
('Nixon R M', 1913, 5, 81, 'Republican', 'California'),
('Ford G R', 1913, 2, 93, 'Republican', 'Nebraska'),
('Carter J E', 1924, 4, NULL, 'Democratic', 'Georgia'),
('Reagan R', 1911, 8, 93, 'Republican', 'Illinois');

-- 8. Table: pres_marriage
CREATE TABLE pres_marriage (
    pres_name VARCHAR(50) NOT NULL,
    spouse_name VARCHAR(50) NOT NULL,
    pr_age INT NOT NULL,
    sp_age INT NOT NULL,
    nr_children INT NOT NULL,
    PRIMARY KEY (pres_name, spouse_name)
);

INSERT INTO pres_marriage VALUES
('Washington G', 'Dandridge M D', 26, 27, 0),
('Adams J', 'Smith A', 29, 19, 5),
('Jefferson T', 'Wayles M', 28, 23, 6),
('Madison J', 'Todd D D P', 43, 26, 0),
('Monroe J', 'Kortright E', 27, 17, 3),
('Adams J Q', 'Johnson L C', 30, 22, 4),
('Jackson A', 'Robards R D', 24, 23, 0),
('Van Buren M', 'Hoes H', 24, 23, 4),
('Harrison W H', 'Symmes A T', 22, 20, 10),
('Tyler J', 'Christian L', 23, 22, 8),
('Tyler J', 'Gardiner J', 54, 24, 7),
('Polk J K', 'Childress S', 28, 20, 0),
('Taylor Z', 'Smith M M', 25, 21, 6),
('Fillmore M', 'Powers A', 26, 28, 2),
('Fillmore M', 'McIntosh C C', 58, 44, 0),
('Pierce F', 'Appleton J M', 29, 28, 3),
('Lincoln A', 'Todd M', 33, 23, 4),
('Johnson A', 'McCardle E', 18, 16, 5),
('Grant U S', 'Dent J B', 26, 22, 4),
('Hayes R B', 'Webb L W', 30, 21, 8),
('Garfield J A', 'Rudolph L', 26, 26, 7),
('Arthur C A', 'Herndon E L', 29, 22, 3),
('Cleveland G', 'Folsom F', 49, 21, 5),
('Harrison B', 'Scott C L', 20, 21, 2),
('Harrison B', 'Dimmick M S', 62, 37, 1),
('McKinley W', 'Saxton I', 27, 23, 2),
('Roosevelt T', 'Lee A H', 22, 19, 1),
('Roosevelt T', 'Carow E K', 28, 25, 5),
('Taft W H', 'Herron H', 28, 25, 3),
('Wilson W', 'Axson E L', 28, 25, 3),
('Wilson W', 'Galt E B', 58, 43, 0),
('Harding W G', 'De Wolfe F K', 25, 30, 0),
('Coolidge C', 'Goodhue G A', 33, 26, 2),
('Hoover H C', 'Henry L', 24, 24, 2),
('Roosevelt F D', 'Roosevelt A E', 23, 20, 6),
('Truman H S', 'Wallace E V', 35, 34, 1),
('Eisenhower D D', 'Doud M G', 25, 19, 2),
('Kennedy J F', 'Bouvier J L', 36, 24, 3),
('Johnson L B', 'Taylor C A', 26, 21, 2),
('Nixon R M', 'Ryan T C', 27, 28, 2),
('Ford G R', 'Warren E B', 35, 30, 4),
('Carter J E', 'Smith R', 21, 18, 4),
('Reagan R', 'Wyman J', 29, 26, 2),
('Reagan R', 'Davis N', 41, 30, 2);

-- 9. Table: pres_hobby
CREATE TABLE pres_hobby (
    pres_name VARCHAR(50) NOT NULL,
    hobby VARCHAR(50) NOT NULL,
    PRIMARY KEY (pres_name, hobby)
);

INSERT INTO pres_hobby VALUES
('Washington G', 'Riding'),
('Adams J', 'Reading'),
('Jefferson T', 'Riding'),
('Jefferson T', 'Violin'),
('Madison J', 'Chess'),
('Monroe J', 'Riding'),
('Adams J Q', 'Swimming'),
('Jackson A', 'Riding'),
('Van Buren M', 'Riding'),
('Harrison W H', 'Hunting'),
('Tyler J', 'Music'),
('Polk J K', 'Hunting'),
('Taylor Z', 'Hunting'),
('Fillmore M', 'Reading'),
('Pierce F', 'Riding'),
('Lincoln A', 'Walking'),
('Johnson A', 'Checkers'),
('Grant U S', 'Riding'),
('Hayes R B', 'Shooting'),
('Garfield J A', 'Billiards'),
('Arthur C A', 'Fishing'),
('Cleveland G', 'Fishing'),
('Harrison B', 'Hunting'),
('McKinley W', 'Swimming'),
('Roosevelt T', 'Hunting'),
('Roosevelt T', 'Boxing'),
('Taft W H', 'Golf'),
('Wilson W', 'Golf'),
('Harding W G', 'Golf'),
('Coolidge C', 'Fishing'),
('Hoover H C', 'Fishing'),
('Roosevelt F D', 'Sailing'),
('Truman H S', 'Walking'),
('Eisenhower D D', 'Golf'),
('Kennedy J F', 'Sailing'),
('Johnson L B', 'Riding'),
('Nixon R M', 'Bowling'),
('Ford G R', 'Golf'),
('Carter J E', 'Jogging'),
('Reagan R', 'Riding');

-- 10. Table: administration
CREATE TABLE administration (
    admin_nr INT PRIMARY KEY,
    pres_name VARCHAR(50) NOT NULL,
    year_inaug INT NOT NULL
);

INSERT INTO administration VALUES
(1, 'Washington G', 1789),
(2, 'Washington G', 1793),
(3, 'Adams J', 1797),
(4, 'Jefferson T', 1801),
(5, 'Jefferson T', 1805),
(6, 'Madison J', 1809),
(7, 'Madison J', 1813),
(8, 'Monroe J', 1817),
(9, 'Monroe J', 1821),
(10, 'Adams J Q', 1825),
(11, 'Jackson A', 1829),
(12, 'Jackson A', 1833),
(13, 'Van Buren M', 1837),
(14, 'Harrison W H', 1841),
(15, 'Tyler J', 1841),
(16, 'Polk J K', 1845),
(17, 'Taylor Z', 1849),
(18, 'Fillmore M', 1850),
(19, 'Pierce F', 1853),
(20, 'Buchanan J', 1857),
(21, 'Lincoln A', 1861),
(22, 'Lincoln A', 1865),
(23, 'Johnson A', 1865),
(24, 'Grant U S', 1869),
(25, 'Grant U S', 1873),
(26, 'Hayes R B', 1877),
(27, 'Garfield J A', 1881),
(28, 'Arthur C A', 1881),
(29, 'Cleveland G', 1885),
(30, 'Harrison B', 1889),
(31, 'Cleveland G', 1893),
(32, 'McKinley W', 1897),
(33, 'McKinley W', 1901),
(34, 'Roosevelt T', 1901),
(35, 'Roosevelt T', 1905),
(36, 'Taft W H', 1909),
(37, 'Wilson W', 1913),
(38, 'Wilson W', 1917),
(39, 'Harding W G', 1921),
(40, 'Coolidge C', 1923),
(41, 'Coolidge C', 1925),
(42, 'Hoover H C', 1929),
(43, 'Roosevelt F D', 1933),
(44, 'Roosevelt F D', 1937),
(45, 'Roosevelt F D', 1941),
(46, 'Roosevelt F D', 1945),
(47, 'Truman H S', 1945),
(48, 'Truman H S', 1949),
(49, 'Eisenhower D D', 1953),
(50, 'Eisenhower D D', 1957),
(51, 'Kennedy J F', 1961),
(52, 'Johnson L B', 1963),
(53, 'Johnson L B', 1965),
(54, 'Nixon R M', 1969),
(55, 'Nixon R M', 1973),
(56, 'Ford G R', 1974),
(57, 'Carter J E', 1977),
(58, 'Reagan R', 1981);

-- 11. Table: state
CREATE TABLE state (
    state_name VARCHAR(50) PRIMARY KEY,
    year_entered INT NOT NULL
);

INSERT INTO state VALUES
('Delaware', 1787),
('Pennsylvania', 1787),
('New Jersey', 1787),
('Georgia', 1788),
('Connecticut', 1788),
('Massachusetts', 1788),
('Maryland', 1788),
('South Carolina', 1788),
('New Hampshire', 1788),
('Virginia', 1788),
('New York', 1788),
('North Carolina', 1789),
('Rhode Island', 1790),
('Vermont', 1791),
('Kentucky', 1792),
('Tennessee', 1796),
('Ohio', 1803),
('Louisiana', 1812),
('Indiana', 1816),
('Mississippi', 1817),
('Illinois', 1818),
('Alabama', 1819),
('Maine', 1820),
('Missouri', 1821),
('Arkansas', 1836),
('Michigan', 1837),
('Florida', 1845),
('Texas', 1845),
('Iowa', 1846),
('Wisconsin', 1848),
('California', 1850),
('Minnesota', 1858),
('Oregon', 1859),
('Kansas', 1861),
('West Virginia', 1863),
('Nevada', 1864),
('Nebraska', 1867),
('Colorado', 1876),
('North Dakota', 1889),
('South Dakota', 1889),
('Montana', 1889),
('Washington', 1889),
('Idaho', 1890),
('Wyoming', 1890),
('Utah', 1896),
('Oklahoma', 1907),
('New Mexico', 1912),
('Arizona', 1912),
('Alaska', 1959),
('Hawaii', 1959);
