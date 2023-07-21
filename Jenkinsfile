pipeline {
    agent any
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'uat', 'prod'], description: 'Select the target environment')
        string(name: 'BRANCH', defaultValue: 'main', description: 'Enter the branch name for the selected environment')
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Checkout Terraform Scripts') {
            steps {
                script {
                    // Define the repository URL for your Terraform scripts
                    def terraformRepoURL = 'https://github.com/srikanth458hk/InfraTerraform.git'
                    
                    // Checkout the selected branch for the target environment
                    git branch: "${params.BRANCH}", url: terraformRepoURL
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
