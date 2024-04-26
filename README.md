# infra-experia

## Set  subscription

az account set --subscription="33d9474f-6004-49f1-a25a-4d8cc8912608"

## Create Service Principal

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/33d9474f-6004-49f1-a25a-4d8cc8912608"

## Example output

```json {
  "appId": "3d207ab6-6d87-40d5-ad8f-540f2bda0e60",
  "displayName": "azure-cli-2024-02-28-18-59-57",
  "password": "Fnp8Q~iRFH1PFfzWJFD-Y3i65Y66Sqy1dYROychi",
  "tenant": "ce4a6448-2ace-405a-808d-6967d2758d65"
}
```


- appId is the client_id defined above.
- password is the client_secret defined above.
- tenant is the tenant_id defined above.

### Create sp

az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/33d9474f-6004-49f1-a25a-4d8cc8912608"

#### Output


```json {
  "appId": "488ecb0d-3c04-4078-8461-bdc5061ef51c",
  "displayName": "azure-cli-2024-02-29-22-46-53",

  "tenant": "ce4a6448-2ace-405a-808d-6967d2758d65"
}
```


- appId is the client_id defined above.
- password is the client_secret defined above.
- tenant is the tenant_id defined above.


## Troubleshooting

### If not resgiset in namespace kubernetes

az provider show --namespace "Microsoft.KubernetesConfiguration" --query "registrationState"

### Register in namespace kubernetes
az provider register --namespace "Microsoft.KubernetesConfiguration"


### Ambiente de desarrollo
Se realizaron los siguientes cambios:

- Se eliminó el firewall
- Se disminuyó la máquina virtual del cluster de kubernetes de D8_v3 a Standard_B4ms
- Se disminuyó la cantidad de nodos mínimos a 1 y máximo a 3
- 