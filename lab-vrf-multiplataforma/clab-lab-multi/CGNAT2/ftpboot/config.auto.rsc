# nov/16/2026 21:50:28 by RouterOS 6.49.19
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
/ip address
/ip dhcp-client
add disabled=no interface=ether1
/system identity
set name=CGNAT2