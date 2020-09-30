# neuron_client

import base64
import sys, socket, select
from cryptography.fernet import Fernet
import os
import hashlib
import signal

os.system("cls")

def sigint_handler(signum, frame):
    print('\n user interrupt! shutting down')
    print("Shutting down server \n\n")
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


def chat_client():
    if(len(sys.argv) < 5) :
        print('Usage : python neuron.py <hostname> <port> <password> <nick_name>')
        sys.exit()

    host = sys.argv[1]
    port = int(sys.argv[2])
    key32 = hashlib.md5(sys.argv[3].encode()).hexdigest()
    key = base64.urlsafe_b64encode(key32.encode())
    uname = sys.argv[4]

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(2)


    try :
        s.connect((host, port))

    except :
        print("\033[91m"+'Unable to connect'+"\033[0m")
        sys.exit()

    print("Connected to host. You can start sending messages")
    sys.stdout.write("\033[34m"+'\n[User:] '+ "\033[0m"); sys.stdout.flush()

    while 1:
        read_sockets = select.select([s], [], [], 1)[0]
        import msvcrt
        if msvcrt.kbhit(): read_sockets.append(sys.stdin)
        for sock in read_sockets:
            if sock == s:

                data = sock.recv(4096)

                if not data :
                    print("\033[91m"+"\nDisconnected from chat server"+"\033[0m")
                    sys.exit()
                else :
                    data = decrypt(key,data)
                    sys.stdout.write(str(data, "utf-8"))
                    sys.stdout.write("\033[34m"+'\n[Me:] '+ "\033[0m"); sys.stdout.flush()

            else :

                msg = sys.stdin.readline()
                msg = '['+ uname +':] '+msg
                msg = encrypt(key,msg.encode())
                s.send(msg)
                sys.stdout.write("\033[34m"+'\n[User:] '+ "\033[0m"); sys.stdout.flush()

if __name__ == "__main__":

    sys.exit(chat_client())
