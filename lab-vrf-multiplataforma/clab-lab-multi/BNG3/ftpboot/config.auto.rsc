# 2026-11-16 21:50:28 by RouterOS 7.22.3
# system id = VFRubXOUgcC
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
/ip address
/ip dhcp-client
add interface=ether1 name=client1
/system identity
set name=BNG3