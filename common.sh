codedir=$(pwd)

logfile=/tmp/roboshop.log

heading(){
    echo -e "\e[33m $1 \e[0m"
}

userstatus(){
    id roboshop &>> ${logfile}
    if [ $? -eq 9 ]
    then
        echo -e "\e[32m user already exist \e[0m"
    else
        useradd roboshop &>> ${logfile}   
    fi
}

appstatus(){
    cd /app &>> ${logfile}
    if [ $? -eq 0 ]
    then
        echo -e "\e[32m /app already exist \e[0m" 
    else
        mkdir /app &>> ${logfile}
    fi
}

status(){
    if [ $1 -eq 0 ]
    then
        echo -e "\e[32m success \e[0m"
    else
        echo "\e[31m failure \e[0m"
        exit 1
    fi
}