
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    order_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE order_audit (
    audit_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_product_name TEXT,
    new_product_name TEXT,
    old_quantity INTEGER,
    new_quantity INTEGER
);

CREATE OR REPLACE FUNCTION log_order_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO order_audit (
        order_id,
        changed_at,
        old_product_name,
        new_product_name,
        old_quantity,
        new_quantity
    )
    VALUES (
        OLD.order_id,
        CURRENT_TIMESTAMP,
        OLD.product_name,
        NEW.product_name,
        OLD.quantity,
        NEW.quantity
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_order_update
AFTER UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION log_order_update();
