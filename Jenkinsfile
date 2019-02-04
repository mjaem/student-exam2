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
                    pip install -e .
                    export FLASK_APP=js_example
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                """
            }
        }
        stage("Building") {
            steps {
                script {
                    dockerImage = docker.build registry + ":webapp-v1.$BUILD_NUMBER"
                }
            }
        }
        stage("Pushing") {
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
