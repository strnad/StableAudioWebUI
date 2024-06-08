@echo off
echo Creating virtual environment...
python -m venv venv
if %errorlevel% neq 0 (
    echo Failed to create venv
    exit /b %errorlevel%
)

echo Activating virtual environment...
call venv\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo Failed to activate venv
    exit /b %errorlevel%
)

echo Installing requirements...
pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu124
pip install -r requirements.txt --no-cache
if %errorlevel% neq 0 (
    echo Failed to install requirements
    exit /b %errorlevel%
)



echo Installation completed successfully. Use run_venv.bat to run the app

