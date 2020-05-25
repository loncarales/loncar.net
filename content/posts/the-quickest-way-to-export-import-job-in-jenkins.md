+++ 
date = 2020-05-17T17:25:00+02:00
title = "The quickest way to export/import job in Jenkins"
slug = "the-quickest-way-to-export-import-job-in-jenkins" 
tags = ["Jenkins", "Jenkins CLI"]
categories = ["Development", "Work"]
+++

For example, we have a scenario where we need to troubleshoot the current job, but we would like to do this on our local Jenkins instance running. Jenkins has a built-in command-line interface that allows users and administrators to access Jenkins from a script or shell environment. This can be convenient for scripting of routine tasks, bulk updates, troubleshooting, and more. With the Jenkins CLI, we can easily export job definition as XML and then later import that XML file to another Jenkins instance.

The command-line interface can be accessed over SSH or with the Jenkins CLI client, a .jar file distributed with Jenkins. First, we need to determine which option is enabled for our instance.

## Using the CLI over SSH

The SSH service is disabled by default. If Administrator has chosen to enable SSH, we can determine the SSH port if we inspect the return headers on a Jenkins URL.

> Inspect Jenkins response headers

```bash
$ curl -Lv https://JENKINS_HOST/login 2>&1 | grep -i 'x-ssh-endpoint'
< x-ssh-endpoint: JENKINS_HOST:2222
# In our case SSH service is opened on port 2222
```

Authentication relies on SSH-based public/private key authentication. To add an SSH public key for the appropriate user, navigate to `JENKINS_URL/user/USERNAME/configure` and paste an SSH public key into the relevant text area.

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/Jenkins-SSH-Public-Keys.png" alt="Jenkins - Add SSH Public Key" caption="Jenkins - Add SSH Public Key" >}}

Once we set up the SSH keys, we can talk with Jenkins over SSH. We can see all list of commands available in a give Jenkins environment with the  `help` command.

> Full list of commands available

```bash
$ ssh -l <USER> -p 2222 JENKINS_HOST help
```

Let's export the desired job and save it as an XML file

> Saves the job definition as an XML file

```bash
$ ssh -l <USER> -p 2222 JENKINS_HOST get-job desired-job > desired-job.xml
```

We can now import this job into another Jenkins instance.

When the SSH service is disabled, for example, the default transport for the CLI client is HTTP which means no additional ports need to be opened in a firewall for its use.  We can talk with Jenkins with the help of the CLI client.

## Using the CLI client

### Downloading the client

The CLI client can be downloaded directly from a Jenkins master at the URL /jnlpJars/jenkins-cli.jar, in effect `JENKINS_URL/jnlpJars/jenkins-cli.jar`.
While a CLI .jar can be used against different versions of Jenkins, should any compatibility issues arise during use, please re-download the latest .jar file from the Jenkins master.

With the CLI client, we connect to the master via HTTP connection mode per default. Authentication is preferably done with an `-auth` option, which takes a `username:apitoken` argument. 

> We can get the API toke from `JENKINS_URL/me/configure`.

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/Jenkins-API-Token.png" alt="Jenkins - Generate new API Token" caption="Jenkins - Generate new API Token" >}}

> Full list of commands available

```bash
$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth <USER>:<API_TOKEN> help
```

> Import the previously exported job

```bash
java -jar jenkins-cli.jar -s http://localhost:8080 -auth <USER>:<API_TOKEN> create-job desired-job < desired-job.xml
```

### Common Problems with the CLI client

`Unable to find valid certification path to requested target` error indicates that Jenkins could not establish a trusted connection over SSL. The trust is handled by having a root and intermediate certificates of your SSL certificate on a trusted Keystore.

> Unable to find valid certification path to requested target

```bash
$ java -jar jenkins-cli.jar -s https://JENKINS_HOST/
Dec 04, 2019 11:15:43 AM org.apache.sshd.common.util.security.AbstractSecurityProviderRegistrar getOrCreateProvider
INFO: getOrCreateProvider(EdDSA) created instance of net.i2p.crypto.eddsa.EdDSASecurityProvider
javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
    at sun.security.ssl.Alerts.getSSLException(Alerts.java:192)
    at sun.security.ssl.SSLSocketImpl.fatal(SSLSocketImpl.java:1946)
    at sun.security.ssl.Handshaker.fatalSE(Handshaker.java:316)
    at sun.security.ssl.Handshaker.fatalSE(Handshaker.java:310)
    at sun.security.ssl.ClientHandshaker.serverCertificate(ClientHandshaker.java:1639)
```

Below you can find the commands which will enable you to import certificate to the trusted root certificate of the JAVA by using `keytool` import command.

> Import certificate

```bash
JENKINS_HOST=myjenkinshost.com
JENKINS_PORT=443
JENKINS_URL=https://${JENKINS_HOST}:${JENKINS_PORT}
KEYSTOREFILE=myKeystore
KEYSTOREPASS=changeme
  
# get the SSL certificate
openssl s_client -connect ${JENKINS_HOST}:${JENKINS_PORT} </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ${JENKINS_HOST}.cer
# create a keystore and import certificate
keytool -import -noprompt -trustcacerts -alias ${JENKINS_HOST} -file ${JENKINS_HOST}.cer -keystore ${KEYSTOREFILE} -storepass ${KEYSTOREPASS}
# verify that the certificate is listed
keytool -list -v -keystore ${KEYSTOREFILE} -storepass ${KEYSTOREPASS}
# get jenkins-cli
wget --no-check-certificate ${JENKINS_URL}/jnlpJars/jenkins-cli.jar
# test access
alias jcli="java -Djavax.net.ssl.trustStore=${KEYSTOREFILE} -Djavax.net.ssl.trustStorePassword=${KEYSTOREPASS} -jar jenkins-cli.jar -s ${JENKINS_URL,,}"
jcli help
# ... or set this in your ~/.bashrc
export JAVA_TOOL_OPTIONS="-Djavax.net.ssl.trustStore=${KEYSTOREFILE} -Djavax.net.ssl.trustStorePassword=${KEYSTOREPASS}"
java -jar jenkins-cli.jar -s ${JENKINS_URL} help
```

> And remember, contributions earn you karma. 😜
