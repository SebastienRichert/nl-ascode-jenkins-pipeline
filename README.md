# nl-ascode-jenkins-pipeline
Run a NeoLoad YAML project part of Jenkins pipeline

## Docker Jenkins Slave (from JNLP launcher)

Based on docker image:
[Jenkins JNLP Agent Docker image](https://github.com/jenkinsci/docker-jnlp-slave/)

With NeoLoad 6.10.0 (neoload_6_10_0_linux_x64.sh). See [Dockerfile](Dockerfile).

Build the container: 
docker build . -t neoload-controller-jenkins-slave:latest

Start the container: 
docker run -it -d --rm --name neoload-controller-jenkins-slave neoload-controller-jenkins-slave:latest -url http://<jenkins-host>:<jenkins-port>/jenkins <jenkins-secret> <jenkins-agent-name> 

Check if the slave is running: 
http://<jenkins-host>:<jenkins-port>/jenkins/computer/
http://<jenkins-host>:<jenkins-port>/jenkins/computer/<jenkins-agent-name>/

## NeoLoad YAML project
See [project.yaml](project.yaml).
See [Neotys-Labs/neoload-models](https://github.com/Neotys-Labs/neoload-models/tree/v3/neoload-project/doc/v3).

## Jenkins pipeline
See [Jenkinsfile](Jenkinsfile).




