@echo off
echo [1/3] Creating virtual environment...
python -m venv venv

echo [2/3] Activating venv and installing dependencies...
call .\venv\Scripts\activate
pip install -r requirements.txt

echo [3/3] Registering Kernel in Jupyter...
python -m ipykernel install --user --name=taxi-project --display-name "Python (Taxi Project)"

echo Done! Environment configured.
pause