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
                String JOB_NAME = build.project.name;
                sh "docker build . -t    456456/dotnet-core-test:$JOB_NAME"
                sh "docker push 456456/dotnet-core-test:$JOB_NAME"
            }
        }


    }
}