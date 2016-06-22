#! /bin/bash
for i in api scheduler conductor consoleauth novncproxy compute ; do sudo service nova-$i restart; done;
