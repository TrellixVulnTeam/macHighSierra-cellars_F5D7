#!/bin/bash
PYTHONPATH="/usr/local/Cellar/cassandra/3.11.0/libexec/vendor/lib/python2.7/site-packages" exec "/usr/local/Cellar/cassandra/3.11.0/libexec/bin/cqlsh.py" "$@"
