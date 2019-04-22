pipeline {    
    
    environment {	    
	    MY_VARIABLE = 'my variable content'
	    WORKSPACE = pwd()
	}
	
	agent { 
		label 'docker'    	    	
    }
	
    stages {
                   
        stage('Display environment variables') {
            steps {
                echo "JAVA_HOME is ${env.JAVA_HOME} on this machine"
				echo "MY_VARIABLE is ${MY_VARIABLE}"
            }
        }
        
        // stage('Checkout'){ 
        //		git(branch: 'develop', url: 'https://github.com/SebastienRichert/nl-ascode-jenkins-pipeline.git')         
        // }
        
        stage('Create YAML file') {
            steps {               
                writeFile file: "project.yaml", text: """
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
- file:
    name: cities_file
    description: cities variable file description
    column_names: ["City", "Country", "Population", "Longitude", "Latitude"]
    is_first_line_column_names: false
    start_from_line: 5
    delimiter: ";"
    path: data/list_of_cities.csv
    change_policy: each_user
    scope: unique
    order: sequential
    out_of_value: stop_test
- file:
    name: cities2_file
    description: cities2 variable file description
    is_first_line_column_names: true
    start_from_line: 1
    delimiter: ";"
    path: data/list_of_cities.csv
    change_policy: each_page
    scope: local
    order: random
    out_of_value: no_value_code
- counter:
    name: My Counter
    start: 0
    end: 1
    increment: 10
    change_policy: each_iteration
    scope: local
    out_of_value: cycle
- random_number:
    name: MyRandomNumberSansPredictable
    min: 9999
    max: -1
user_paths:
  - name: MyUserPath1
    actions:
      steps:
        - javascript:
            name: My Javascript
            description: My description
            script: |
              // Get variable value from VariableManager
              var myVar = context.variableManager.getValue("CounterVariable_1");
              logger.debug("ComputedValue="+myVar);
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
	           neoloadRun executable: '/home/neoload/bin/NeoLoadCmd', 
	           		project: 'project.yaml', 
	           		scenario: 'myScenario', 
	           		trendGraphs: ['AvgResponseTime', 'ErrorRate']
	        }
	    }
	    
	    
    }
}