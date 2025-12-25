@echo off
echo [1/3] Criando ambiente virtual...
python -m venv venv

echo [2/3] Ativando venv e instalando dependencias...
call .\venv\Scripts\activate
pip install -r requirements.txt

echo [3/3] Registrando Kernel no Jupyter...
python -m ipykernel install --user --name=taxi-project --display-name "Python (Taxi Project)"

echo Pronto! O ambiente esta configurado.
pause