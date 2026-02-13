# cdt-covert-timing-channel

#Done, tested, works

#Make sure to change Client IP in server before sending

Attention all users: This tool is explicitly made for ethical use purposes only and any adaptation or use of this for malicious purposes is prohibited. 

Tool Overview: This tool is created to send a message to a blue team device and stay connected with random continuous callbacks for as long as the script is running on the blue team device. This is useful for Red Team to ensure we are still connected to Blue Team's machines. This tool fits into the Beacon/Callback category as it is a callback script. This tool runs via 2 scripts, one on the client and one on the server. The server will send it's public key and the client will respond with an RSA encrypted Fernet key in order to decrypt the messages sent from the client. After, the client will send the message on reandom intervals (between 1 and 100 seconds) and the server will recieve the message, wait 1 - 100 seconds and respond with a "Connected" message.

Requirements and Dependecies:  Target OS: Linux  Required Libraries: python3, libpcap-dev, python3-cryptography, python3-scapy - To install: sudo apt update  sudo apt install python3 libpcap-dev  sudo apt install python3-cryptography python3-scapy  This tool does require root privilege to run because it's sniffing network traffic. The server script needs to be updated with the Client IP on line 41 before deploying to server machine.

Installation Instruction: Ensure machine is updated and has required packages installed (see above) then download the icmp_client.py file on Red Team machine and icmp_server.py file on Blue Team Machine. Run the client before the server, using python3 icmp_(client/server).py. Check client terminal and input message and server IP, once "Sent key" message is visible, it will continue running.

Usage Instructions: Run using python3 icmp_client.py and python3 icmp_server.py on the respected machines. Both files are .py Python files. Run this once we have a connection to a Blue Team machine to ensure the connection stays until Blue Team finds it and terminates it. Can implement running the message on command line if we need another C2, as well as using icmpsh or icmpdoor to get access to a terminal on Blue Team Machines.

Example Output on Client:  Enter Message: Hello World  Enter Target IP:  10.0.6.42  Sent key to server  Sent packet to server  MSG:"Connected"  (Will repeat "Sent packet to server" and "MSG:Connected" while server is running)

Example Output on Server: Nothing, we want it to be stealthy

Operational Notes: Use this in competition scenarios to get Blue Team to know Red Team is still in their system. Red Team can use it to know they still have access to that Blue Team mcahine. This tool will create ICMP traffic with a "Data" field, however all data is encrypted so Blue Team won't see the data in plain text. It will also show a terminal running for this process. The cleanup process is to delete the icmp_server.py file from the Blue Team machine. This will terminate the connection.

Limitations: Currently this tool does not send any commands to the command line but it can be implemented fairly easily. There are no known bugs or issues. Future improvement ideas are to implement it as a background process so it's more stealthy.

Credits and References:  https://scapy.readthedocs.io/en/latest/usage.html  https://github.com/secdev/scapy/tree/master  https://www.sciencedirect.com/science/article/abs/pii/S1389128612003623
