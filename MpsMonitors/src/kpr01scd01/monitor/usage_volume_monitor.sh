source /home/calldmp/.bashrc
cd /home/calldmp/bin/monitors
./usage_volume_monitor.py > usageVolumeMonitor.log 2> usageVolumeMonitor.err
mv *.png /home/calldmp/bin/apache-tomcat-9.0.21/webapps/WebMonitor/images
mv *html  /home/calldmp/bin/apache-tomcat-9.0.21/webapps/WebMonitor/ini
