BASEDIR=/Users/jeb228/Development/VIVO/SeleniumExperiments/experiments
java -Dcatalina.base=$BASEDIR \
     -Dvitro.home=$BASEDIR/home \
     -Dsolr.solr.home=$BASEDIR/home/solr \
     -jar $BASEDIR/executable/jetty-runner-9.4.9.v20180320.jar \
     --out $BASEDIR/logs/jetty_runner.log \
     --log $BASEDIR/logs/request.log \
     --path /vivosolr $BASEDIR/executable/vivosolr.war \
     --path /vivo $BASEDIR/executable/vivo.war
