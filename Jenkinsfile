def artifactory = Artifactory.server('artifactory')

pipeline {
    agent any
    stages {
         stage('Clean up Workspace'){
                  steps {
                     deleteDir()
                  }

         }
       stage ('Checkout'){
          steps{
            checkout scm
          }
        }
        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "artifactory"
                )
            }
        }

        stage('Build') {
            steps {

                sh "docker push 456456/dotnet-core-test:${env.getEnvironment().get('JOB_NAME')}"
            }
        }

      stage('Docker Push') {
            steps {

                sh "docker push 456456/dotnet-core-test:${env.getEnvironment().get('JOB_NAME')}"
            }
        }
       stage('Docker deploy') {
            steps {
              script {
               try{
                 sh "sudo ansible ${env.getEnvironment().get('JOB_NAME')} -a 'docker stop myapp;docker rm myapp' -u ubuntu"
                }catch (Exception e) {sh 'echo contener not run'}
                }
                sh "sudo ansible ${env.getEnvironment().get('JOB_NAME')} -a 'docker pull 456456/dotnet-core-test:${env.getEnvironment().get('JOB_NAME')}' -u ubuntu"
                sh "sudo ansible ${env.getEnvironment().get('JOB_NAME')} -a 'docker run -d -p 8083:80 --name myapp 456456/dotnet-core-test:${env.getEnvironment().get('JOB_NAME')}'  -u ubuntu"
            }
        }
    }
}