BASEDIR=/Users/jeb228/Development/VIVO/SeleniumExperiments/experiments
PROJECTDIR=/Users/jeb228/Development/VIVO/SeleniumExperiments/projects/VIVO

cd $PROJECTDIR
mvn install -s ../install-settings.xml -Dmaven.test.skip=true
cd $BASEDIR

cp $PROJECTDIR/installer/webapp/target/vivo.war $BASEDIR/executable/vivo.war
cp $PROJECTDIR/installer/solr/target/vivosolr.war $BASEDIR/executable/vivosolr.war
