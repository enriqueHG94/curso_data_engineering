/*El equipo de producto necesita conocer para cada usuario todo lo referente a las compras que ha realizado. Para ello nos solicitan que indiquemos:

- Toda la información disponible del usuario
- Número de pedidos totales que ha realizado
- Total gastado
- Total de gastos de envío
- Descuento total
- Total de productos que ha comprado
- Total de productos diferentes que ha comprado.*/

with

fct_orders_items as (

    select * from {{ ref('fct_orders_items') }}

),

dim_users as (

    select * from {{ ref('dim_users') }}

),

dim_promos as (

    select * from {{ ref('dim_promos') }}
),

dim_addresses as (

    select * from {{ ref('dim_addresses') }}

),

-- Pedidos y las líneas de detalle agrupados por usuario y diferentes cálculos para cada usuario.
user_orders as (
    select
        id_user,
        count(distinct id_order) as total_orders,
        sum(order_total_usd) as total_spent,
        sum(shipping_cost_usd) as total_shipping,
        sum(order_total_usd * p.discount / 100) as total_discount,
        sum(quantity) as total_products,
        count(distinct id_product) as total_different_products
    from fct_orders_items as o
    inner join dim_promos as p on o.id_promo = p.id_promo
    group by id_user
)

-- Tabla final con la información de cada usuario
select
    u.id_user,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_profile,
    u.updated_profile,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    o.total_orders,
    o.total_spent,
    o.total_shipping,
    o.total_discount,
    o.total_products,
    o.total_different_products
from dim_users as u
inner join user_orders as o on u.id_user = o.id_user
inner join dim_addresses as a on u.id_address = a.id_address
order by u.id_user
