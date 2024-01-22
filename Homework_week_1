Answer for Question 1:
  docker run --help | grep 'Automatically remove the container when it exits'
        --rm                             Automatically remove the container when it exits

Answer for Question 2:
  docker run -it python:3.9 bash
  pip list
  Package    Version
  ---------- -------
  pip        23.0.1
  setuptools 58.1.0
  wheel      0.42.0

Answer for Question 3:
  SELECT COUNT(*)
  FROM green_taxi_data
  WHERE DATE(lpep_pickup_datetime) = '2019-09-18'
	  AND DATE(lpep_dropoff_datetime) = '2019-09-18';

Answer for Question 4:
  SELECT DATE(lpep_pickup_datetime),
	   SUM(trip_distance)
  FROM green_taxi_data
  GROUP BY DATE(lpep_pickup_datetime)
  ORDER BY 2 DESC
  LIMIT 1;

Answer for Question 5:
  SELECT zpu."Borough",
	   SUM(t."total_amount")
  FROM green_taxi_data t,
	 zones zpu
  WHERE t."PULocationID" = zpu."LocationID" AND
	  DATE(t."lpep_pickup_datetime") = '2019-09-18' AND
	  zpu."Borough" IS NOT Null
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 3;

Answer for Question 6:
  SELECT zpu."Zone",
	   zdo."Zone",
	   MAX(t."tip_amount")
  FROM green_taxi_data t
  JOIN
	 zones zpu ON t."PULocationID" = zpu."LocationID"
  JOIN 
	 zones zdo ON t."DOLocationID" = zdo."LocationID"
  WHERE EXTRACT(month FROM t."lpep_pickup_datetime") = 9 
	  AND zpu."Zone" = 'Astoria'
  GROUP BY 1, 2
  ORDER BY 3 DESC
  LIMIT 1;

Answer for Question 7:
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.demo_dataset will be created
  + resource "google_bigquery_dataset" "demo_dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "demo_dataset"
      + default_collation          = (known after apply)
      + delete_contents_on_destroy = false
      + effective_labels           = (known after apply)
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + is_case_insensitive        = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "US"
      + max_time_travel_hours      = (known after apply)
      + project                    = "dezoomcamp-409909"
      + self_link                  = (known after apply)
      + storage_billing_model      = (known after apply)
      + terraform_labels           = (known after apply)
    }

  # google_storage_bucket.demo-bucket will be created
  + resource "google_storage_bucket" "demo-bucket" {
      + effective_labels            = (known after apply)
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "US"
      + name                        = "409909-bucket"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + terraform_labels            = (known after apply)
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "AbortIncompleteMultipartUpload"
            }
          + condition {
              + age                   = 1
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.demo_dataset: Creating...
google_storage_bucket.demo-bucket: Creating...
google_bigquery_dataset.demo_dataset: Creation complete after 1s [id=projects/dezoomcamp-409909/datasets/demo_dataset]
google_storage_bucket.demo-bucket: Creation complete after 2s [id=409909-bucket]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
