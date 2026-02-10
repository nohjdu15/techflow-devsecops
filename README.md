# TechFlow DevSecOps - Azure Container Apps

Solucion serverless con contenedores para una API critica. Incluye IaC con Terraform modular, app Python, job programado, secrets en Key Vault con Managed Identity, y pipeline CI/CD con escaneo de seguridad.

## Arquitectura

- Azure Key Vault para secretos
- Azure Container Registry para imagenes
- Azure Container Apps Environment
- Azure Container App (API) con init container y secreto inyectado
- Azure Container App Job (cron)
- Azure DevOps Pipelines para build, scan, push y deploy

## Estructura del repo

- app/: API FastAPI
- job/: Job de mantenimiento
- infra/: Terraform modular
- .github/workflows/: Pipeline CI/CD
- PROMPTS.md: prompts usados

## Requisitos

- Azure Subscription con permisos de Owner o Contributor
- Azure CLI
- Terraform >= 1.5
- Docker
- GitHub repo

## Paso a paso (Git Flow)

1) Inicializa el repo y ramas

```bash
git init
git checkout -b main
git checkout -b develop
git checkout -b feature/infra-setup
```

2) Configura variables/secretos en Azure DevOps

- Crea un Service Connection a Azure (ARM)
- Crea un Variable Group con secretos:
	- ACR_NAME
	- ACR_LOGIN_SERVER
	- MY_SECRET
	- AZURE_SERVICE_CONNECTION (nombre del service connection)

Valores actuales:

- AZURE_SERVICE_CONNECTION: sc-techflow-dev
- Resource Group: rg-techflow-dev

3) Crea el Service Principal

- Crea un Service Principal con rol Contributor al scope de la suscripcion o RG
- Asocialo al Service Connection de Azure DevOps

4) Bootstrap local (una sola vez)

Este paso crea la infraestructura base para poder hacer push al ACR.

```bash
cd infra
terraform init
terraform apply -var "secret_value=valor-inicial"
```

5) Push a la rama feature/infra-setup

```bash
git add .
git commit -m "feat: infra y app inicial"
git push -u origin feature/infra-setup
```

6) Simula PR hacia develop

- Abre un Pull Request en Azure DevOps de feature/infra-setup -> develop
- Revisa el pipeline y los escaneos

7) Merge a develop

- El pipeline compila, escanea, sube imagenes y hace terraform apply

## Ejecutar localmente

API:

```bash
cd app
python -m venv .venv
source .venv/bin/activate  # En Windows usa .venv\Scripts\activate
pip install -r requirements.txt
MY_SECRET=local-secret uvicorn main:app --reload --port 8000
```

Job:

```bash
cd job
python main.py
```

## Uso en Azure

- La API expone / y /health
- El secreto se inyecta como MY_SECRET desde Key Vault
- El job imprime "Job ejecutado con exito"

## Variables Terraform

- prefix: prefijo de recursos (default techflow)
- location: region (default eastus)
- secret_value: valor del secreto (sensitive)
- app_image_tag y job_image_tag: tags de imagen

## CI/CD

Pipeline en [azure-pipelines.yml](azure-pipelines.yml):

- Build Docker (app y job)
- Trivy scan (imagenes)
- Checkov scan (Terraform)
- Push a ACR
- terraform apply (en pushes a develop/main)

## Notas de seguridad

- No hay secretos en el codigo ni en Dockerfile
- Key Vault se accede via Managed Identity
- Escaneo de IaC con Checkov

## URL del repositorio

- Reemplaza este texto con la URL de tu repo una vez creado