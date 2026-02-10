# Prompts clave

- "Genera una API minimalista en FastAPI que lea la variable de entorno MY_SECRET y responda en JSON. Incluye un endpoint /health."
- "Crea un Dockerfile para FastAPI usando python:3.11-slim, expone el puerto 8000 y ejecuta uvicorn."
- "Genera Terraform modular para Azure Container Apps con Key Vault, ACR, Container Apps Environment, una Container App con init container y un Container App Job con cron. Usa Managed Identity para Key Vault."
- "Crea un pipeline de Azure DevOps (azure-pipelines.yml) con build, escaneo (Trivy + Checkov), push a ACR y terraform apply."
- "Documenta en el README el paso a paso con Git Flow y las variables necesarias en Azure DevOps (Service Connections y Variable Groups)."
- "Crea un Azure Container App Job en Terraform que ejecute una imagen de Python y termine mostrando 'Job ejecutado con exito'."
- "Escribe un Dockerfile minimalista para un job de Python que solo ejecute main.py y termine."
- "Genera el bloque de Terraform para Azure Key Vault con soft delete y purge protection habilitados, sin exponer secretos en el codigo."
- "Escribe el bloque de identidad SystemAssigned y las access_policies necesarias para que una Azure Container App lea secretos de Key Vault usando Managed Identity."
- "Crea un workflow de GitHub Actions que haga build de dos imagenes Docker, las escanee con Trivy, ejecute Checkov sobre infra/, haga login en ACR y ejecute terraform apply solo en ramas main/develop."
- "Agrega configuracion de Trivy y Checkov en el pipeline para que fallen solo en vulnerabilidades criticas pero sigan reportando hallazgos de severidad HIGH."
- "Sugiere una seccion CI/CD en el README que explique las dos opciones: Azure DevOps y GitHub Actions, indicando triggers y fases del pipeline."
