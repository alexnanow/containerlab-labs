# 2026-11-16 21:50:28 by RouterOS 7.22.3
# system id = 9pHgBWaEEyK
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface vlan
add interface=ether2 name=vlan100-VRF-CGNAT-BNG vlan-id=100
/interface list
add name=CGNAT-IFACES
/ip pool
add name=pool-cgnat ranges=100.64.0.2-100.64.0.254
/ip vrf
add interfaces=CGNAT-IFACES name=CGNAT
/ppp profile
add interface-list=CGNAT-IFACES local-address=100.64.0.1 name=profile-cgnat \
    remote-address=pool-cgnat
/routing bgp instance
add as=65501 name=bgp-cgnat router-id=10.100.0.2
/routing bgp template
add as=65501 name=bgp-cgnat-template output.network=bgp-networks \
    routing-table=CGNAT vrf=CGNAT
/interface list member
add interface=vlan100-VRF-CGNAT-BNG list=CGNAT-IFACES
/interface pppoe-server server
add default-profile=profile-cgnat disabled=no interface=ether3 service-name=\
    PPPoE-CGNAT
/ip address
add address=10.100.0.2/30 interface=vlan100-VRF-CGNAT-BNG network=10.100.0.0
/ip dhcp-client
add interface=ether1 name=client1
/ip firewall address-list
add address=100.64.0.0/24 list=bgp-networks
/ip route
add blackhole dst-address=100.64.0.0/24 vrf-interface=CGNAT
/ppp secret
add name=cli1
add name=cli1 service=pppoe
/routing bgp connection
add connect=yes instance=bgp-cgnat listen=yes local.address=10.100.0.2 .role=\
    ebgp name=peer-10.100.0.1 remote.address=10.100.0.1 .as=65500 templates=\
    bgp-cgnat-template
/system identity
set name=BNG2