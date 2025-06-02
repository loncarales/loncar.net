+++
date = 2025-06-02T10:19:39+02:00
title = "Achieving Dev/Prod Parity with Local Kubernetes and TLS using Anchor and lcl.host"
slug = "achieving-devprod-parity-with-local-kubernetes-and-tls-using-anchor-and-lclhost"
tags = ["Kubernetes", "Development", "DevOps", "TLS", "Automation", "Kind", "Anchor", "lcl.host", "Dev Containers", "Dev/Prod Parity"]
categories = ["Kubernetes", "DevOps", "TLS", "Development"]
+++

{{< figure src="https://cdn.loncar.net/achieving-devprod-parity-with-local-kubernetes-and-tls-using-anchor-and-lclhost.png" alt="Beyond the Buzzword: DevOps as a State of Mind" caption="Achieving Dev/Prod Parity with Local Kubernetes and TLS using Anchor and lcl.host" >}}

## 🔄 TL;DR

> Skip the pain of self-signed certificates and localhost DNS hacks. Use Anchor + lcl.host + Kind to get production-like Kubernetes with real HTTPS locally in minutes, not hours.

Picture this: Your application works perfectly on your laptop with `http://localhost:3000`, but mysteriously breaks in production with certificate errors, CORS issues, and networking problems you've never seen before.

Sound familiar? You're not alone.

