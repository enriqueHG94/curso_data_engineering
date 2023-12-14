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


user_orders as (
    select
        f.id_user,
        count(distinct f.id_order) as total_orders,
        sum(f.total_product_cost_usd) as total_spent,
        sum(f.shipping_cost_per_product_line) as total_shipping,
        sum(f.total_product_cost_usd * (coalesce(p.discount, 0) / 100))
            as total_discount,
        sum(f.quantity) as total_products,
        count(distinct f.id_product) as total_different_products
    from fct_orders_items as f
    left join dim_promos as p on f.id_promo = p.id_promo
    group by f.id_user
),

user_data as (
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
        a.country
    from dim_users as u
    left join dim_addresses as a on u.id_address = a.id_address
)

select
    ud.*,
    uo.total_orders,
    uo.total_spent,
    uo.total_shipping,
    uo.total_discount,
    uo.total_products,
    uo.total_different_products
from user_data as ud
inner join user_orders as uo on ud.id_user = uo.id_user
order by ud.id_user
