source common.sh
rm -rf ${logfile}

heading "installing remirepo"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${logfile}
status $?

heading "enabling remi-6.2"
yum module enable redis:remi-6.2 -y &>> ${logfile}
status $?

heading "installing redis"
yum install redis -y  &>> ${logfile}
status $?

heading "updating redis listening address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> ${logfile}
status $?

heading "enabling redis"
systemctl enable redis &>> ${logfile}
status $?

heading "starting redis"
systemctl start redis &>> ${logfile}
status $?