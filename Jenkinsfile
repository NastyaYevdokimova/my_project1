pipeline {
    agent any
    
    
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    
    
    
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_VAR_access_key = credentials('AWS_ACCESS_KEY_ID')
        TF_VAR_secret_key = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
            stage('TerraformInit'){
            steps {
               
                    sh "terraform init -input=false"
                    sh "echo \$PWD"
                    sh "whoami"
               
            }
        }

        
        
        stage('TerraformPlan'){
            steps {
               
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "terraform plan -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
               
            }
        }
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan'
                        
                    }
                }
            }
        }
    }
}