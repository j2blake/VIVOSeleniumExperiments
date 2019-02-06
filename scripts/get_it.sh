BASEDIR=/Users/jeb228/Development/VIVO/SeleniumExperiments/experiments
PROJECTDIR=/Users/jeb228/Development/VIVO/SeleniumExperiments/projects/VIVO

rm -r $BASEDIR/home
cp -R $PROJECTDIR/installer/home/target/vivo-installer-home-1.11.0-SNAPSHOT/ $BASEDIR/home

cp $BASEDIR/config/applicationSetup.n3 $BASEDIR/home/config
cp $BASEDIR/config/runtime.properties $BASEDIR/home/config
