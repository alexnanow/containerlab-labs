# nov/16/2026 21:50:28 by RouterOS 6.49.15
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing bgp instance
set default as=65501 router-id=10.100.0.6
/ip address
add address=10.100.0.6/30 interface=ether2 network=10.100.0.4
add address=10.1.0.2/30 interface=ether3 network=10.1.0.0
/ip dhcp-client
add disabled=no interface=ether1
/ip route
add distance=1 gateway=10.1.0.1
add distance=1 dst-address=192.168.48.0/26 type=blackhole
/routing bgp network
add network=192.168.48.0/26
/routing bgp peer
add default-originate=if-installed name=PE2-VRF-BNG out-filter=CGNAT-OUT \
    remote-address=10.100.0.5 remote-as=65500
add name=PE2-VRF-WAN out-filter=CGNAT-WAN-OUT remote-address=10.1.0.1 \
    remote-as=65500
/routing filter
add action=accept chain=CGNAT-OUT prefix=0.0.0.0/0 prefix-length=0
add action=discard chain=CGNAT-OUT
add action=accept chain=CGNAT-WAN-OUT prefix=192.168.48.0/26
add action=discard chain=CGNAT-WAN-OUT
/routing prefix-lists
add chain=CGNAT-OUT prefix-length=0
add action=discard chain=CGNAT-OUT
/system identity
set name=CGNAT1