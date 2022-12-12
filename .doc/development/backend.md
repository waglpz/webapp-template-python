## Backend development

#### How to install Python virtual environment on host for using with IDE PySharm

After docker compose is starting first time, please run script: `bash api/bin/venv-sync.sh` and install virtual environment for Python. 
This one will copy the content of `venv` folder from backend container into locale directory under api.
After then, you should enable this in IDE via settings: "Add new Interpreter".
To remove or reset virtual environment run: `bash api/bin/venv-sync.sh rm`.

