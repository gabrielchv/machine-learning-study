@echo off
cd cloud-function
call gcloud functions deploy task-helper --gen2 --runtime python310 --trigger-http --allow-unauthenticated --entry-point handle_request --region southamerica-east1
cd ..
pause