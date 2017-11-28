#!/bin/bash

jmeter -n -t SWTTest.jmx -j testplan.log
echo "Finished ..." >> output.txt

