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


```
cp values-example.yaml values.yaml
tanzu project use <my-project>
./deploy.sh
```
