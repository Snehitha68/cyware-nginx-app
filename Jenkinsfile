pipeline {
    agent any

    stages {
        stage('Deploy Docker container') {
            steps {
                    // SSH into the EC2 instance
                    sshagent(['SSH-CREDENTIALS']) {
                        // Install Docker Compose on EC2 instnace
                         sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "sudo apt install -y docker-compose"'

                        // Copy the Docker Compose file to the EC2 instance and Docker login 
                         sh "scp -r -o StrictHostKeyChecking=no docker-compose.yaml ubuntu@13.235.33.182:~/"
                         withCredentials([string(credentialsId: 'DOKCER_HUB_PASSWORD', variable: 'DOKCER_HUB_PASSWORD')]) {
                          sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "docker login -u snehitha68 -p ${DOKCER_HUB_PASSWORD}"'
                           }
                        // Start the Docker containers
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "cd ~/ && docker-compose up -d "'
                    }
                }
            }
        }
    }


