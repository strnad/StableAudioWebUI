#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR" || exit

# Create a virtual environment
python -m venv venv || { echo "Failed to create venv"; exit 1; }

# Activate the virtual environment
source venv/bin/activate || { echo "Failed to activate venv"; exit 1; }

# Install requirements
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 || { echo "Failed to install PyTorch"; exit 1; }
pip install -r requirements.txt || { echo "Failed to install requirements"; exit 1; }

echo "Installation completed successfully."
