source common.sh
rm -rf ${logfile}

heading "downloading erlang repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> ${logfile}
status $?

heading "downloading rabbitmq repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> ${logfile}
status $?

heading "installing rabbitmq"
yum install rabbitmq-server -y  &>> ${logfile}
status $?

heading "enabling rabbitmq-server"
systemctl enable rabbitmq-server  &>> ${logfile}
status $?

heading "starting rabbitmq-server"
systemctl start rabbitmq-server  &>> ${logfile}
status $?

heading "adding rabbitmq user"
rabbitmqctl add_user roboshop roboshop123 &>> ${logfile}
status $?

heading "setting permissions for the above created user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> ${logfile}
status $?