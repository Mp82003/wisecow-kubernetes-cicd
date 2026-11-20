# isecow-kubernetes-cicd
Containerization and Kubernetes deployment of Wisecow application with Docker, GitHub Actions CI/CD, and TLS security.


# AccuKnox DevOps Trainee Practical Assessment

## Problem Statement 1: Wisecow Application on Kubernetes

### Project Overview
Containerized the Wisecow application and deployed it on Kubernetes with automated CI/CD, GitOps-based continuous deployment, and HTTPS using TLS.

### Technologies Used
- Docker
- Kubernetes (Minikube)
- GitHub Actions
- Docker Hub
- Flux CD
- NGINX Ingress
- OpenSSL
- Bash
- Git and GitHub

### Architecture
1. Developer pushes code to GitHub.
2. GitHub Actions builds the Docker image.
3. Image is pushed to Docker Hub with a commit SHA tag.
4. Kubernetes deployment manifest is updated.
5. Flux CD monitors GitHub and applies updated manifests.
6. Kubernetes runs two Wisecow replicas.
7. NGINX Ingress provides HTTPS using a TLS Secret.

### Kubernetes Resources
- Deployment: wisecow-deployment
- Service: wisecow-service
- Ingress: wisecow-ingress
- TLS Secret: wisecow-tls
- Replicas: 2

### Verification
- Application HTTP test: HTTP 200
- HTTPS test: HTTP/2 200
- Kubernetes Pods: 2/2 Running
- Flux Kustomization: Ready

### HTTPS Test
```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8443:443
curl -k -i --resolve wisecow.local:8443:127.0.0.1 https://wisecow.local:8443
```

---

## Problem Statement 2: Bash Scripting

### Script 1: System Health Monitoring

File: `scripts/system_health.sh`

Features:
- CPU usage monitoring
- Memory usage monitoring
- Disk usage monitoring
- Top 5 CPU-consuming processes
- Threshold-based alerts
- Timestamped log generation

Run:
```bash
./scripts/system_health.sh
```

### Script 2: Application Health Checker

File: `scripts/app_health_check.sh`

Features:
- HTTP availability monitoring
- HTTP status code detection
- Response time measurement
- Application UP/DOWN status
- Timestamped logging

Run:
```bash
./scripts/app_health_check.sh http://localhost:8080
```

### Log Files
- `logs/system_health.log`
- `logs/app_health.log`

---

## Repository Structure

```text
wisecow-kubernetes-cicd/
├── .github/
│   └── workflows/
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── kustomization.yaml
├── scripts/
│   ├── system_health.sh
│   └── app_health_check.sh
├── logs/
├── tls/
├── Dockerfile
├── .gitignore
└── README.md
```

## Author
Muskan Patel

