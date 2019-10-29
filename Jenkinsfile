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
				sh 'terraform import google_container_cluster.mycluster my-gcp-project/us-east1-a/my-cluster'
                sh 'terraform init -input=false'
            }
        }
	
	stage('TF Apply') {
      steps {
       
         sh 'terraform apply -input=false'
       
      }
    }
	}
  }

