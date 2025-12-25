@echo off
set PROJECT_ID=machine-learning-study-481717
:: Gerando um nome de bucket único (letras minúsculas apenas)
set BUCKET_NAME=gs://taxi-fare-model-%RANDOM%
set REGION=us-central1

echo [1/3] Configurando projeto: %PROJECT_ID%
call gcloud config set project %PROJECT_ID%

echo [2/3] Criando Bucket no Google Cloud Storage...
:: O 'call' evita que o script feche prematuramente
call gcloud storage buckets create %BUCKET_NAME% --location=%REGION%

echo [3/3] Enviando modelo exportado para o GCS...
:: Certifique-se de que a pasta 'taxi_fare_model' existe aqui
if exist taxi_fare_model (
    call gcloud storage cp -r taxi_fare_model %BUCKET_NAME%/v1/
) else (
    echo ERRO: Pasta taxi_fare_model nao encontrada! rode o model.export no Python primeiro.
    goto :end
)

echo.
echo =======================================================
echo UPLOAD CONCLUIDO COM SUCESSO!
echo URI para o Vertex AI: %BUCKET_NAME%/v1/
echo =======================================================

:end
pause