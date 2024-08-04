{{config(
    materialized='table'
    )
}}

SELECT
    DATE_TRUNC(first_order_at, month)       AS signup_month,
    COUNT(*)                                AS new_customers
 
FROM {{ ref('customers') }}
GROUP BY 1