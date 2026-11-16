# nov/16/2026 21:50:29 by RouterOS 6.49.15
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether2 name=pppoe-out1 \
    password=cli1 user=cli1
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip address
/ip dhcp-client
add disabled=no interface=ether1
/routing filter
add action=accept chain=CGNAT-OUT prefix=0.0.0.0/0 prefix-length=0
add action=discard chain=CGNAT-OUT
add action=accept chain=CGNAT-WAN-OUT prefix=192.168.48.0/26
add action=discard chain=CGNAT-WAN-OUT
/system identity
set name=CLI1