pipeline {
    agent {
        docker { 
            image 'hashicorp/terraform:light' 
            args '-it --entrypoint=/bin/bash'
            label 'ub1'
        }
    }
    stages {
        stage('Test') {
            steps {
                sh 'terraform --version'
            }
        }
    }
}