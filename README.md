
# ☸️ Production-Grade Kubernetes Platform



![Terraform](https://img.shields.io/badge/Infrastructure-Terraform-purple)

![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-blue)

![Python](https://img.shields.io/badge/Backend-FastAPI-green)

![Prometheus](https://img.shields.io/badge/Observability-Prometheus-orange)



## 📖 Overview

This project demonstrates a complete **Platform Engineering** lifecycle, shifting from manual deployments to a self-healing, observable, and automated Kubernetes platform. 



Unlike a standard "Hello World" container, this platform implements **Infrastructure as Code (IaC)**, **GitOps principles**, and **Production-Grade Observability** from day one.



## 🏗 Architecture

The system simulates a real-world enterprise environment running locally on **Kind (Kubernetes in Docker)**.



* **Application Layer:** Python (FastAPI) microservice with custom instrumentation.

* **Infrastructure Layer:** Terraform-managed Namespaces, Helm Charts, and RBAC.

* **Observability Layer:** Prometheus Operator (ServiceMonitors), Grafana Dashboards, and Alertmanager.

* **Resiliency:**

    * **Self-Healing:** Configured Liveness/Readiness probes to handle slow startups and crashes.

    * **Chaos Engineering:** Custom endpoints (`/simulate-latency`, `/simulate-error`) to validate Horizontal Pod Autoscaling (HPA).



## 🔧 Technical Highlights



### 1. Infrastructure as Code (Terraform)

Managed the entire cluster state using Terraform, locking providers versions to prevent configuration drift.

- **Provider:** `hashicorp/kubernetes`, `hashicorp/helm`

- **State Management:** Local backend with locking.



### 2. Deep Observability

Instead of sidecars, I implemented the **Prometheus Operator** pattern.

- **ServiceMonitors:** configured to auto-discover pods with specific labels (`app=fastapi-app`).

- **Named Ports:** Solved the "Port Drift" issue by binding monitors to logical port names (`http-web`) rather than hardcoded numbers.



### 3. Resilience & Security

- **Multi-Stage Builds:** Reduced Docker image size by 60% and removed build artifacts.

- **Non-Root Execution:** Enforced PSA (Pod Security Admission) compliance.

- **Probe Tuning:** Tuned `initialDelaySeconds` to 30s to mitigate "CrashLoopBackOff" during high-latency boot sequences.



## 🚀 Quick Start



### Prerequisites

* Docker & Kind

* Terraform

* Kubectl



### Deployment Steps

```bash

# 1. Provision Infrastructure

cd infra/terraform

terraform init && terraform apply -auto-approve



# 2. Build & Sideload Image

docker build -t devops-project:local -f docker/Dockerfile .

kind load docker-image devops-project:local --name devops-project-cluster



# 3. Deploy Manifests

kubectl apply -f infra/k8s/

```



### Access Dashboards

**Grafana:** `http://localhost:3000` (admin/admin123)

```bash

kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80

```



## 📈 Visuals



---

*Built by [Okikiola Ashiru]*

