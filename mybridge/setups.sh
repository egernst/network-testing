sudo ip netns add blue
sudo ip link add veth0 type veth peer name veth1
sudo ip link set veth1 netns blue
sudo ip netns exec blue ip addr add dev veth1 192.168.0.30/24 
sudo ip netns exec blue ifconfig veth1 up 
sudo  ifconfig veth0 up

sudo brctl addif mybridge veth0
