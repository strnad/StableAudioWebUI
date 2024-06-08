@echo off

:: Set the script directory
set SCRIPT_DIR=%~dp0

:: Path to your Miniconda installation
set CONDA_PATH=%SCRIPT_DIR%miniconda

:: Check if Miniconda is already installed
if not exist "%CONDA_PATH%" (
    echo Miniconda is not installed. Downloading and installing Miniconda...
    curl -o miniconda.exe https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe

    echo Installing Miniconda...
    start /wait "" miniconda.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%CONDA_PATH%

    echo Cleaning up installer...
    del miniconda.exe
) else (
    echo Miniconda is already installed in %CONDA_PATH%. Skipping installation.
)

:: Initialize Conda for this script session only
call "%CONDA_PATH%\Scripts\activate.bat"

:: Remove the existing environment if it exists
call conda env list | findstr stableaudio
if %errorlevel% equ 0 (
    echo Removing existing conda environment...
    call conda remove --name stableaudio --yes --quiet
)

:: Create a new environment
call conda create -n stableaudio python=3.11 -y

:: Ensure the environment is activated and install the necessary packages
call conda run -n stableaudio conda install -y packaging
call conda run -n stableaudio pip install -r requirements.txt

:: Check if .env file exists, if not copy .env_example to .env
if not exist "%SCRIPT_DIR%.env" (
    echo .env file does not exist. Copying .env_example to .env...
    copy "%SCRIPT_DIR%.env_example" "%SCRIPT_DIR%.env"
)


echo Installation completed successfully. Do not forget to update the .env file with your credentials. Then run run_conda.bat to start the app.
pause
