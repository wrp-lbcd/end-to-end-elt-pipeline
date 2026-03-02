SELECT *
FROM {{ source('bronze', 'nyc_taxi') }}