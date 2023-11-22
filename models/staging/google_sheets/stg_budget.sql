WITH src_budget_products AS (
    SELECT *
    FROM {{ source('google_sheets', 'budget') }}
),

renamed_casted AS (
    SELECT
        _row,
        cast(product_id as varchar(75)) as id_product,
        cast(quantity as integer) as quantity,
        month,
        _fivetran_synced AS date_load
    FROM src_budget_products
)

SELECT * FROM renamed_casted