node {

    withMaven(maven:'maven') {

        stage('Checkout') {
            git url: 'https://github.com/mattjamese/discovery-service.git', CredentialsID: 'mattjamese', branch: 'master'
        }

        stage('Build') {
            sh 'mvn clean install'

            def pom = readMavenPom file:'pom.xml'
            print pom.version
            env.version = pom.version
        }
        
        
        stage('RemoveOldContainers'){	    
    	    script {
				  try {
				      //sh 'docker rm -f "localhost:5000/discovery-service:${env.version}"'	
				      sh 'docker rm -f discovery'
				  } catch (Exception e) {
				     
				      build job: 'Image'
				  }
			}				     
		}

        stage('Image') {
            //dir ('discovery-service') {
                def app = docker.build "localhost:5000/discovery-service:${env.version}"
                app.push()
            //}
        }

        stage ('Run') {
            docker.image("localhost:5000/discovery-service:${env.version}").run('-p 8761:8761 -h discovery --name discovery')
        }

        stage ('Final') {
           build job: 'account-service-pipeline', wait: false
        }      

    }

}
