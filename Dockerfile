FROM oraclelinux:7

RUN yum install -y openssh-server  sudo

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN sed -i '/\/etc\/ssh\/ssh_host_dsa_key/d'     /etc/ssh/sshd_config && \
    sed -i '/\/etc\/ssh\/ssh_host_ecdsa_key/d'   /etc/ssh/sshd_config && \
    sed -i '/\/etc\/ssh\/ssh_host_ed25519_key/d' /etc/ssh/sshd_config 

RUN adduser ansible && \
    #mkdir /home/ansible/.ssh && \
    #chown -R ansible. /home/ansible && \
    echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible && \
    echo "ansible" | passwd --stdin ansible

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
