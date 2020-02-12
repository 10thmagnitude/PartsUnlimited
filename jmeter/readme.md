# JMeter testing

VS Load testing is deprecated - including the cloud load test functionality! In this "poor man's load test" I execute a JMeter test to drive traffic to a URL for demo.

## CLI
```
c:\repos\tools\apache-jmeter-5.2.1\bin\jmeter -n -t CartTest.jmx -l results.jtl -Jhost=cdpartsun2-dev.azurewebsites.net
```

## Docker
Use `test.sh` (which calls `run.sh`) to run a Docker container with JMeter and execute the test.

Example:
```bash
./test.sh $PWD CartTest.jmx cdpartsun2-dev.azurewebsites.net
```

> **NOTE FOR WSL**: You cannot use `$PWD` for WSL because of the way volume mapping works. Instead, use the _Windows_ path for the volume mapping.

Example:
```bash
./test.sh 'C:\repos\10m\partsunlimited\jmeter' CartTest.jmx cdpartsun2-dev.azurewebsites.net
```
