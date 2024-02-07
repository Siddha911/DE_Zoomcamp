-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp-409909.ny_taxi.external_green_taxi_2022`
OPTIONS (
  format = 'parquet',
  uris = ['gs://mage-zoomcamp-cyril/green_taxi_2022/d1b7c7893d7e45db8f3db6d2fb80d767-0.parquet']
);

-- Test query
SELECT * FROM ny_taxi.external_green_taxi_2022 LIMIT 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE ny_taxi.green_taxi_non_partitoned AS
SELECT * FROM ny_taxi.external_green_taxi_2022;

-- Count the distinct number of PULocationIDs for the external table
SELECT DISTINCT PULocationID
FROM ny_taxi.external_green_taxi_2022;

-- Count the distinct number of PULocationIDs for the BQ table
SELECT DISTINCT PULocationID
FROM ny_taxi.green_taxi_non_partitoned;

-- Count fare_amount columns equals to zero
SELECT COUNT(*)
FROM ny_taxi.green_taxi_non_partitoned
WHERE fare_amount = 0;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE ny_taxi.green_taxi_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM ny_taxi.external_green_taxi_2022;

-- A query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 from nonpartitioned table
SELECT DISTINCT PULocationID 
FROM `ny_taxi.green_taxi_non_partitoned`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

-- A query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 from partitioned and clustered table
SELECT DISTINCT PULocationID 
FROM `ny_taxi.green_taxi_partitoned_clustered`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
