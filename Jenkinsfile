def scanWholeRepo = false 

pipeline {
    agent {
        label 'vm198'
    } stages {
        stage ("Checkout the Code") {
            steps {
                // Use pipeline Syntax snippet generator and select sample
                type git: Git
                git branch: 'main', credentialsId: 'Github-Creds', url:
                'https://github.com/KaranAhuja94/TestIaCRepo'
            }
        }
        stage ("Run QIaC Container") {
            agent {
                docker {
                    // provide Qualys docker image name image 'qualys/qiac_security_cli' args '--entrypoint=""'
                    alwaysPull true reuseNode true
                }
            }
            environment {
                // Create a username and password credential in jenkins as a secrete text and provide credential id
                QUALYS_URL = credentials('QUALYS_URL') QUALYS_USERNAME = credentials('QUALYS_USERNAME')
                QUALYS_PASSWORD = credentials('QUALYS_PASSWORD')
                // Please use proxy if required for your env HTTP_PROXY="http://xx.xxx.xx.xx:xxxx" HTTPS_PROXY="http://xx.xxx.xx.xx:xxxx"
            }
            steps {
                //Do not change following command sh 'su qiac'
                sh "sh /home/qiac/iac_scan_launcher.sh ${scanWholeRepo}"
            }
        }
    }
    post {
        always {
            archiveArtifacts(artifacts: 'cli_output')
            // to clean up directory Workspace cleanup plugin is required cleanWs()
        }
    }
}
