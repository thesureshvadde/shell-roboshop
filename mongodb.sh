codedir=(pwd)
cp codedir/configs/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod
sed -e -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl restart mongod