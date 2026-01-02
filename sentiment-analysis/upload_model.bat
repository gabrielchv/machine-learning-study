@echo off
set PROJECT_ID=machine-learning-study-481717
:: Generating a unique bucket name (lowercase only)
set BUCKET_NAME=gs://sentiment-analysis-model-%RANDOM%
set REGION=us-central1

echo [1/3] Configuring project: %PROJECT_ID%
call gcloud config set project %PROJECT_ID%

echo [2/3] Creating Bucket in Google Cloud Storage...
:: The 'call' command prevents the script from closing prematurely
call gcloud storage buckets create %BUCKET_NAME% --location=%REGION%

echo [3/3] Uploading exported model to GCS...
:: Ensure that the 'sentiment_analysis_model' folder exists here
if exist sentiment_analysis_model (
    call gcloud storage cp -r sentiment_analysis_model %BUCKET_NAME%/v1/
) else (
    echo ERROR: 'sentiment_analysis_model' folder not found! Run model.export in Python first.
    goto :end
)

echo.
echo =======================================================
echo UPLOAD SUCCESSFUL!
echo =======================================================

:end
pause