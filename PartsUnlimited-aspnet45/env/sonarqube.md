# SonarQube integration

## Create SonarQube ACI
1. Run this command: `az container create -g cd-pu3-sqube --name cdpu3squbeaci --image sonarqube --ports 9000 --dns-name-label cdpu3squbeaci --cpu 2 --memory 3.5 -l centralus`
1. Log in to `http://cdpu3squbeaci.centralus.azurecontainer.io:9000`
1. Update admin credentials
1. Create Project `PartsUnlimited`, key `PartsUnlimited`

## Add js exclusion
1. Open project admin and navigate to `Admin->General->Analysis Scope`
1. Exclude 
   ```
   **/*.js
   **/*.css
   **/*.html
   ```
   under `Code Coverage` and `Source File Exclusions`

## Create a Quality Gate
1. Copy `Sonar way`
1. Take thresholds down
1. Enroll project in new Gate

## For the build
1. Create a key and update the service endpoint `SonarACI`
1. Update `sonarUrl` to `'http://cdpu3squbeaci.westus2.azurecontainer.io:9000'`


### References
[https://www.azuredevopslabs.com/labs/vstsextend/sonarqube/](https://www.azuredevopslabs.com/labs/vstsextend/sonarqube/)
