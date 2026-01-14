def scanWholeRepo = false

pipeline {
    agent {
        label 'vm198'
    }

    stages {
        stage('Checkout the Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'Github-Creds',
                    url: 'https://github.com/KaranAhuja94/TestIaCRepo/'
            }
        }

        stage('Run QIaC Container') {
            agent {
                docker {
                    image 'qualys/qiac_security_cli'
                    args '--entrypoint=""'
                    alwaysPull true
                    reuseNode true
                }
            }

            environment {
                QUALYS_URL      = credentials('QUALYS_URL')
                QUALYS_USERNAME = credentials('QUALYS_USERNAME')
                QUALYS_PASSWORD = credentials('QUALYS_PASSWORD')
            }

            steps {
                sh 'whoami'
                sh "sh /home/qiac/iac_scan_launcher.sh ${scanWholeRepo}"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'cli_output/**'
            cleanWs()
        }
    }
}
