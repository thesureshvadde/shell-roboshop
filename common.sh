codedir=$(pwd)

logfile=/tmp/roboshop.log

heading(){
    echo -e "\e[31m $1 \e[0m"
}

status(){
    if [ $1 -eq 0 ]
    then
        echo "success"
    else
        echo "failure"
        exit 1
    if
}