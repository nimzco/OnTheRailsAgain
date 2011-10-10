sudo passenger stop --pid-file tmp/pids/passenger.80.pid
sudo passenger start -p 80 --user=server -e production -d
