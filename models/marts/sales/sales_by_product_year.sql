/*El equipo de ventas necesita conocer para cada producto:

El nombre y el precio del producto
El número de unidades vendidas y el total facturado
El número de unidades devueltas y el total reembolsado
El número de unidades presupuestadas y el total esperado
La diferencia entre lo presupuestado y lo vendido
El ranking de los productos más vendidos por año*/

with

fct_orders_items as (

    select * from {{ ref('fct_orders_items') }}

),

dim_products as (

    select * from {{ ref('dim_products') }}

),

fct_budget as (
    
    select * from {{ ref('fct_budget') }}

),

sales_by_product_year as (
    select
        p.id_product,
        p.name as product_name,
        p.price as product_price,
        extract(year from f.created_at_utc) as year,
        sum(f.quantity) as units_sold,
        sum(f.total_product_cost_usd) as sales_amount,
        sum(case when f.status = 'Returned' then f.quantity else 0 end) as units_returned,
        sum(case when f.status = 'Returned' then f.total_product_cost_usd else 0 end) as refund_amount
    from fct_orders_items f
    join dim_products p on f.id_product = p.id_product
    group by p.id_product, p.name, p.price, extract(year from f.created_at_utc)
),
budget_by_product_year as (
    select
        p.id_product,
        p.name as product_name,
        p.price as product_price,
        extract(year from b.month) as year,
        sum(b.quantity) as units_budgeted,
        sum(b.quantity * p.price) as budget_amount
    from fct_budget b
    join dim_products p on b.id_product = p.id_product
    group by p.id_product, p.name, p.price, extract(year from b.month)
)
select
    s.id_product,
    s.product_name,
    s.product_price,
    s.year,
    s.units_sold,
    s.sales_amount,
    s.units_returned,
    s.refund_amount,
    coalesce(b.units_budgeted, 0) as units_budgeted,
    coalesce(b.budget_amount, 0) as budget_amount,
    coalesce(s.units_sold, 0) - coalesce(b.units_budgeted, 0) as units_difference,
    coalesce(s.sales_amount, 0) - coalesce(b.budget_amount, 0) as amount_difference,
    rank() over (partition by s.year order by s.sales_amount desc) as sales_rank
from sales_by_product_year s
left join budget_by_product_year b on s.id_product = b.id_product and s.year = b.year
order by s.year, sales_rank
