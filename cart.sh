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

heading "downloading cart app content"
curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> ${logfile}
status $?

cd /app 

heading "unzip cart.zip"
unzip /tmp/cart.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
npm install  &>> ${logfile}
status $?

heading "coping cart service file "
cp ${codedir}/configs/cart.service /etc/systemd/system/cart.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling cart"
systemctl enable cart &>> ${logfile}
status $?

heading "starting cart"
systemctl start cart &>> ${logfile}
status $?