pipeline {    

 	parameters {
         string(name: 'NL_WEB_TOKEN', defaultValue: '', description: 'Neoload Web token')
   		 string(name: 'NTS_LOGIN_PASSWORD', defaultValue: '', description: 'NTS login:password scrambled')
   		 string(name: 'LICENCE_ID', defaultValue: '', description: 'Licence ID')
   		 string(name: 'NTS_URL', defaultValue: '', description: 'NTS URL')
    }
       
    environment {	    
	    MY_VARIABLE = 'my variable content'
	    WORKSPACE = pwd()	    
	}
	
	agent { 
		label 'docker'    	    	
    }
	
    stages {
    	           
        stage('Display parameters') {
            steps {
            	echo "MY_VARIABLE: ${MY_VARIABLE}"
            	echo "WORKSPACE: ${WORKSPACE}"
            	echo "NL_WEB_TOKEN: ${params.NL_WEB_TOKEN}"
            	echo "NTS_LOGIN_PASSWORD: ${params.NTS_LOGIN_PASSWORD}"
            	echo "LICENCE_ID: ${params.LICENCE_ID}"
            	echo "NTS_URL: ${params.NTS_URL}"
                echo "JAVA_HOME: ${env.JAVA_HOME}"				
            }
        }
        
        // stage('Checkout'){ 
        //		git(branch: 'develop', url: 'https://github.com/SebastienRichert/nl-ascode-jenkins-pipeline.git')         
        // }
        
        stage('Create NLP file') {
            steps {               
                writeFile file: "/home/neoload/nlProject/project.nlp", text: """
# Project description file
project.name=test
project.version=6.5
project.original.version=6.5
product.name=NeoLoad
product.original.name=NeoLoad
product.version=6.10.0
product.original.version=6.9.0
project.id=1a1eb7d7-81b1-453e-9020-26a4036a53ca
project.config.path=config
project.config.storage=FOLDER
team.server.enabled=false
      """
            }
        }
        
        stage('Display NLP file') {
            steps {
	           sh "cat project.nlp"
	        }
	    }       
        
        stage('Create YAML file') {
            steps {               
                writeFile file: "/home/neoload/nlProject/project.yaml", text: """
name: MyProject
sla_profiles:
- name: MySLAProfile
  thresholds:
  - avg-request-resp-time warn >= 200ms fail >= 500ms per test
  - perc-transaction-resp-time (p90) warn >= 1s fail >= 2s per test
  - error-rate warn >= 2% fail >= 5% per test
  - error-rate warn >= 5% per interval
variables:
- constant:
    name: constant_variable
    value: 118218
user_paths:
  - name: MyUserPath1
    actions:
      steps:        
        - delay: 1000ms               
scenarios:
- name: MyScenario
  description: My scenario with 1 SLA profile and 1 population
  sla_profile: MySLAProfile
  populations:
  - name: population1
    constant_load:
      users: 1		
      duration: 1 iterations
populations:
- name: population1
  user_paths:
  - name: MyUserPath1
      """
            }
        }
        
        stage('Display YAML file') {
            steps {
	           sh "cat project.yaml"
	        }
	    }
	    
	     stage('Launch NeoLoad') {
            steps {
	          sh "/home/neoload/neoload/bin/NeoLoadCmd"+
                      " -project /home/neoload/nlProject/project.yaml"+
                      " -launch MyScenario"+
                      " -testResultName 'Load Test(build ${BUILD_NUMBER})'"+
                      " -description 'Based on project.yaml'"+
                      " -report ${env.WORKSPACE}/neoload-report/neoload-report.html,${env.WORKSPACE}/neoload-report/neoload-report.xml"+
                      " -SLAJUnitResults ${env.WORKSPACE}/neoload-report/junit-sla-results.xml"+
                      " -noGUI"+
                      " -nlweb"+
                      " -nlwebToken ${params.NL_WEB_TOKEN}"+
                      " -NTS ${params.NTS_URL}"+
                      " -NTSLogin ${params.NTS_LOGIN_PASSWORD}"+
                      " -leaseLicense ${params.LICENCE_ID}:10:1"
	        }
	    }
	    
	    
    }
}