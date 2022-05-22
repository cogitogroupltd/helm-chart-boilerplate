# Ingress-nginx using NodePorts with self-signed SSL certificate termination

See [README.md](../../charts/ingress-nginx/README.md) for more information


1. Create self-signed certificate files

```bash
export RELEASE_NAMESPACE=default
export RELEASE_NAME=ingress-nginx

cd boilerplace/examples/ingres-nginx-ssl-selfsigned
mkdir -p certs
cd certs
openssl req -x509 -sha256 -newkey rsa:4096 -keyout ca.key -out ca.crt -days 356 -nodes -subj '/CN=Self-Signed Cert Authority' 
openssl req -new -newkey rsa:4096 -keyout sample.key -out sample.csr -subj '/CN=sample.test.io'
#Remember this password for step 2

#Generate the Client Key, and Certificate and Sign with the CA Certificate
openssl x509 -req -sha256 -days 730 -in sample.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out sample.crt 
```

2. Store the encryption password in the configMap

Edit the content of `ssh_password_file` in [configmap-conf.yaml](../../charts/ingress-nginx/templates/configmap-conf.yaml). "hello" is used as an example default.


3. Create K8s secrets with certificates and key

```bash
kubectl delete secret --ignore-not-found=true "${RELEASE_NAME}-certs" -n $RELEASE_NAMESPACE ; kubectl create secret generic "${RELEASE_NAME}-certs" -n $RELEASE_NAMESPACE --from-file=tls.key=./sample.key --from-file=tls.crt=./sample.crt ; 
```

3. Install the nginx ingress controller 

```bash
cd ../ # cd boilerplate/examples/ingress-nginx-ssl-selfsigned
helm upgrade --install $RELEASE_NAME ../../charts/ingress-nginx --namespace default --values ./values-override.yaml
```

4. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](../../charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ../../charts/ingress-nginx/_sample-pod.yaml
```

5. Test connectivity 

See output from step 1