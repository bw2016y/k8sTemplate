#!/bin/bash

source /etc/profile
/etc/init.d/ssh start
tail -f /dev/null
