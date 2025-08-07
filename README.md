# gke-prd-terraform

- env: Se guardan los tfvars por ambiente
- modules: Se guardan los modulos de los componentes usados
- providers.tf: Se implementa el estado y los proveedores
- aks.tf: Se implementa el cluster de kubernetes
- apim.tf: Se implementa el API Gateway
- bastion.tf: Se implementa el bastion
- gateway.tf: Se implementa el Application Gateway
- hub.tf: Se implementa el hub
- spoke.tf: Se implementan los spokes


## Auth

```bash
gcloud auth application-default login
```

## Plan

```bash
terraform plan -var-file prod.tfvars -out prod.tfplan
```

## Apply

```bash
terraform apply prod.tfplan
```

## Destroy

```bash
terraform destroy -var-file prod.tfvars
```