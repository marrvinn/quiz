@ECHO Off

pushd %~dp0

:: Dev commands for setup and testing.

IF "%1" == "setup_dev" (
    goto setup_dev
)

IF "%1" == "run_tests" (
    goto run_tests
)

ECHO "UNKNOWN COMMAND"
goto end

:: Setup
:setup-dev
python -m pip install --upgrade pip
python -m pip install --upgrade poetry
python -m poetry sync --with dev,stubs
pre-commit install
goto end

:: Tests
:run-tests
python -m pip install --upgrade pip
python -m pip install --upgrade poetry
python -m poetry sync --with dev,stubs
pre-commit install
poetry run ruff format
poetry run ruff check --fix
poetry run mypy src
poetry run pytest
goto end

:end
popd
:: End of script
