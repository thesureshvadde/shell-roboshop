source common.sh
rm -rf ${logfile}

heading "installing golang"
yum install golang -y &>> ${logfile}
status $?

heading "creating roboshop application user"
userstatus


heading "creating /app directory"
appstatus
status $?

heading "downloading dispatch app content"
curl -o /tmp/dispatch.zip https://roboshop-builds.s3.amazonaws.com/dispatch.zip &>> ${logfile}
status $?

cd /app 

heading "unzip dispatch.zip"
unzip /tmp/dispatch.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
go mod init dispatch &>> ${logfile}
if [ $? -eq 1 ] 
then 
    echo "already exist"
fi
go get  &>> ${logfile}
status $?
go build &>> ${logfile}
status $?

heading "coping dispatch service file "
cp ${codedir}/configs/dispatch.service /etc/systemd/system/dispatch.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling dispatch"
systemctl enable dispatch &>> ${logfile}
status $?

# heading "starting dispatch"
# systemctl start dispatch &>> ${logfile}
# status $?