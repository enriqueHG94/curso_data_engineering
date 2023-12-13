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

-- Crea una tabla temporal con los datos de ventas por producto y año 
sales_by_product_year as ( 
    select 
        p.id_product, 
        p.name as product_name, 
        p.price as product_price, 
        year(o.created_at_utc) as year, 
        sum(o.quantity) as units_sold, 
        sum(o.quantity * p.price) as sales_amount, 
        sum(case when o.status = 'Returned' then o.quantity else 0 end) as units_returned, 
        sum(case when o.status = 'Returned' then o.quantity * o.item_order_cost_usd else 0 end) as refund_amount 
    from fct_orders_items as o 
    inner join dim_products as p 
    on o.id_product = p.id_product 
    group by p.id_product, p.name, p.price, year(o.created_at_utc) 
    ),

-- Crea una tabla temporal con los datos de presupuesto por producto y año 
budget_by_product_year as ( 
    select 
        p.id_product, 
        p.name as product_name, 
        p.price as product_price, 
        year(b.month) as year, 
        sum(b.quantity) as units_budgeted, 
        sum(b.quantity * p.price) as budget_amount 
        from fct_budget as b 
        inner join dim_products as p 
        on b.id_product = p.id_product 
        group by p.id_product, p.name, p.price, year(b.month) 
        )

-- Crea la tabla final con la información de cada producto por año 
select 
    s.id_product, 
    s.product_name, 
    s.product_price, 
    s.year, 
    s.units_sold, 
    s.sales_amount, 
    s.units_returned, 
    s.refund_amount, 
    b.units_budgeted, 
    b.budget_amount, 
    s.units_sold - b.units_budgeted as units_difference, 
    s.sales_amount - b.budget_amount as amount_difference, 
    rank() over (partition by s.year order by s.sales_amount desc) as sales_rank 
from sales_by_product_year as s 
left join budget_by_product_year as b 
on s.id_product = b.id_product and s.year = b.year 
order by s.year, sales_rank