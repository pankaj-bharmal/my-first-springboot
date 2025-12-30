pipeline {
    agent any

    environment {
        REGISTRY = "localhost:5000"
        IMAGE_NAME = "my-first-springboot-app"
        DATE = new Date().format('yy.MM')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/pankaj-bharmal/my-first-springboot.git',
                    branch: 'main'
            }
        }

        stage('Build Maven') {
            steps {
                dir('my-first-springboot') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                dir('my-first-springboot') {
                    script {
                        def image = docker.build("${REGISTRY}/${IMAGE_NAME}:${TAG}")
                        image.push()
                        image.push("latest")
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh """
                docker stop ${IMAGE_NAME} || true
                docker rm ${IMAGE_NAME} || true
                docker run -d \
                  --name ${IMAGE_NAME} \
                  -p 8080:8080 \
                  ${REGISTRY}/${IMAGE_NAME}:${TAG}
                """
            }
        }
    }
}
