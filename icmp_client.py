# -*- coding: utf-8 -*-
"""ICMP Client.ipynb

"""

#Hide info in echo request/reply
#normally 32 bits per packet
#Up to 1472 bytes per payload

#icmpsh C2

#icmpdoor C2

#Design to match normal ping traffic


from scapy.all import *
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import serialization
import time
import base64



def generate_key(public_key):
  key = Fernet.generate_key()
  encrypted_key = public_key.encrypt(key, padding.OAEP(mgf=padding.MGF1(algorithm=hashes.SHA256()), algorithm=hashes.SHA256(), label=None))
  return key, encrypted_key

def encode_message(message, key):
  f = Fernet(key)
  encoded = message.encode()
  encrypted_message = f.encrypt(encoded)
  return encrypted_message

def send_key(target_ip, key):
  encoded_key = base64.urlsafe_b64encode(key)
  packet = IP(dst=target_ip)/ICMP()/Raw(load=b"KEY:" + encoded_key)
  send(packet, verbose=0)
  time.sleep(0.2)

def create_packet(target_ip, encrypted):
    packet = IP(dst=target_ip)/ICMP()/Raw(load=b"MSG:" + encrypted)
    send(packet, verbose=0)
    time.sleep(0.2)
    return "Packet sent complete"

def get_key():

  public_key = None
  
  def get_packet(packet):

    nonlocal public_key 
    if packet.haslayer(ICMP) and packet.haslayer(Raw):
      payload = packet[Raw].load

      if payload.startswith(b"PUB:"):
        encrypted_key = payload[4:]
        public_key = serialization.load_pem_public_key(encrypted_key)
        return True
    return False
  sniff(filter="icmp", prn=get_packet, stop_filter=get_packet)
  return public_key

def main():
  public_key = get_key()
  key, encrypted_key = generate_key(public_key)
  print("Enter message: ")
  message = input()
  print("Enter target IP: ")
  target_ip = input()
  send_key(target_ip, key)
  print("Sent key to server")
  encrypted = encode_message(message, key)
  create_packet(target_ip, encrypted)
  print("Sent packet to Server")

if(__name__ == "__main__"):
  main()
