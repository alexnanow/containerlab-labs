# RouterOS 7.22 configuration
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface vlan
add interface=ether2 name=vlan100-VRF-CGNAT-BNG vlan-id=100
/ip pool
add name=pool-cgnat ranges=100.64.0.2-100.64.0.254
/ppp profile
add local-address=100.64.0.1 name=profile-cgnat remote-address=pool-cgnat
/interface pppoe-server server
add default-profile=profile-cgnat disabled=no interface=ether3 service-name=\
    PPPoE-CGNAT
/ip address
add address=10.100.0.2/30 interface=vlan100-VRF-CGNAT-BNG network=10.100.0.0
/ip dhcp-client
add disabled=no interface=ether1
/ip route
add distance=1 dst-address=100.64.0.0/24 type=blackhole
/ppp secret
add name=cli1 password=cli1 profile=profile-cgnat service=pppoe
/ip firewall address-list
add list=bgp-networks address=100.64.0.0/24
/routing bgp instance
add as=65500 name=bgp-65500
/routing bgp template
add as=65500 name=bgp-65500-template router-id=10.100.0.2 \
    output.network=bgp-networks
/routing bgp connection
add connect=yes instance=bgp-65500 listen=yes local.address=10.100.0.2 \
    local.role=ibgp name=peer-10.100.0.1 remote.address=10.100.0.1 \
    remote.as=65500 templates=bgp-65500-template
/system identity
set name=BNG1
