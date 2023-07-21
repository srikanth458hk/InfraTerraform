pipeline {
    agent any
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'uat', 'prod'], description: 'Select the target environment')
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            when {
                expression { params.ENVIRONMENT != 'prod' }
            }
            steps {
                script {
                    sh "terraform plan -var 'env=${params.ENVIRONMENT}'"
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { params.ENVIRONMENT == 'dev' || params.ENVIRONMENT == 'uat' }
            }
            steps {
                script {
                    sh "terraform apply -var 'env=${params.ENVIRONMENT}' -auto-approve"
                }
            }
        }
        
        stage('Terraform Apply (Prod)') {
            when {
                expression { params.ENVIRONMENT == 'prod' }
            }
            steps {
                script {
                    sh "terraform apply -var 'env=${params.ENVIRONMENT}' -auto-approve"
                }
            }
        }
    }
}
