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
	 stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = "${version}"
                }
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment}'
                sh "terraform plan -input=false -out tfplan -var 'version=${version}' --var-file=environments/${environment}.tfvars"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
	
	stage('TF Apply') {
      steps {
       
          terraform apply 
       
      }
    }
	}
  }

