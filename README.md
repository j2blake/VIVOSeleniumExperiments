# Selenium Experiments

## What are we doing?

* Eventually, trying to set up a process of running Selenium tests against VIVO, as part of the continuous integration process.
	* Failing that, a process to run the Selenium tests on a local machine, in a highly automated manner, as part of the release process.

## What's the plan?

### Testable VIVO implementation

* Create a version of VIVO that
	* Starts and stops quickly.
	* Resets the data stores on each shutdown.
	* Requires no installation of supporting infrastructure.

* How is that going?
	* **Transient RDFService implementations**
	* Transient SearchEngine implementation
	* Transient FileStorage implementation 

	
### Selenium scripts

* Create tests
	* In Java or in Ruby
	* Either in a test harness (JUnit, RSpec) or not
	* Collected into "suites"
	* Tests within a suite run in sequence. One failure will stop the suite.
	* Suites run independently, in any order; if one suite fails, the others still run.

* How is that going?
	* **Start VIVO (and Solr) in JettyRunner**
	* Run a Selenium suite in Chrome, starting and stopping VIVO
	* Create a file of test user accounts for auth/everytime
	* Implement most (or all) of legacy Selenium tests and suites.

	
## Test it

* Run the maven script (in the SeleniumVIVO project directory) and copy the executables over here.

	```
	./scripts/build_it.sh
	```
* Copy the basic home directory from the build project, and add the specific config files.

	```
	./scripts/get_it.sh
	```

* Start JettyRunner with VIVO and Solr -- cntl-C to stop.

	```
	./scripts/do_it.sh     # start JettyRunner with VIVO; cntl-C to stop
	```

## Known issues

* `web.xml` specifies instances of `org.apache.catalina.filters.ExpiresFilter`, which is specific to Tomcat.
These must be commented out prior to build-time, or Jetty will fail.
	* Is there another way to get around this?
	* The class appears in lib/catalina.jar. Are there dependencies to other JARs?

* We are seeing many of these messages in `vivo.all.log`

	```
	2019-02-06 11:43:20,093 WARN  [JoinedOntModelCache] These model names appear in both caches: [http://vitro.mannlib.cornell.edu/ns/vitro/sdb/metadata]
	```
	* Don't see how this can be happening. 

* Solr smoke test fails:

	```
	2019-02-06 12:50:33,248 WARN  [StartupStatus] From SolrSmokeTest: Can't connect to the Solr search engine. The host refused the connection. Is it possible that the port number is incorrect? Check the value of vitro.local.solr.url in runtime.properties.
	java.net.ConnectException: Connection refused (Connection refused)
		at java.net.PlainSocketImpl.socketConnect(Native Method)
		at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
		at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
		at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
		at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
		at java.net.Socket.connect(Socket.java:589)
		at org.apache.http.conn.scheme.PlainSocketFactory.connectSocket(PlainSocketFactory.java:121)
		at org.apache.http.impl.conn.DefaultClientConnectionOperator.openConnection(DefaultClientConnectionOperator.java:180)
		at org.apache.http.impl.conn.ManagedClientConnectionImpl.open(ManagedClientConnectionImpl.java:326)
		at org.apache.http.impl.client.DefaultRequestDirector.tryConnect(DefaultRequestDirector.java:610)
		at org.apache.http.impl.client.DefaultRequestDirector.execute(DefaultRequestDirector.java:445)
		at org.apache.http.impl.client.AbstractHttpClient.doExecute(AbstractHttpClient.java:835)
		at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:83)
		at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:108)
		at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:56)
		at edu.cornell.mannlib.vitro.webapp.servlet.setup.SolrSmokeTest$SolrHomePager.tryToConnect(SolrSmokeTest.java:240)
		at edu.cornell.mannlib.vitro.webapp.servlet.setup.SolrSmokeTest$SolrHomePager.connect(SolrSmokeTest.java:219)
		at edu.cornell.mannlib.vitro.webapp.servlet.setup.SolrSmokeTest$SolrSmokeTestThread.run(SolrSmokeTest.java:100)
	```	
	* Don't see why this is happening. The Solr index is rebuilt successfully. 
	* After replacing the Solr index, we shouldn't care.
	
## References

### jetty-runner
[https://www.eclipse.org/jetty/documentation/9.4.x/runner.html](https://www.eclipse.org/jetty/documentation/9.4.x/runner.html)