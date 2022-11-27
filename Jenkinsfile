def getDockerTag() {
 def tag = sh script: 'git rev-parse HEAD', returnStdout: true 
 return tag
}
pipeline {
    agent any
    environment {
          Docker_tag = getDockerTag()
          VERSION = "${env.BUILD_ID}"
      }

    stages{
    stage('SCM Checkout of Reporting Service'){
      steps {
          checkout([
                $class: 'GitSCM',
                branches: [[name: '*/dev']],
                extensions: [], 
                submoduleCfg: [], 
                userRemoteConfigs: [[url: 'https://github.com/Akashdeep-Munjal/my-app.git']]
            ]
             )    
      }
             }   
    
    stage('Quality Gate Status Check'){
        agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
             }
                  steps{
                      script{
           withSonarQubeEnv('sonarserver') { 
           sh "mvn sonar:sonar"
                             }
           timeout(time: 1, unit: 'HOURS') {
           def qg = waitForQualityGate()
              if (qg.status != 'OK') {
            error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
                       }
             sh "mvn clean install"
      
                   }
                }  
              }  

    stage('Test API'){
         steps {
           script{
                
                sh '''
                dir('target/') 
                pushd .
                nohup java -jar my-app-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
                serverPID=$!
                sleep 2m
                newman run ../../DevOps-Assessment.postman_collection.json
                kill $serverPID
         '''
        }
                
           }
         }

    stage('build'){
          steps {
            script{
                sh ' docker build . -t akashmunjal/my-app-repo:$Docker_tag'
                withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
    
                sh '''
                 docker login -u akashmunjal -p $docker_password
                 docker push akashmunjal/my-app-repo:$Docker_tag
                '''
                }
                
            }
          }
              }
              
      stage('deploy-my-app-0'){
                  
                  agent {label 'my-app-0'}
              steps {
                  script{
                sh 'docker pull akashmunjal/my-app-repo:$Docker_tag'
                withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
    
                sh '''
                if [ ! "$(docker ps -q -f name=my-app)" ]; then
                if [ "$(docker ps -aq -f status=exited -f name=my-app)" ]; then
               # cleanup
               docker stop my-app
               docker rm my-app
               fi
              # run your container
              docker run --name my-app -d -p 8080:8080 akashmunjal/my-app-repo:$Docker_tag
              fi
                
             '''
        }
                  }
              }
            }
            
      stage('deploy-my-app-1'){
                  
                  agent {label 'my-app-1'}
              steps {
                  script{
                sh 'docker pull akashmunjal/my-app-repo:$Docker_tag'
                withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
    
                sh '''
                if [ ! "$(docker ps -q -f name=my-app)" ]; then
                if [ "$(docker ps -aq -f status=exited -f name=my-app)" ]; then
               # cleanup
               docker stop my-app
               docker rm my-app
               fi
              # run your container
              docker run --name my-app -d -p 8080:8080 akashmunjal/my-app-repo:$Docker_tag
              fi
                
             '''
        }
                  }
              }
            }
            
      stage('deploy-my-app-2'){
                  
                  agent {label 'my-app-2'}
              steps {
                  script{
                sh 'docker pull akashmunjal/my-app-repo:$Docker_tag'
                withCredentials([string(credentialsId: 'docker_password', variable: 'docker_password')]) {
    
                sh '''
                if [ ! "$(docker ps -q -f name=my-app)" ]; then
                if [ "$(docker ps -aq -f status=exited -f name=my-app)" ]; then
               # cleanup
               docker stop my-app
               docker rm my-app
               fi
              # run your container
              docker run --name my-app -d -p 8080:8080 akashmunjal/my-app-repo:$Docker_tag
              fi
                
             '''
        }
                  }
              }
            }
    // stage('email-notification'){
    // post {
    // always {
    //  mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "akashmunjal002@gmail.com";  
    //  }
    // }
    //  }
    }  
               }