As developers, we strive for perfection, especially when it comes to ensuring our development environments closely mirror production setups. Historically, tools like [**Vagrant**](https://developer.hashicorp.com/vagrant) have been our go-to for mimicking production infrastructure locally. However, with the rapid shift toward containerization, particularly with [Docker](https://www.docker.com/) and Kubernetes ([K8S](https://kubernetes.io/)), Vagrant's relevance has waned.
Today, many production environments are orchestrated by Kubernetes. Naturally, this leads developers to prefer running Kubernetes locally to achieve that coveted [Dev/Prod](https://12factor.net/dev-prod-parity) parity. This parity isn't just convenient; it’s crucial for stability and consistency when deploying to production.

But here's the kicker: **most local Kubernetes setups completely ignore encryption**, creating a massive blind spot that only surfaces when things break in production.

## The Encryption Gap: Why TLS Matters in Development

Consider these scenarios I've encountered:

- **Mixed content errors** that only appear with HTTPS
- **Cookie security policies** that behave differently over HTTP vs HTTPS
- **Service mesh mTLS** configurations that can't be tested without proper certificates
- ...

The harsh reality? These issues are **100% preventable** with proper local TLS setup.

One critical yet frequently overlooked aspect of Dev/Prod parity is encrypting application traffic using Transport Layer Security ([TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security)). Often, developers neglect encryption during local development due to complexity and setup friction. Yet, if encryption isn't tested locally, issues usually appear once it is deployed to production.
Ensuring local application encryption is seamless, frictionless, and identical to production standards is crucial. The key to building stable production systems is ensuring encryption is integrated seamlessly across all environments.

## The Traditional Toolchain Pain

The "classic" approach involves a tedious dance with multiple tools:

- [openssl](https://www.openssl.org/): Widely referenced on Google and Stack Overflow, especially the popular "[how to get a localhost certificate](https://stackoverflow.com/questions/10175812/how-to-get-a-localhost-certificate)" article, but can be cumbersome and error-prone.
- [mkcert](https://mkcert.dev/): Simplifies generating locally trusted certificates.
- [hostess](https://github.com/cbednarski/hostess): Helps manage local DNS entries. or the ninja way `sudo vim /etc/hosts`
- nginx ([reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)): Used to handle SSL termination locally.

However, this approach suffers from:

- ❌ **Browser security warnings** (self-signed certificates)
- ❌ **Manual DNS management** (editing `/etc/hosts`)
- ❌ **Certificate rotation headaches**
- ❌ **Platform-specific quirks** (Windows, macOS, Linux differences)
- ❌ **Team onboarding friction** (everyone needs different setup steps)

## Game Changers: Anchor and lcl.host

Recently, I discovered two innovative tools that significantly reduce complexity:

### [Anchor](https://anchor.dev/): Manage public and private certificates with complete insight across environments, built with the trusted ACME standard

Anchor provides **real, trusted certificates** using the same ACME protocol that powers Let's Encrypt. Unlike self-signed certificates, these are trusted by browsers and provide authentic production behavior locally.

Key benefits:

- ✅ **Zero browser warnings**
- ✅ **Real certificate authority** backing
- ✅ **Automatic renewal** via cert-manager
- ✅ **Same ACME flow** as production

### [lcl.host](https://lcl.host/): DNS Magic for Developers

A convenient domain where every subdomain of `lcl.host` automatically resolves to your local machine (127.0.0.1 and ::1).

 ```bash
 # This just works - no configuration needed
dig api.lcl.host +short
# 127.0.0.1

dig my-awesome-app.lcl.host +short
# 127.0.0.1

dig literally-anything.lcl.host +short
# 127.0.0.1
 ```

This eliminates:

- ❌ Editing `/etc/hosts` files
- ❌ Running local DNS servers
- ❌ Platform-specific DNS configuration
- ❌ Team member onboarding friction

## Architecture: Production-Like Kubernetes Locally

Here's how the pieces fit together in my [kind-anchor-lab](https://github.com/loncarales/kind-anchor-lab):

```bash
        ┌──────────────────────────────┐
        │        Your Browser          │
        │  https://*.lcl.host:32769    │
        └────────────┬─────────────────┘
                    │
    Host Ports: 32768 (HTTP), 32769 (HTTPS)
                    │
        ┌────────────▼────────────┐
        │      Envoy Proxy        │  ← Docker container
        │ envoyproxy/envoy:v1.30  │
        │ Host → 172.18.0.X:80/443│
        └────────────┬────────────┘
                    │
        Internal Docker Network
                172.18.0.0/16
                    │
        ┌────────────▼────────────┐
        │        NGINX            │
        │    Ingress Controller   │  ← Running inside Kind node
        │  Listens on 172.18.0.4  │
        └────────────┬────────────┘
                    │
        ┌────────────▼────────────┐
        │      Your Service       │
        │         (Pod)           │
        │       http://:8080      │
        └─────────────────────────┘
```

This setup provides:

1. **Real LoadBalancer simulation** via [cloud-provider-kind](https://github.com/kubernetes-sigs/cloud-provider-kind)
2. **Production ingress patterns** with NGINX Ingress Controller
3. **Authentic TLS termination** using cert-manager + Anchor
4. **Zero-config DNS** via lcl.host subdomains

## Kind: Kubernetes in Docker Done Right

[Kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker) is the perfect foundation for this setup because it:

- ✅ **Runs anywhere Docker runs** (Linux, macOS, Windows)
- ✅ **Boots in seconds**, not minutes
- ✅ **Supports multiple node clusters** for realistic testing
- ✅ **Integrates with CI/CD** pipelines seamlessly
- ✅ **Provides genuine Kubernetes APIs** (not simplified alternatives)

Combined with the [Kubernetes Cloud Provider for Kind](https://github.com/kubernetes-sigs/cloud-provider-kind), you get realistic cloud interactions including LoadBalancer services and ingress controllers that behave exactly like production.

## Real-World Example: From Zero to HTTPS in Minutes

### Prerequisite: Create an Anchor Account and Service (Critical Step)

Before running the lab, you must create a service in the Anchor UI:

1. Create a free account on [Anchor](https://anchor.dev/) if you haven’t already.
2. Manually create a service named `kind-anchor-lab` in the Anchor dashboard. This service will be used by the local lab to request and manage TLS certificates.

Here's how the service creation screen should look:

{{< figure src="https://cdn.loncar.net/anchor-create-service.png" alt="Creating new Service in Anchor UI" >}}

> Note: Anchor needs to know which service will be requesting certificates. The Kind Cloud Provider will handle the actual port mapping (typically :32769), so the port you choose in Anchor's UI is just for organization purposes.

This is a one-time step and ensures that your local environment can securely obtain and manage certificates via Anchor.

Let's see this in action. Run my automated setup provided in my GitHub repository [kind-anchor-lab](https://github.com/loncarales/kind-anchor-lab).

You can immediately test real HTTPS endpoints:

```bash
# This just works - no browser warnings!
$ curl https://kind-anchor-lab.lcl.host:32769/alice
"hello from alice!"

$ curl https://kind-anchor-lab.lcl.host:32769/bob
"hello from bob!"

# Verify the TLS certificate
$ openssl s_client -connect kind-anchor-lab.lcl.host:32769 -servername kind-anchor-lab.lcl.host | grep "Verification"
Connecting to 127.0.0.1
depth=2 O=loncarales, CN=loncarales/localhost - AnchorCA
verify return:1
depth=1 O=loncarales, CN=kind-anchor-lab - SubCA
verify return:1
depth=0 O=loncarales, CN=kind-anchor-lab.lcl.host
verify return:1
Verification: OK
```

## The Business Case: Why This Matters

Beyond developer happiness, this approach delivers measurable business value:

### Reduced Production Issues

- **Fewer certificate-related incidents** in my experience
- **Earlier detection** of HTTPS-specific bugs
- **Faster root cause analysis** when issues do occur

### Developer Productivity

- **Zero onboarding friction** for new team members
- **Consistent environments** across the entire team
- **Faster iteration cycles** with production-like testing

### Security Posture

- **Real certificate validation** in development
- **mTLS testing** capabilities for service mesh deployments
- **Security header testing** that actually works

## The Bottom Line

Dev/Prod parity isn't just a nice-to-have, it's a competitive advantage. Teams that achieve true parity ship more reliable software, faster.

The combination of Kind + Anchor + lcl.host eliminates the traditional barriers to local Kubernetes development with real TLS. What used to take hours of configuration now takes minutes.

Stop accepting the broken status quo of HTTP only local development. **Your production environment uses HTTPS, your local environment should too.**

**Ready to bridge the gap?** Check out the [kind-anchor-lab repository](https://github.com/loncarales/kind-anchor-lab) for a full experience.

> And remember, contributions earn you karma. 😜
