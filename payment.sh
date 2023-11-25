source common.sh
rm -rf ${logfile}

heading "installing python3"
yum install python36 gcc python3-devel -y &>> ${logfile}
status $?

heading "creating roboshop application user"
userstatus
status $?

heading "creating /app directory"
appstatus
status $?

heading "downloading payment app content"
curl -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> ${logfile}
status $?

cd /app 

heading "unzip payment.zip"catalogue
unzip /tmp/payment.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
pip3.6 install -r requirements.txt &>> ${logfile}
status $?

heading "coping payment service file "
cp ${codedir}/configs/payment.service /etc/systemd/system/payment.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling payment"
systemctl enable payment &>> ${logfile}
status $?

heading "starting payment"
systemctl start payment &>> ${logfile}
status $?