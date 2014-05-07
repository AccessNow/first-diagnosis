#!/bin/bash
echo "[INSTALl]"
#sudo brew install nslookup
#sudo brew install tcptraceroute
#sudo brew install tcpdump
#sudo brew install wget
#sudo brew install gnu-tar 
#curl http://www.thp.uni-duisburg.de/pstree/pstree.tar.gz > pstree.tar.gz
#tar xvf pstree.tar.gz
#gcc -O -o pstree pstree.c

mkdir out
cd out
echo "[LSOF && PROCESS LIST]"
#sudo ../pstree > pstree.out
sudo netstat -av > netstat.out
sudo lsof -i | grep LISTEN > lsof_listen.out
sudo lsof -i TCP -n > lsof.out

echo "[GETTING IP address]"
curl http://bot.whatismyipaddress.com/ > ip.out

echo "Checking /etc/resolv.conf, did somebody mess with our DNS setup?"
cat /etc/resolv.conf > resolv.conf.out

echo "Checking network interfaces"
ifconfig -a > ifconfig.out

echo "[NSLOOKUP]"
nslookup twitter.com > twitter_resolv.out
nslookup www.facebook.com > facebook_resolv.out
nslookup www.google.com > google_resolv.out
nslookup www.accessnow.org > acccess_resolv.out

echo "[*] Performing TCP traceroute"
sudo traceroute -P tcp -p 443 twitter.com > twitter_trace.out
sudo traceroute -P tcp -p 443 facebook.com > facebook_trace.out
sudo traceroute -P tcp -p 443 google.com > google_trace.out
sudo traceroute -P tcp -p 443 accessnow.org > access_trace.out
sudo traceroute -P tcp -p 443 eff.org > eff_trace.out

echo "[*] Capturing Traffic"
#sudo tcpdump -i any -n tcp -w tcpdump.out -c 50000
sudo tcpdump -i any -w tcpdump.out -c 50000

echo "[*] Checking /etc/hosts for malicious entries"
sudo cat /etc/hosts > etc_hosts.out

echo "[*] Checking that software update is enabled"
sudo software-update --schedule > update_check.out

echo "[*] Checking firewall rules and settings"
sudo ipfw list > ipfw.out
defaults read /Library/Preferences/com.apple.alf globalstate > firewall_state.out

echo "[*] Creating log tarball"
sudo tar -zcvf standard_logs.tar.gz /var/log
sudo tar -zcvf mac_logs.tar.gz /Library/Logs

echo "[*] Checking kernel objects"
sudo kextstat > kextstat.out

echo "[*] Checking crontab and autolaunch listings"
sudo crontab -l > crontab.out
sudo launchctl > launchctl.out

echo "[*] Compressing"
cd ..
tar zcf out.tar out
