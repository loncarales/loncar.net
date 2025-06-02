+++
date = 2020-05-25T20:36:21+02:00
title = "Manually upload Maven artefacts to Artifactory the easy way"
slug = "manually-upload-maven-artefacts-to-artifactory-the-easy-way"
+++

```bash
# Upload the package
mvn -s user-settings.xml deploy:deploy-file \
    -Durl=https://artifactory.hostname.com/maven-release \
    -DrepositoryId=central \
    -Dfile="my-package-1.0.0.zip" \
    -DgroupId=com.package.my \
    -DartifactId=my-package \
    -Dversion=1.0.0 \
    -Dpackaging=zip \
    -DgeneratePom=false

# User settings file `user-settings.xml` can be downloaded via "Set Me Up" button.

# First we need to download JFrog CLI from https://jfrog.com/getcli/

# You'll be asked to configure the Artifactory URL and credentials using the interactive prompt.
# If this is not the case you'll have to use configure command
# jfrog rt c --url=https://artifactory.hostname.com --user=admin --password=password
# ping the artifactory
jfrog rt ping --url=https://artifactory.hostname.com

# Upload a ZIP file
jfrog rt u my-package-1.0.0.zip maven-release/com/package/my/my-package/1.0.0/

# The repository path is combined of
# groupid -> com.package.my -> where dots are replaced with slashes
# artifactid -> my-package
# version -> 1.0.0
# jfrog rt package.zip repository/groupid/artifactid/version/
```
