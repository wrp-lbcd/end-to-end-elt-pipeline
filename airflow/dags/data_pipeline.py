
from airflow.sdk import dag, task
from datetime import datetime


DBT_PROJECT_DIR = "/opt/airflow/dbt_05"

@dag(dag_id="data_pipeline", 
     schedule="@daily", 
     start_date=datetime(2024, 1, 1),
     catchup=False
     )
def data_pipeline():

    @task.bash
    def run_dbt_silver():
        return f"""
        cd {DBT_PROJECT_DIR} &&
        dbt build --select silver_clean
        """

    @task.bash
    def run_dbt_gold():
        return f"""
        cd {DBT_PROJECT_DIR} &&
        dbt build --select gold_trip_daily
        """

    t1 = run_dbt_silver() 
    t2 = run_dbt_gold()

    t1 >> t2

data_pipeline()

