# JMeter testing

VS Load testing is deprecated - including the cloud load test functionality! In this "poor man's load test" I execute a JMeter test to drive traffic to a URL for demo.

## CLI
```
c:\repos\tools\apache-jmeter-5.2.1\bin\jmeter -n -t CartTest.jmx -l results.jtl -Jhost=cdpartsun2-dev.azurewebsites.net
```
