                sh "docker exec ${pid} chef exec rspec --color -fd"
             }
         }
      }
      stage('Kitchen Create') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen create"
             }
         }
      }
      stage('Kitchen Converge') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen converge"
             }
         }
      }
      stage('Kitchen Setup') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen setup"
             }
         }
      }
      stage('Kitchen Exec Test') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen verify"
             }
         }
      }
      stage('Kitchen clean up') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen destroy"
                sh "docker-compose down"
             }
         }
      }
   }
}
