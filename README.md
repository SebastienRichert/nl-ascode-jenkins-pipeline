# nl-ascode-jenkins-pipeline
Run a NeoLoad YAML project part of Jenkins pipeline

## Jenkins pipeline
See [Jenkinsfile](Jenkinsfile).

## Docker Jenkins Slave (from JNLP launcher)

See [Dockerfile](Dockerfile).

Based on [Jenkins JNLP Agent Docker image](https://github.com/jenkinsci/docker-jnlp-slave/) image.

With NeoLoad 6.9.0 ([neoload_6_9_0_linux_x64.sh](https://www.neotys.com/support/download-neoload)). 

Build the container: 

docker build . -t neoload-controller-jenkins-slave:latest

Start the container: 

docker run -it -d --rm --name neoload-controller-jenkins-slave neoload-controller-jenkins-slave:latest -url http://jenkins-host:jenkins-port/jenkins jenkins-secret jenkins-agent-name 

Check if the slave if running: 

http://jenkins-host:jenkins-port/jenkins/computer/

http://jenkins-host:jenkins-por/jenkins/computer/jenkins-agent-name/

## NeoLoad YAML project

See [project.yaml](nlproject/project.yaml).

See [Neotys-Labs/neoload-models](https://github.com/Neotys-Labs/neoload-models/tree/v3/neoload-project/doc/v3).






