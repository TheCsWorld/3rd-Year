#neuron_server

import configparser
import base64
import sys, socket, select
from cryptography.fernet import Fernet
import hashlib
import os
import signal

os.system("cls")

def sigint_handler(signum, frame):
    print('\n user interrupt! shutting down')
    print("[info] shutting down server \n\n")
    sys.exit()	
    
signal.signal(signal.SIGINT, sigint_handler)

def encrypt(secret,data):
	cipher = Fernet(secret)
	encoded = cipher.encrypt(data)
	return encoded

def decrypt(secret,data):
    try:
        cipher = Fernet(secret)
        decoded = cipher.decrypt(data)
    except Exception as e:
        return data;
    return decoded

config = configparser.RawConfigParser()   
config.read(r'server.conf')

HOST = config.get('config', 'HOST')
PORT = int(config.get('config', 'PORT'))
VIEW = str(config.get('config', 'VIEW'))
PASSWORD = str(config.get('config', 'PASSWORD'))
key32 = hashlib.md5(PASSWORD.encode()).hexdigest()
key = base64.urlsafe_b64encode(key32.encode())
SOCKET_LIST = []
RECV_BUFFER = 4096


def chat_server():

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind((HOST, PORT))
    server_socket.listen(10)

    SOCKET_LIST.append(server_socket)

    print("server started on port " + str(PORT))

    while 1:

        ready_to_read,ready_to_write,in_error = select.select(SOCKET_LIST,[],[],0)

        for sock in ready_to_read:

            if sock == server_socket:
                sockfd, addr = server_socket.accept()
                SOCKET_LIST.append(sockfd)
                print("user (%s, %s) is connected" % addr)

                broadcast(server_socket, sockfd, encrypt(key,("[%s:%s] has entered group\n" % addr).encode()))

            else:
                try:
                    data = sock.recv(RECV_BUFFER)
                    data = decrypt(key,data)
                    
                    if data:
                        broadcast(server_socket, sock,encrypt(key,data))
                        if VIEW == '1':
                          print(data)
                        
                    else:
                        if sock in SOCKET_LIST:
                            SOCKET_LIST.remove(sock)

                        broadcast(server_socket, sock,encrypt(key,("user (%s, %s) is offline\n" % addr).encode()))

                except Exception as e:
                    print(e)
                    broadcast(server_socket, sock, ("user (%s, %s) is offline\n" % addr).encode())
                    continue

    server_socket.close()

def broadcast (server_socket, sock, message):
    for socket in SOCKET_LIST:
        if socket != server_socket and socket != sock :
            try :
                socket.send(message)
            except:
                
                socket.close()

                if socket in SOCKET_LIST:
                    SOCKET_LIST.remove(socket)

if __name__ == "__main__":

    sys.exit(chat_server())
