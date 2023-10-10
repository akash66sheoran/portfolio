pipeline {
  agent any

  stages {
    stage('Clone code') {
      steps {
        echo 'fetching the code'
        git 'https://github.com/akash66sheoran/portfolio.git'
      }
    }
    stage('Build') {
      steps {
        echo 'building the image'
        sh 'docker build -t portfolio .'
      }
    }
    stage('push to docker hub') {
      steps {
        echo 'pushing image to docker hub'
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPass', usernameVariable: 'dockerHubUser')]) {
          sh 'docker tag portfolio $dockerHubUser/portfolio:latest'
          sh 'docker login -u $dockerHubUser -p $dockerHubPass'
          sh 'docker push $dockerHubUser/portfolio:latest'
        }
      }
    }
    stage('deploy') {
      steps {
        echo 'deploying the app'
        sh 'docker-compose down && docker-compose up -d'
      }
    }
  }
}
