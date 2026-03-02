select
    pickup_date,

    -- metrics
    count(*)                                   as total_trips,
    sum(trip_miles)                            as total_trip_miles,
    sum(trip_time_seconds)                    as total_trip_time_seconds,
    sum(base_fare)                            as total_base_fare,
    sum(tolls)                                as total_tolls,
    sum(tips)                                 as total_tips,
    sum(driver_pay)                           as total_driver_pay,

    -- averages
    avg(trip_miles)                           as avg_trip_miles,
    avg(trip_time_seconds)                   as avg_trip_time_seconds,
    avg(base_fare)                           as avg_base_fare,

    -- flags (business-friendly)
    sum(case when is_shared_request then 1 else 0 end) as shared_request_trips,
    sum(case when is_wav_request then 1 else 0 end)    as wav_request_trips

from {{ ref('silver_clean') }}

group by pickup_date