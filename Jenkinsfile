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
                sh "docker build . -t   157.175.199.12:8081/example-repo-local:$currentBuild.number"
            }
        }

        stage ('Push image to Artifactory') {
            steps {
                script {
                    def rtDocker = Artifactory.docker server: artifactory
                    def dockerBuildInfo1 = rtDocker.push("157.175.199.12:8081/example-repo-local:$currentBuild.number", "docker-repo")
                }
            }
        }
    }
}