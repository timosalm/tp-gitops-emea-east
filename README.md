## VKS setup

The VKS setup requires the following special configurations, see [vks/](vks folder).
More CPUs for the worker nodes (custom VMClass with 16vCPUs, 8GB memory, [vks/vks-cluster-sample.yaml](vks/vks-cluster-sample.yaml) line 104)
Additional storage for the nodes (100GB, [vks/vks-cluster-sample.yaml](vks/vks-cluster-sample.yaml) line 108)
Harbor CA certificate added to the nodes ([vks/vks-cluster-sample.yaml](vks/vks-cluster-sample.yaml) line 80, [vks/vks-cluster-harbor-elasticsky-cloud-ca-secret.yaml](vks/vks-cluster-harbor-elasticsky-cloud-ca-secret.yaml))

As soon as the cluster is created, set a default storage class on the cluster.
´´´
kubectl annotate StorageClass k8s-workload-latebinding storageclass.kubernetes.io/is-default-class=true
´´´
Add Harbor CA certificate to kapp-controller, by modifying the [vks/kapp-controller-registry-config.yaml file](vks/kapp-controller-registry-config.yaml), and applying it to the cluster.
´´´
kubectl apply -f vks/kapp-controller-registry-config.yaml
´´´

## TP SaaS setup
- Attach cluster to Tanzu Platform with label region=epc
- Configure Route 53 GSLB credential in Tanzu Platform (Setup & Configuration -> Credentials)
- Add CA cert for registry to kapp-controller in the workload cluster
```
apiVersion: v1
kind: Secret
metadata:
  name: kapp-controller-config
  namespace: tkg-system
stringData:
  caCerts: |
    -----BEGIN CERTIFICATE-----
    MIIIrzCCB5egAwIBAgIQApGSTwwhz9lqGp1U5fMRUDANBgkqhkiG9w0BAQsFADBP
    MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMSkwJwYDVQQDEyBE
    ....
    -----END CERTIFICATE----- 
```


If you deploy the configuration in this repository the first time to a TP Project, run the following command:
```
rm tanzu.yml
tanzu gitops init
```

Deploy the configuration to the TP Project
```
cp values-example.yaml values.yaml
tanzu project use <my-project>
./deploy.sh
```
