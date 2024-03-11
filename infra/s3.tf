############################################
# S3 Bucket for loncar.net
############################################

resource "aws_s3_bucket" "loncar_net" {
  bucket              = var.bucket_name_loncar_net
  force_destroy       = "false"
  object_lock_enabled = "false"

  tags = {
    project = "loncar.net"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loncar_net" {
  bucket = aws_s3_bucket.loncar_net.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "loncar_net" {
  bucket = aws_s3_bucket.loncar_net.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "loncar_net" {
  bucket = aws_s3_bucket.loncar_net.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_policy" "loncar_net" {
  bucket = aws_s3_bucket.loncar_net.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::loncar.net/*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = [
              "2400:cb00::/32",
              "2606:4700::/32",
              "2803:f800::/32",
              "2405:b500::/32",
              "2405:8100::/32",
              "2a06:98c0::/29",
              "2c0f:f248::/32",
              "173.245.48.0/20",
              "103.21.244.0/22",
              "103.22.200.0/22",
              "103.31.4.0/22",
              "141.101.64.0/18",
              "108.162.192.0/18",
              "190.93.240.0/20",
              "188.114.96.0/20",
              "197.234.240.0/22",
              "198.41.128.0/17",
              "162.158.0.0/15",
              "172.64.0.0/13",
              "131.0.72.0/22",
              "104.16.0.0/13",
              "104.24.0.0/14"
            ]
          }
        }
      }
    ]
  })
}


############################################
# S3 Bucket for www.loncar.net
############################################

resource "aws_s3_bucket" "www_loncar_net" {
  bucket              = var.bucket_name_www_loncar_net
  force_destroy       = "false"
  object_lock_enabled = "false"

  tags = {
    project = "loncar.net"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_loncar_net" {
  bucket = aws_s3_bucket.www_loncar_net.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "www_loncar_net" {
  bucket = aws_s3_bucket.www_loncar_net.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "www_loncar_net" {
  bucket = aws_s3_bucket.www_loncar_net.id

  redirect_all_requests_to {
    host_name = "loncar.net"
    protocol  = "https"
  }
}

resource "aws_s3_bucket_policy" "www_loncar_net" {
  bucket = aws_s3_bucket.www_loncar_net.id
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "PublicReadGetObject",
        Effect : "Allow",
        Principal : "*",
        Action : "s3:GetObject",
        Resource : "arn:aws:s3:::www.loncar.net/*",
        Condition : {
          IpAddress : {
            "aws:SourceIp" : [
              "2400:cb00::/32",
              "2606:4700::/32",
              "2803:f800::/32",
              "2405:b500::/32",
              "2405:8100::/32",
              "2a06:98c0::/29",
              "2c0f:f248::/32",
              "173.245.48.0/20",
              "103.21.244.0/22",
              "103.22.200.0/22",
              "103.31.4.0/22",
              "141.101.64.0/18",
              "108.162.192.0/18",
              "190.93.240.0/20",
              "188.114.96.0/20",
              "197.234.240.0/22",
              "198.41.128.0/17",
              "162.158.0.0/15",
              "172.64.0.0/13",
              "131.0.72.0/22",
              "104.16.0.0/13",
              "104.24.0.0/14"
            ]
          }
        }
      }
    ]
  })
}

############################################
# S3 Bucket for media.loncar.net
############################################

resource "aws_s3_bucket" "media_loncar_net" {
  bucket              = var.bucket_name_media_loncar_net
  force_destroy       = "false"
  object_lock_enabled = "false"

  tags = {
    project = "loncar.net"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "media_loncar_net" {
  bucket = aws_s3_bucket.media_loncar_net.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "media_loncar_net" {
  bucket = aws_s3_bucket.media_loncar_net.id
  versioning_configuration {
    status = "Disabled"
  }
}

## TODO replace with module

#module "s3-bucket" {
#  source  = "terraform-aws-modules/s3-bucket/aws"
#  version = "4.1.1"
#
#  bucket              = var.bucket_name_media_loncar_net
#  force_destroy       = "false"
#  object_lock_enabled = "false"
#
#  tags = {
#    project = "loncar.net"
#  }
#
#  server_side_encryption_configuration = {
#    rule = {
#      apply_server_side_encryption_by_default = {
#        sse_algorithm = "AES256"
#      }
#    }
#  }
#
#  versioning = {
#    status = "Disabled"
#  }
#}
