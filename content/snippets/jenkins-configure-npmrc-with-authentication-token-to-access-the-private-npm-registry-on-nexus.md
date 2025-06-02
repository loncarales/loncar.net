+++
date = 2020-05-26T21:28:59+02:00
title = "Jenkins: configure .npmrc with authentication token to access the private npm Registry on Nexus"
slug = "jenkins-configure-npmrc-with-authentication-token-to-access-the-private-npm-registry-on-nexus"
+++

```groovy
// Encode registry credentials and save them in local .npmrc
stage('NPM: Config') {
  withNPM(npmrcConfig: 'npm-config') {
    // Encode registry credentials and save them in local .npmrc
    sh 'set +x && echo "\n_auth=\$(echo -n "\${NEXUS_USERNAME}:\${NEXUS_PASSWORD}" | base64)" >> .npmrc'
  }
}

// This only works when BASIC realm is enabled on Nexus Repository Manager

// If we are getting the following error:
[ERROR] npm ERR! code E401
[ERROR] npm ERR! Unable to authenticate, need: BASIC realm="Sonatype Nexus Repository Manager"
// We need to configure .npmrc with authentication token

stage('NPM: Config') {
  withCredentials([usernamePassword(credentialsId: nexusCredentialsId, passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
    def token = sh(returnStdout: true, script: "set +x && curl -s -k -H \"Accept: application/json\" -H \"Content-Type:application/json\" -X PUT --data '{\"name\": \"$NEXUS_USERNAME\", \"password\": \"$NEXUS_PASSWORD\"}' https://nexus-repository.net:8088/repository/my-npm/-/user/org.couchdb.user:$NEXUS_USERNAME 2>&1 | grep -Po '(?<=\"token\":\")[^\"]*'")
    sh "set +x && echo \"//nexus-repository.net:8088/repository/my-npm/:_authToken=$token\" >> .npmrc"
  }
}
```
