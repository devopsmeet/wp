pipeline {
  environment {
    registry = "devopsmeet2019/wp-project"
    registryCredential = 'DockerLogin'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/devopsmeet/wp.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Deploy to production server') {
      steps{
        milestone(1)
        script {
        sh "docker stop wp-project"
        sh "docker rm wp-project"
        sh "docker run -d --name wp-project -p 9090:80 devopsmeet2019/wp-project:${BUILD_NUMBER}"
        sh "docker images --no-trunc -aqf "devopsmeet2019/wp-project=true" | xargs docker rmi
       }
    }    
  }   
  } 
  }
