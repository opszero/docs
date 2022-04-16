# Helm

## Ingress

The ingress is in its simplest form a Kubernetes LoadBalancer. Instead of what
would traditionally be this:

``` sh
DNS (i.e app.example.com) -> Kubernetes Service -> Kubernetes Pods
```

It is the following

``` sh
DNS (i.e app.example.com) -> Ingress (Public IP Address/CNAME) -> Kubernetes Service -> Kubernetes Pods
```

To break down the Ingress request cycle even further it is the following:

``` sh
DNS (i.e app.example.com) -> Ingress [Kubernetes Service -> Kubernetes Pods (Nginx) -> Kubernetes Service -> Kubernetes Pods]
```

The Ingress is just another pod such as Nginx that relays the traffic and as
such is just another pod in the system. The ingress is a helm chart and is
installed manually with the following script.

The ingress works at the DNS layer so it needs to be passed a Host to work:

``` sh
curl -k -H "Host: app.example.com" <https://a54313f35cb5b11e98bb60231b063008-2077563408.us-west-2.elb.amazonaws.com>
```
