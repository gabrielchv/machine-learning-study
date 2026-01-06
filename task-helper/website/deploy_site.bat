@echo off
cd website
call gcloud run deploy task-helper-site --source . --region southamerica-east1 --allow-unauthenticated
cd ..
pause