codedir=$(pwd)

logfile=/tmp/roboshop.log

heading(){
    echo -e "\e[33m $1 \e[0m"
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