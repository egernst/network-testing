sudo ip netns add red
sudo ip link add redveth0 type veth peer name redveth1
sudo ip link set redveth1 netns red
sudo ip netns exec red ip addr add dev redveth1 172.17.0.30/24 
sudo ip netns exec red ifconfig redveth1 up 
sudo ip netns exec red ip route add default dev redveth1
sudo  ifconfig redveth0 up
sudo brctl addif docker0 redveth0
