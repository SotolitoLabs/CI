pipeline {
   agent { node { label 'test' } }

   stages {
      stage('Spin Up') {
         steps {
             sh 'docker-compose up -d'
         }
      }
      stage('Start nginx') {
         steps {
             script {
                sh "echo 'Hello from inside of the container'" 
             }
         }
      }
      stage('Do something') {
         steps {
             script {
                sh "echo 'I will do something else and shutup'"
             }
         }
      }
   }
}
