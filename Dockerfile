FROM  docker.io/centos
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN   yum install httpd python36 -y
RUN  sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
RUN echo "print('Hello, world!')" >  mail.py  &&  chmod u+x mail.py
COPY  src/  /var/www/html/
RUN chown apache:apache  /var/run/httpd  /var/log/httpd  
RUN chmod  -R 777  /var/run/httpd  /var/log/httpd 
EXPOSE 8080
USER apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

