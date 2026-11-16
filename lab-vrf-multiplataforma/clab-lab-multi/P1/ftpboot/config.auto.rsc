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
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf instance
set [ find default=yes ] router-id=10.255.0.2
/ip address
add address=10.255.0.2 comment="Router-ID OSPF/LDP" interface=loopback \
    network=10.255.0.2
add address=10.0.0.6/30 comment="Enlace PE1" interface=ether2 network=\
    10.0.0.4
add address=10.0.0.17/30 comment="Enlace P2" interface=ether3 network=\
    10.0.0.16
add address=10.0.0.50/30 comment="Enlace PE4" interface=ether4 network=\
    10.0.0.48
/ip dhcp-client
add disabled=no interface=ether1
/mpls ldp
set enabled=yes lsr-id=10.255.0.2 transport-address=10.255.0.2
/mpls ldp interface
add interface=ether2
add interface=ether3
add interface=ether4
/routing ospf interface
add interface=loopback passive=yes
add interface=ether2 network-type=point-to-point
add interface=ether3 network-type=point-to-point
add interface=ether4 network-type=point-to-point
/routing ospf network
add area=backbone network=10.255.0.0/24
add area=backbone network=10.0.0.0/24
/system identity
set name=P1