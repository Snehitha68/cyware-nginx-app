pipeline {
    agent any

    stages {
        // stage("Docker Hub Login"){
        //     steps{
        //         // withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
        //         withCredentials([string(credentialsId: 'DOKCER_HUB_PASSWORD', variable: 'DOKCER_HUB_PASSWORD')]) {
        //           sh "docker login -u gajjala7012 -p ${DOKCER_HUB_PASSWORD}"
        //         }
        //     }
        // }
        stage('Deploy Docker container') {
            steps {
                // withAWS(credentials:'aws-credentials') {
                    // SSH into the EC2 instance
                    sshagent(['SSH-CREDENTIALS']) {
                        // sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "sudo apt install -y docker-compose"'
                        // sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.66.13.95 "sudo service docker start"'
                        // sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.66.13.95 "sudo usermod -aG docker ec2-user"'

                        // Copy the Docker Compose file to the EC2 instance
                         sh "scp -r -o StrictHostKeyChecking=no docker-compose.yml ubuntu@13.235.33.182:~/"
                         withCredentials([string(credentialsId: 'DOKCER_HUB_PASSWORD', variable: 'DOKCER_HUB_PASSWORD')]) {
                          sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "docker login -u snehitha68 -p ${DOKCER_HUB_PASSWORD}"'
                           }
                        // Start the Docker containers
                        // sshCommand remote: "ubuntu@65.0.100.14", command: "cd ~/app && docker-compose up -d"
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.33.182 "cd ~/ && docker-compose up -d "'
                    }
                }
            }
        }
    }


