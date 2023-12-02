WITH src_budget_products AS (
    SELECT *
    FROM {{ source('google_sheets', 'budget') }}
),

renamed_casted AS (
    SELECT
        cast(_row as number(10,0)) as _row,
        cast(product_id as varchar(75)) as id_product,
        cast(quantity as integer) as quantity,
        month,
        _fivetran_synced as raw_timestamp_load
    FROM src_budget_products
)

SELECT * FROM renamed_casted