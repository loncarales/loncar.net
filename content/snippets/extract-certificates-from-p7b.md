+++
date = "2019-03-10"
title = "Extract all certificate chain from DER-encoded .p7b file"
slug = "extract-certificates-from-p7b"
+++

Export all certificates into one file

```bash
$ base64 -d <P7B_FILE>.p7b | openssl pkcs7 -inform DER -print_certs -out <PEM_FILE>.pem
```

We'll get three certificates inside `<PEM_FILE>.pem` file, from top to bottom:\

1. Certificate for the route in PEM format
2. CA certificate chain for the route validation in PEM format
3. Root CA certificate in PEM format

Validate key - certificate pair with following commands

```bash
$ openssl pkey -in <PRIVATE>.key -pubout -outform pem | sha256sum
```

Example output: **bb912b1c6614a0462556b2826b7dce6083a9b58049008a656706234d45abd4c6**

```bash
$ openssl x509 -in <ROOT_CA>.cer -pubkey -noout -outform pem | sha256sum
```

Example output: **bb912b1c6614a0462556b2826b7dce6083a9b58049008a656706234d45abd4c6**

### Related Post

* [How to easily extract PKCS7 DER-encoded certificates]({{< ref "how-to-easily-extract-certificates-from-p7b.md" >}})
