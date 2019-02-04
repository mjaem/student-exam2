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
        stage("Tests") {
            node ('jenkins_agent') {
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
        }
        stage("Build") {
            node ('jenkins_agent') {
				steps {
					script {
						dockerImage = docker.build registry + ":webapp_v0.$BUILD_NUMBER"
					}
				}
			}	
        }
        stage("Push") {
            node ('jenkins_agent') {
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
}
