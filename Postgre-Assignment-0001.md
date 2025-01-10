# Database Schema Assignment

## Objective
This assignment requires you to design and implement a database schema for a basic e-commerce website. The primary components will include tables for users and orders, along with a trigger to log updates made to the orders in a separate audit table.

## Requirements
- **PostgreSQL**: Make sure PostgreSQL is installed on your system. You can download it from [the official PostgreSQL website](https://www.postgresql.org/download/).
- **Tools**: Use pgAdmin4 or the command line tool (psql) for interacting with the PostgreSQL database.

## Tasks

### Task 1: Create 'users' Table

#### Columns
- `user_id`: Primary key, auto-increment.
- `username`: Text, must be unique.
- `email`: Text, must be unique.
- `created_at`: Timestamp, default to the current date and time.
- `updated_at`: Timestamp, default to the current date and time.


### Task 2: Create 'orders' Table

#### Columns
- order_id: Primary key, auto-increment.
- user_id: Foreign key linked to users.user_id.
- product_name: Text.
- quantity: Integer.
- order_date: Date.
- SQL Command
- sql

### Task 3: Create 'order_audit' Table

#### Purpose
##### To store changes made to the orders.

##### Columns
- audit_id: Primary key, auto-increment.
- order_id: Integer, references order_id from the orders table.
- changed_at: Timestamp, default to the current date and time.
- old_product_name: Text.
- new_product_name: Text.
- old_quantity: Integer.
- new_quantity: Integer.


### Task 4: Create a Trigger to Log Updates
#### Objective
#### Any update to orders should log the old and new values in order_audit.
