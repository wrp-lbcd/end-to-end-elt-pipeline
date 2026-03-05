# end-to-end-elt-pipeline

<img width="638" height="363" alt="Screenshot 2569-03-02 at 20 34 03" src="https://github.com/user-attachments/assets/2f50dcc2-9dac-429c-8a61-7f71f21582cb" />


## Project Overview
โปรเจคนี้สาธิตการสร้าง ELT pipeline ตั้งแต่ต้นทางจนถึงข้อมูลที่พร้อมใช้งานเชิงวิเคราะห์ โดยโปรเจคมีหลักแนวคิดดังนี้:
- เก็บข้อมูลดิบ (raw data) ไว้ก่อนใน Google Cloud Storage และ BigQuery Bronze layer โดยไม่แปลงข้อมูลตั้งแต่ต้น
- ทำ Data transformation ทั้งหมดใน Data warehouse ด้วย dbt
- ใช้ Airflow สำหรับ orchestration เท่านั้น
- ใช้ Docker เพื่อให้ environment คงที่และ reproducible
- Pipeline ถูกออกแบบตามแนวคิด Medallion Architecture (bronze, silver, gold)

## Tech Stack
- Apache Airflow (v3.1.7)
- dbt (BigQuery adapter)
- Google BigQuery
- Google Cloud Storage
- Docker & Docker Compose
- Python 3.11

## Data Layers
### Bronze
- ข้อมูลดิบที่โหลดจาก GCS เข้า BigQuery
- ผ่านการแปลงข้อมูลน้อยที่สุด
- ใช้เป็น source of truth

### Silver
- ข้อมูลที่ผ่านการทำความสะอาดและจัดรูปแบบ
- เปลี่ยนชื่อ column และ cast type
- จัดการ timestamp ให้อยู่ในรูปแบบที่ถูกต้อง
- สร้าง boolean flags จากค่า indicator
- สร้างคอลัมน์วันที่และเวลา
- ไม่มี aggregation

### Gold
- ข้อมูลระดับ analytics-ready
- มีการ aggregate และคำนวณ metric
- ออกแบบสำหรับ dashboard

## วิธีรันโปรเจค (Local)
### สิ่งที่ต้องเตรียม
- Docker & Docker Compose
- Google Cloud Project
- Service account ที่มีสิทธิ์เข้าถึง Cloud Storage, BigQuery, Compute Engine

### ขั้นตอน
- วางไฟล์ service account key ไว้ที่: keys/service_account.json
- สตาร์ท Airflow: docker compose up -d
- เข้า Airflow UI: http://localhost:8080
- Trigger DAG จากหน้า UI
