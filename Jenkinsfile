def scanWholeRepo = false

pipeline {
    agent any

    options {
        timestamps()
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Run Qualys QIaC Scan') {
            environment {
                QUALYS_URL      = credentials('QUALYS_URL')
                QUALYS_USERNAME = credentials('QUALYS_USERNAME')
                QUALYS_PASSWORD = credentials('QUALYS_PASSWORD')
            }

            steps {
                bat """
                echo Running Qualys QIaC scan...

                docker run --rm ^
                  -e QUALYS_URL ^
                  -e QUALYS_USERNAME ^
                  -e QUALYS_PASSWORD ^
                  -v "%CD%:/work" ^
                  -w /work ^
                  qualys/qiac_security_cli ^
                  sh /home/qiac/iac_scan_launcher.sh ${scanWholeRepo}
                """
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/cli_output/**', allowEmptyArchive: true
            cleanWs()
        }
        failure {
            echo Qualys QIaC scan failed
        }
    }
}
