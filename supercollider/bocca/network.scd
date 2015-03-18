Mac OSX

Jack server
1. Open JackPilot
2. Before starting the jack server open Preferences..
	set input and output devices
	sample rate (48000) and buffer size (512)
	Save
3. Start Jack server

Router port forwarding
4. Open web browser and log into 192.168.0.1 user: admin, pwd: tartu...
5. Go to Advanced settings
6. Enter these settings: start port: 4464, end port: 4464, protocol: TCP&UDP, 
	ip: computer ip address
7. Add Rule & Apply

jacktrip
8. Open Terminal
9. if running jacktrip as server enter:
>jacktrip -s
	otherwise enter:
>jacktrip -c [server's public ip]

jack routing
10. Either open QJackCtl or click on 'Routing' in JackPilot
11. Connect JackTrip receive_1 to SuperCollider in_1 and receive_2 to SuperCollider in_2
12. Connect SuperCollider out_1 to JackTrip send_1 and SuperCollider out_2 to JackTrip send_2

