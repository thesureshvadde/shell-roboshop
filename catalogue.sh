source common.sh
rm -rf ${logfile}

heading "downloading nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${logfile}
status $?

heading "installing nodejs"
yum install nodejs -y &>> ${logfile}
status $?

heading "creating roboshop application user"
userstatus
status $?

heading "creating /app directory"
appstatus
status $?

heading "downloading catalogue app content"
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> ${logfile}
status $?

cd /app 

heading "unzip catalogue.zip"
unzip /tmp/catalogue.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
npm install  &>> ${logfile}
status $?

heading "coping catalogue service file "
cp ${codedir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling catalogue"
systemctl enable catalogue &>> ${logfile}
status $?

heading "starting catalogue"
systemctl start catalogue &>> ${logfile}
status $?

heading "coping mongo.repo"
cp ${codedir}/configs/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${logfile}
status $?

heading "installing mongo client"
yum install mongodb-org-shell -y &>> ${logfile}
status $?

heading "loading schema"
mongo --host mongodb.sureshdevops.online </app/schema/catalogue.js &>> ${logfile}
status $?