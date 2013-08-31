function send_to_soloist(data, hostname, port)
    t = tcpip(hostname, port); 
    fopen(t); 
    fprintf(t, '%s',data)
    fclose(t); 
    delete(t); 
    clear t 
