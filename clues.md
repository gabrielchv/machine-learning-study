*** THIS FILE CONTAINS COMMANDS COMMONLY USED TO CREATE THE MACHINE-LEARNING PROJECTS ***


### CREATE PYTHON VIRTUAL ENVIRONMENT
```bash 
python -m venv venv 
```

### ACTIVATE VENV (Windows) 
```bash 
.\venv\Scripts\activate
```

### ACTIVATE VENV (Linux)
```bash 
source venv/bin/activate
```

### INSTALL DEPENDENCIES (Windows/Linux/Mac)
```bash 
pip install -r requirements.txt
```

### ADD KERNEL TO JUPYTER (Windows/Linux/Mac)
```bash 
python -m ipykernel install --user --name=taxi-project --display-name "Python (Taxi Project VENV)"
```