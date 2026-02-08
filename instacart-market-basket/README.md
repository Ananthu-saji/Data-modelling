# Instacart Data Warehouse

## Overview

This is a data model implemented based on Kimball star schema for Instacart Market Basket Dataset, trasnforming raw data into business ready facts and dimension table optimized for basket analysis, order pattern, products and costomer behaviour insights.

Data source : https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis/data

## Key features

1. **Star schema**   - Fact table (orders) + Dimensions tables.
2. **Surrogate Key** - IDENTITY Primary Key for SCD flexibility.
3. **Granularity**   - facts = one row per order, dimension = unique business constraints.
4. **Optimization**  - Indexed for order, user, product queries.


## Schema overview

 Table | Type | Key Columns | Purpose |
|-------|------|-------------|---------|
| dim_users | Dimension | user_sk (PK), user_id | User profiles |
| dim_aisles | Dimension | aisle_sk (PK), aisle_id, description | Product aisles |
| dim_departments | Dimension | department_sk (PK), department_id, name | Dept hierarchy |
| dim_products | Dimension | product_sk (PK), product_id, name, aisle_sk, dept_sk | Products w/ hierarchy |
| fact_orders | Fact | order_id (PK), product_sk, user_sk, order_dow, hour, days_since_prior | Order metrics |


## ERD Diagram

<img width="1050" height="906" alt="Instacart_ERD" src="https://github.com/user-attachments/assets/d605cb37-0a14-41af-8d89-1338edeec61b" />


## Data Flow order (ETL Flow Sequence)

**ETL Load Sequence** - Dimensions dim_users, dim_aisles, and dim_departments can be ingested in parallel as they have no inter-table dependencies. Once complete, load dim_products (which references aisles and departments), followed by fact_orders (which lookups user and product surrogate keys).

## Quick Start

### Prerequisites
- SQL Server + SSMS (free Express works)

### Setup Procedure
- **Step 1** <br>
Clone Repo - `git clone https://github.com/[Ananthu-saji/Data-Modeling.git`
- **Step 2** <br>
Move to Instacart-market-basket folder - `cd Data-Modeling/Instacart-market-basket`
- **Step 3**<br>
Open **Instacart_DB_DDL.sql** in SSMS, Connect to your SQL Serve, and run enitre file in the given defined order.


###  Verify Success
```sql
USE Instacart_DB;

SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES;  -- Returns 5








