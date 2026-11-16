# nov/16/2026 21:50:28 by RouterOS 6.49.15
# software id = 
#
#
#
/interface bridge
add name=loopback protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] router-id=10.255.0.7
/ip address
add address=10.255.0.7 comment="Router-ID OSPF/LDP" interface=loopback \
    network=10.255.0.7
add address=10.0.0.49/30 comment="Enlace P1" interface=ether2 network=\
    10.0.0.48
add address=10.0.0.41/30 comment="Enlace P2" interface=ether3 network=\
    10.0.0.40
/ip dhcp-client
add disabled=no interface=ether1
/mpls ldp
set enabled=yes lsr-id=10.255.0.7 transport-address=10.255.0.7
/mpls ldp interface
add interface=ether2
add interface=ether3
/routing ospf interface
add interface=ether2 network-type=point-to-point
add interface=ether3 network-type=point-to-point
add interface=loopback passive=yes
/routing ospf network
add area=backbone network=10.0.0.0/24
add area=backbone network=10.255.0.0/24
/system identity
set name=PE4