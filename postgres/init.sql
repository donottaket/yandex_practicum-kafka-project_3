CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100),
    email      VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (id, name, email)
SELECT i,
       'Name_' || i || '_' || substring('abcdefghijklmnopqrstuvwxyz', (random() * 26) ::integer + 1, 1),
       'Email_' || i || '_' || substring('abcdefghijklmnopqrstuvwxyz', (random() * 26)::integer + 1, 1)
FROM generate_series(1, 500000) AS i;

CREATE TABLE orders
(
    id           SERIAL PRIMARY KEY,
    user_id      INT,
    product_name VARCHAR(100),
    quantity     INT,
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders (id, user_id, product_name, quantity)
SELECT i,
       i,
       'Product_Name_' || i || '_' || substring('abcdefghijklmnopqrstuvwxyz', (random() * 26) ::integer + 1, 1),
       (random() * 100)::integer + 1
FROM generate_series(1, 500000) AS i;