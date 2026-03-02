select
    -- identifiers
    hvfhs_license_num,
    dispatching_base_num,
    originating_base_num,

    -- timestamps
    cast(request_datetime as timestamp)      as request_ts,
    cast(on_scene_datetime as timestamp)     as on_scene_ts,
    cast(pickup_datetime as timestamp)       as pickup_ts,
    cast(dropoff_datetime as timestamp)      as dropoff_ts,

    date(pickup_datetime)                    as pickup_date,
    extract(hour from pickup_datetime)       as pickup_hour,

    -- locations
    cast(PULocationID as int64)               as pu_location_id,
    cast(DOLocationID as int64)               as do_location_id,

    -- trip metrics
    cast(trip_miles as float64)               as trip_miles,
    cast(trip_time as int64)                  as trip_time_seconds,

    -- money
    cast(base_passenger_fare as numeric)     as base_fare,
    cast(tolls as numeric)                   as tolls,
    cast(tips as numeric)                    as tips,
    cast(driver_pay as numeric)              as driver_pay,

    -- flags → boolean
    shared_request_flag = 'Y'                as is_shared_request,
    shared_match_flag = 'Y'                  as is_shared_match,
    access_a_ride_flag = 'Y'                 as is_access_a_ride,
    wav_request_flag = 'Y'                   as is_wav_request,
    wav_match_flag = 'Y'                     as is_wav_match

from {{ source('bronze', 'nyc_taxi') }}