pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
   triggers{ 
        pollSCM '*/5 * * * *'
    }  
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("jenkins-terraform")
                        {
                            git "https://github.com/yawnartey/jenkins-terraform.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd jenkins-terraform/ ; terraform init'
                sh "pwd;cd jenkins-terraform/ ; terraform plan -out tfplan"
                sh 'pwd;cd jenkins-terraform/ ; terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'jenkins-terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd jenkins-terraform/ ; terraform apply -input=false tfplan"
            }
        }
    }

  }