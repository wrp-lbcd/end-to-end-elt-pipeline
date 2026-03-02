from google.cloud import storage, bigquery

SERVICE_ACCOUNT_PATH = "/Users/mew/Desktop/my_project_05/keys/service_account.json"
storage_client = storage.Client.from_service_account_json(SERVICE_ACCOUNT_PATH)
bq_client = bigquery.Client.from_service_account_json(SERVICE_ACCOUNT_PATH)

bucket_name = "my-project-bucket-05-488906"
local_file = "/Users/mew/Desktop/my_project_05/nyc_taxi.parquet"
destination_blob_name = "raw/nyc_taxi.parquet"

def upload_to_gcs(bucket_name, local_file, destination_blob_name):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(local_file)
    print(f"Uploaded to gs://{bucket_name}/{destination_blob_name}")

def load_to_bigquery(bucket_name, destination_blob_name):
    project_id = "my-project-05-488906"
    dataset_id = "bronze" 
    table_id = "nyc_taxi"

    table_ref = f"{project_id}.{dataset_id}.{table_id}"
    uri = f"gs://{bucket_name}/{destination_blob_name}"

    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.PARQUET,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
    )

    load_job = bq_client.load_table_from_uri(
        uri,
        table_ref,
        job_config=job_config,
    )

    load_job.result()

    destination_table = bq_client.get_table(table_ref)
    print("Loaded {} rows.".format(destination_table.num_rows))

upload_to_gcs(bucket_name, local_file, destination_blob_name)
load_to_bigquery(bucket_name, destination_blob_name)
