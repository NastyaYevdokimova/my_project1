pipeline {
  agent any
  stages {
  stage('Checkout') {

        sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/cread.json'
    }
	 stage('TF Plan') {

           sh 'terraform init'
     }
	  stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }
	 stage('TF Apply') {

          sh 'terraform apply -input=false myplan'

      }
    }
  }
