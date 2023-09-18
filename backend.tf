#create the S3 bucket for your state files 
resource "aws_s3_bucket" "jenkins-state-files" {
  bucket = "jenkins-state-files-one"
  tags = {
    Name  = "jenkins-state-files-one"
  }
}

#enable bucket versioning 
resource "aws_s3_bucket_versioning" "jenkins-state-files-versioning" {
  bucket = aws_s3_bucket.jenkins-state-files.id
  versioning_configuration {
    status = "Enabled"
  }
}

#remote state file config
# jenkins {
#   backend "s3" {
#     bucket = "andlanc-jenkins-state-files"
#     key    = "anlanc_jenkins.tfstate"
#     region = "us-east-1"
#   }
# }