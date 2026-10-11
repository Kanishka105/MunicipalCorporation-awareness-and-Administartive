@echo off
cd /d "C:\Users\HP\Desktop\MunicipalCorporation-awareness-and-Administartive"
"C:\Users\HP\AppData\Local\Programs\Python\Python314\python.exe" -m uvicorn backend.main:app --host 127.0.0.1 --port 5000
