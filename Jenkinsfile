
properties([disableConcurrentBuilds()])

pipeline {
    environment {
        registry = "mjaem/epam_exam"
        registryCredential = 'dockerhub'
    }
    agent {
        label 'jenkins_agent'
    }
    options {
        timestamps()
    }
    stages {
        stage("Some tests") {
            steps {
                sh """
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                    deactivate
                """
            }
        }
        stage("Building image") {
            steps {
                script {
                    dockerImage = docker.build registry + ":webapp_v0.$BUILD_NUMBER"
                }
            }
        }
        stage("Pushing to hub") {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
    }
}
