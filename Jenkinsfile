pipeline {
  agent any
    environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth')
  }
  stages{
    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > cread.json'
      }
    }
        stage('Plan') {
            steps {
 
                sh 'terraform init -input=false'
              
                sh 'terraform plan -input=false'
            }
        }
	
	stage('TF Apply') {
      steps {
       
         sh 'terraform apply'
       
      }
    }
	}
  }

