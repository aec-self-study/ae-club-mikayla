{{config(
    materialized='table'
    )
}}

WITH customer_orders AS (

    SELECT
        customer_id,
        count(*) AS n_orders,
        min(created_at) AS first_order_at
    FROM `analytics-engineers-club.coffee_shop.orders` 
    GROUP BY 1

),

final AS (
    SELECT 
        customers.id AS customer_id,
        customers.name,
        customers.email,
        coalesce(customer_orders.n_orders, 0) AS n_orders,
        customer_orders.first_order_at
    FROM `analytics-engineers-club.coffee_shop.customers` AS customers
    LEFT JOIN customer_orders
        ON customers.id = customer_orders.customer_id 
    LIMIT 5

)

 SELECT * FROM final