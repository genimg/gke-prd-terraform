

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo snap install kubectl --classic

sudo az aks install-cli

az login

az account set --subscription="33d9474f-6004-49f1-a25a-4d8cc8912608"

az aks get-credentials --name d-vuelo-aks-eus2-z3f1 --resource-group d-vuelo-spoke-rg-eus2-mw4o

kubernetes API server address - Obtener url

Dar permisos en azure rbac al usuario que se loggeará

Role assigment -> buscar azure ubac -> RBAC Cluster admin -> ad member -> carlos.ormeno@expertiatravel.com

kubectl get nodes

Luego ejecutar: kubectl apply -f crbflux.yaml; kubectl delete --all pods --namespace=flux-system

Creamos una kustomización para flux

az k8s-configuration flux create \
--name motor-vuelos-config \
--cluster-name d-vuelo-aks-eus2-z3f1 \
--namespace flux-system \
--resource-group d-vuelo-spoke-rg-eus2-mw4o \
-u https://dev.azure.com/grupoexpertia/pry-motorvuelos/_git/pry-motorvuelos-back-gitops \
--https-user luis.urrelo@expertiatravel.com \
--https-key yuaei7zru2nicq2c2c4rkvyti3aym2qx3u4gmqx2h6bik735kfra \
--scope cluster \
--cluster-type managedClusters \
--branch main \
--kustomization name=motor-vuelos-config prune=true path=/

este problema se origina por este bug:
https://github.com/Azure/application-gateway-kubernetes-ingress/issues/1495

Ejecutar:
kubectl delete clusterrolebinding ingress-appgw-crb; kubectl apply -f crbappgw.yaml

kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/helm/ingress-azure/crds/azureapplicationgatewayrewrite.yaml

kubectl delete po $(kubectl get po -nkube-system | grep ingress | awk '{print $1}') -nkube-system

Instalar linkerd

curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh

export PATH=$HOME/.linkerd2/bin:$PATH
linkerd version
linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
linkerd check

curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml | kubectl apply -f
kubectl get -n emojivoto deploy -o yaml | linkerd inject - | kubectl apply -f -

kubectl apply -f ingressemoji.yaml

Instalar dashboard

linkerd viz install | kubectl apply -f - 

PARA EXPONER EL DASHBOARD DE LINKERD CON INGRESS CREAR EL SIGUIENTE
ARCHIVO:
PRIMERO:
MODIFICAR EL PARÁMETRO DEL DEPLOY DEL DASHBOARD DE LA SIGUIENTE
MANERA:
--enforced-host=^dashboard\.example\.com$ ----> - -enforced-host=.*




y en apim crear un path asi : /*
