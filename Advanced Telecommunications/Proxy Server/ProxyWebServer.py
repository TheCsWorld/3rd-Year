import socket, sys
import threading
import _thread
from threading import *
import hashlib
import os
import http.server
import urllib.request
import datetime
import ssl
#block urls
try:
    block_urls = str(input("Enter blocked URLs with comma to split:"))
    block_url_list = block_urls.split(",")
except KeyboardInterrupt:
    print("\n User Requested Interrupt")
    print("Closing")
    sys.exit()

max_conn = 5
buffer_size = 18192


def start():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)   #create socket
        s.bind(('127.0.0.1', 8080))
        s.listen(max_conn)
        print("Initializing Sockets ... Done")
        print("Sockets Binded Successfully")
        print("Server Started Successfully [ %d ]\n" % (8080))

    except Exception as e:
        print("Unable To Initialize Socket")
        sys.exit(2)

    while 1:
        try:
            conn, addr = s.accept()
            data = conn.recv(buffer_size)
            _thread.start_new_thread(conn_string, (conn, data, addr))   #create thread
        except KeyboardInterrupt:
            s.close()
            print("\n Proxy Server Shutting Down")
            print("Bye Bye!")
            sys.exit(1)

    s.close()


def conn_string(conn, data, addr):
    try:
        first_line = data.decode()
        tmp_split = first_line.split(' ')
        method = tmp_split[0]
        url = tmp_split[1]

        is_https = -1

        # Check if the url is blocked
        for blocked_url in block_url_list:
            if blocked_url in url:
                print("Close Connection from blacklisted url %s" % str(url))
                conn.close()
                return

        http_pos = url.find("://")
        if http_pos == -1:
            temp = url
        elif method == "GET":           #if http
            temp = url[(http_pos + 3):]
        else:                           #if https
            temp = url[(http_pos + 4):]
            is_https = 1
        port_pos = temp.find(":")

        webserver_pos = temp.find("/")
        if webserver_pos == -1:
            webserver_pos = len(temp)
        webserver = ""
        port = -1
        if (port_pos == -1 or webserver_pos < port_pos):
            port = 80
            webserver = temp[:webserver_pos]
        else:
            port = int((temp[(port_pos + 1):])[:webserver_pos - port_pos - 1])  #443
            webserver = temp[:port_pos]

        proxy_server(webserver, port, conn, data, addr, url, is_https, method)
    except Exception as e:
        print("Connection Exception %s" % (e))
        pass

# cache page
def cache_url(url, is_https):
    try:
        m = hashlib.md5()
        m.update(url.encode('utf-8'))
        cache_filename = m.hexdigest() + ".cached"

        if os.path.exists(cache_filename):
            end = str(datetime.datetime.now())
            print("Cache hit")
        else:
            print("Cache miss %s" % url)
            if (is_https != 1):
                data = urllib.request.urlopen(url).readlines()
                open(cache_filename, 'wb').writelines(data)


    except Exception as e:
        print("Cache Exception %s" % (e))
        pass


def proxy_server(webserver, port, conn, data, addr, url, is_https, method):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        # https request
        if method == "CONNECT":
            s.connect((webserver, 443))
            reply = "HTTP/1.0 200\r\n\r\n"      #let client know connection has been established
            conn.sendall(reply.encode())
            conn.setblocking(0)
            s.setblocking(0)

            while True:
                try:
                    request = conn.recv(buffer_size)
                    s.sendall(request)
                except socket.error as e:
                    pass
                try:
                    reply = s.recv(buffer_size)
                    start = datetime.datetime.now()
                    conn.send(reply)  # Send reply back to client
                    bw = float(len(reply))
                    # Send notification to Proxy Server
                    bw = float(bw / 1024)
                    bw = "%.3s" % (str(bw))
                    bw = "%s KB" % (bw)
                    print("Request Done: %s -> %s ; %s" % (str(addr[0]), str(bw), str(url)))
                    cache_url(url, is_https)
                    end = datetime.datetime.now()
                    diff = (end - start).total_seconds()
                    print("Total Response Time %s " % (str(diff)))
                except socket.error as e:
                    pass

        else:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((webserver, port))
            s.sendall(data)
            while 1:
                reply = s.recv(buffer_size)

                if (len(reply) > 0):
                    start = datetime.datetime.now()   #start timer
                    conn.send(reply)  # Send reply back to client
                    bw = float(len(reply))
                    # Send time and bandwidth to Proxy Server
                    bw = float(bw / 1024)
                    bw = "%.3s" % (str(bw))
                    bw = "%s KB" % (bw)
                    # 'Pring A Custom Message For Request Complete'
                    print("Request Done: %s -> %s ; %s" % (str(addr[0]), str(bw), str(url)))

                    cache_url(url, is_https)
                    end = datetime.datetime.now()
                    diff = (end - start).total_seconds()
                    print("Total Response Time %s " % (str(diff)))
                else:
                    break
            s.close()
            conn.close()
    except socket.error as message:
        s.close()
        conn.close()
        sys.exit(1)


start()

