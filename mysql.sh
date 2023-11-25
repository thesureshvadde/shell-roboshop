source common.sh
rm -rf ${logfile}

heading "disabling mysql default version"
yum module disable mysql -y  &>> ${logfile}
status $?

heading "coping mysql repo file"
cp ${codedir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>> ${logfile}
status $?

heading "installing mysql"
yum install mysql-community-server -y &>> ${logfile}
status $?

heading "enabling mysqld"
systemctl enable mysqld &>> ${logfile}
status $?

heading "starting mysqld" 
systemctl start mysqld &>> ${logfile}
status $?

heading "reset mysql default password"
mysql_secure_installation --set-root-pass RoboShop@1 &>> ${logfile}
status $?

# heading "connecting to mysql"
# mysql -uroot -pRoboShop@1 &>> ${logfile}
# status $?