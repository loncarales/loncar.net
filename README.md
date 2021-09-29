# Loncar.net Blog

Tools I’ve used for this blog:

* [Hugo](https://gohugo.io/)
* [S3 bucket](https://aws.amazon.com/s3/)
* [CloudFront](https://www.cloudflare.com/en-gb/)

## Instructions

TBA

## Deployment

```bash
# Build a fresh copy
hugo -v 

# Copy over pages - not static js/img/css/downloads
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME
```
