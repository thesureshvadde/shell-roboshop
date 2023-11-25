source common.sh
rm -rf ${logfile}

heading "installing maven"
yum install maven -y &>> ${logfile}
status $?

heading "creating roboshop application user"
useradd roboshop &>> ${logfile}
status $?

heading "creating /app directory"
mkdir /app &>> ${logfile}
status $?

heading "downloading shipping app content"
curl -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> ${logfile}
status $?

cd /app 

heading "unzip shipping.zip"catalogue
unzip /tmp/shipping.zip &>> ${logfile}
status $?

cd /app

heading "installing dependinces"
mvn clean package &>> ${logfile}
status $?

mv target/shipping-1.0.jar shipping.jar &>> ${logfile}

heading "coping shipping service file "
cp ${codedir}/configs/shipping.service /etc/systemd/system/shipping.service &>> ${logfile}
status $?

heading "daemon reload"
systemctl daemon-reload &>> ${logfile}
status $?

heading "enabling shipping"
systemctl enable shipping &>> ${logfile}
status $?

heading "starting shipping"
systemctl start shipping &>> ${logfile}
status $?

heading "installing mysql"
yum install mysql -y  &>> ${logfile}
status $?

heading "loading schema"
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>> ${logfile}
status $?

heading "restarting shipping"
systemctl restart shipping &>> ${logfile}
status $?