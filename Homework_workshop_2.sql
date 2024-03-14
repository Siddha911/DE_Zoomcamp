-- query to compute requested data
SELECT AVG(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MIN(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MAX(tpep_dropoff_datetime - tpep_pickup_datetime),
    Zup.zone pickup_zone,
    Zof.zone dropoff_zone
FROM trip_data 
    JOIN taxi_zone Zup ON trip_data.PULocationID = Zup.location_id 
        JOIN taxi_zone Zof ON trip_data.DOLocationID = Zof.location_id 
GROUP BY Zup.zone, Zof.zone;

-- creating a MV for question 1
CREATE MATERIALIZED VIEW avg_min_max_time AS SELECT
    AVG(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MIN(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MAX(tpep_dropoff_datetime - tpep_pickup_datetime),
    Zup.zone pickup_zone,
    Zof.zone dropoff_zone
FROM trip_data 
    JOIN taxi_zone Zup ON trip_data.PULocationID = Zup.location_id 
        JOIN taxi_zone Zof ON trip_data.DOLocationID = Zof.location_id 
GROUP BY Zup.zone, Zof.zone;

-- finding a pair of zones which have a highest average trip time
SELECT CONCAT(pickup_zone, ', ', dropoff_zone) zones,
    AVG average_trip_time
FROM avg_min_max_time
ORDER BY AVG DESC
LIMIT 1;

-- creating a MV for question 2
CREATE MATERIALIZED VIEW num_of_trips AS SELECT
    AVG(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MIN(tpep_dropoff_datetime - tpep_pickup_datetime), 
    MAX(tpep_dropoff_datetime - tpep_pickup_datetime),
    COUNT(*) number_of_trips,
    Zup.zone pickup_zone,
    Zof.zone dropoff_zone
FROM trip_data 
    JOIN taxi_zone Zup ON trip_data.PULocationID = Zup.location_id 
        JOIN taxi_zone Zof ON trip_data.DOLocationID = Zof.location_id 
GROUP BY Zup.zone, Zof.zone;

-- counting a number of trips between a pair of zones with a highest average trip time
SELECT CONCAT(pickup_zone, ', ', dropoff_zone) zones,
    number_of_trips 
FROM num_of_trips
ORDER BY AVG DESC
LIMIT 1;

-- counting 3 busiest zones in terms of number of pickups
WITH max_pu AS (
        SELECT MAX(tpep_pickup_datetime) AS latest_pickup_time
        FROM trip_data
    )
SELECT Zup.zone zone,
    COUNT(*) number_of_pickups
FROM max_pu,
        trip_data
            JOIN taxi_zone Zup ON trip_data.PULocationID = Zup.location_id 
WHERE tpep_pickup_datetime >= (max_pu.latest_pickup_time - INTERVAL '17' HOUR)
GROUP BY Zup.zone
ORDER BY number_of_pickups DESC
LIMIT 3;
