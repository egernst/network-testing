sudo brctl addbr mybridge
sudo brctl addif mybridge eth1
sudo ip address add dev mybridge 192.168.0.12/24
sudo ifconfig mybridge up
