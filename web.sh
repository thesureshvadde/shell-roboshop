source common.sh
rm -rf ${logfile}

heading "installing nginx"
yum install nginx -y &>> ${logfile}
status $?

heading "enabling nginx"
systemctl enable nginx &>> ${logfile}
status $?

heading "starting nginx"
systemctl start nginx &>> ${logfile}
status $?

heading "removing default content"
rm -rf /usr/share/nginx/html/* &>> ${logfile}
status $?

heading "downloading web content"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> ${logfile}
status $?

cd /usr/share/nginx/html &>> ${logfile}

heading "unzip web content"
unzip /tmp/web.zip &>> ${logfile}
status $?

heading "coping roboshop.conf"
cp ${codedir}/configs/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>> ${logfile}
status $?

heading "restarting nginx"
systemctl restart nginx  &>> ${logfile}
status $?