source common.sh
rm -rf ${logfile}

heading "downloading nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${logfile}
status $?

heading "installing nodejs"
yum install nodejs -y &>> ${logfile}
status $?

heading "creating roboshop application user"
useradd roboshop &>> ${logfile}
status $?

heading "creating /app directory"
mkdir /app &>> ${logfile}
status $?

heading "downloading user app content"
curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> ${logfile}
status $?

cd /app 

heading "unzip user.zip"
unzip /tmp/user.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
npm install  &>> ${logfile}
status $?

heading "coping user service file "
cp ${codedir}/configs/user.service /etc/systemd/system/user.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling user"
systemctl enable user &>> ${logfile}
status $?

heading "starting user"
systemctl start user &>> ${logfile}
status $?

heading "coping mongo.repo"
cp ${codedir}/configs/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${logfile}
status $?

heading "installing mongo client"
yum install mongodb-org-shell -y &>> ${logfile}
status $?

heading "loading schema"
mongo --host mongodb.sureshdevops.online </app/schema/user.js &>> ${logfile}
status $?