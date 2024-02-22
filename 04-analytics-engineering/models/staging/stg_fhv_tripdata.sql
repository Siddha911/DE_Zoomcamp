{{
    config(
        materialized='view'
    )
}}

with data as 
(
  select *
  from {{ source('staging','fhv_tripdata') }}
)
select 
    dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(drop_off_datetime as timestamp) as dropoff_datetime,
    p_ulocation_id as pickup_locationid,
    d_olocation_id as dropoff_locationid,
    sr_flag,
    affiliated_base_number
from data
where extract(YEAR FROM cast(pickup_datetime as timestamp)) = 2019