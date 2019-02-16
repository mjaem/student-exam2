pipeline {
    environment {
        docker_registry = "mjaem/epam_exam"
        docker_registryCredential = 'dockerhub'
    }
    agent {
        label 'jenkins_agent'
    }
    stages {
        stage("Some tests") {
            steps {
                sh """
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -e .
                    export FLASK_APP=js_example
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
                    dockerImage_build = docker.build docker_registry + ":webapp_v$BUILD_NUMBER"
                    dockerImage_latest = docker.build docker_registry + ":webapp_latest"
                }
            }
        }
        stage("Pushing to docker hub") {
            steps {
                script {
                    docker.withRegistry( '', docker_registryCredential ) {
                    dockerImage_build.push()
                    dockerImage_latest.push()
                    }
                }
            }
        }
    }
}
