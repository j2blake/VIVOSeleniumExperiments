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
	Don't see how this can be happening. 