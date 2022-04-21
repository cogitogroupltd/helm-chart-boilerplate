FROM alpine:latest
ENV USERNAME=nonroot
ARG PASSWORD # Unix password for $USERNAME
ENV PASSWORD=$PASSWORD 
RUN apk add --update --no-cache openssh nmap-scripts curl bind-tools jq nmap-ncat bash nmap
RUN apk add --no-cache python3 && ln -sf python3 /usr/bin/python # required for sshuttle
RUN adduser -h /home/$USERNAME -s /bin/bash -D $USERNAME
RUN echo -n "$USERNAME:$PASSWORD" | chpasswd

RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config && \
 sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config && \
 sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
 ssh-keygen -A

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]