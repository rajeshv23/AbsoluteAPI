pipeline{

    /* Execute the build in maven container. */
    agent {
        docker {
            image 'maven:3-alpine'
            /* The build can be executed in the master or on the slave node using label */
            /* label 'jenkins-slave-node' */
        }
    }
    
    stages {
        stage('Compile and Test the API') {
            steps {
                script {
                    sh 'mvn compile';
                    sh 'mvn test';
                }
            }
        }
        
        stage('Package the API') {
            steps {
                script {
                    sh 'mvn package';
                }
            }
        }
        
        stage('Build and Save image') {
            steps {
                script {
                    /* Build docker image using dockerfile for your dockeruser */
                    def absoluteApiImage = docker.build("dockeruser/absolute-api:${env.BUILD_ID}");
                    
                    /* Login to Docker hub using credentials added in Jenkins "docker-auth" */
                    withDockerRegistry(credentialsId: 'docker-auth') {
                        /* Push api image to the docker registry (assuming it is the docker hub private repository) */
                        /* The registry can be private */
                        absoluteApiImage.push();
                    }
                }
            }
        }
    }
}