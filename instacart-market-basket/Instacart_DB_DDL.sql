--Database ceation

CREATE DATABASE Instacart_DB;

--Use DATABASE

USE Instacart_DB;

--Dimension TABLES

-- 1. dbo.dim_users
CREATE TABLE dbo.dim_users(
  user_sk INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
);

-- 2. dbo.dim_aisles

CREATE TABLE dbo.dim_aisles(
  aisle_sk INT IDENTITY(1,1) PRIMARY KEY,
  aisle_id INT NOT NULL UNIQUE,
  aisle_description NVARCHAR(250)
);

-- 3. dbo.dim_deparments

CREATE TABLE dbo.dim_departments(
  department_sk INT IDENTITY(1,1) PRIMARY KEY,
  department_id INT 
);

-- 4. dbo.dim_products

CREATE TABLE dbo.dim_products(
  product_sk INT IDENTITY(1,1) PRIMARY KEY,
  product_id INT NOT NULL UNIQUE,
  product_name NVARCHAR(250) NOT NULL,
  aisle_sk INT NOT NULL,
  department_sk INT NOT NULL,
  CONSTRAINT FK_product_aisles FOREIGN KEY (aisle_sk) REFERENCES dbo.dim_aisles(aisle_sk),
  CONSTRAINT FK_product_depts FOREIGN KEY (department_sk) REFERENCES dbo.dim_departments(department_sk)
);

--Fact TABLE

--1.dbo.fact_orders
CREATE TABLE fact_orders(
  order_id INT NOT NULL PRIMARY KEY,
  product_sk INT NOT NULL,
  user_sk INT NOT NULL,
  order_number INT NOT NULL,
  order_dow TINYINT NOT NULL,
  order_hour_of_day TINYINT NOT NULL,
  day_since_prior SMALLINT,
  CONSTRAINT FK_order_products FOREIGN KEY REFERENCES dbo.dim_products(product_sk),
  CONSTRAINT FK_order_users FOREIGN KEY REFERENCES dbo.dim_users(user_sk)
);

--Indexing for fact_orders
CREATE INDEX idx_fact_orders_order ON dbo.fact_orders(order_id); -- usefull for order lookups

CREATE INDEX idx_fact_orders_userorders ON dbo.fact_orders(user_sk, order_number); --usefull for user order analysis
