source common.sh
rm -rf ${logfile}

heading "coping mongo.repo file"
cp ${codedir}/configs/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${logfile}
status $?

heading "installing mongodb"
yum install mongodb-org -y &>> ${logfile}
status $?

heading "enabling mongodb"
systemctl enable mongod &>> ${logfile}
status $?

heading "starting mongodb"
systemctl start mongod &>> ${logfile}
status $?

heading "editing mongodb listening address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> ${logfile}
status $?

heading "restarting mongodb"
systemctl restart mongod &>> ${logfile}
status $?