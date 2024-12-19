#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

function MAIN_MENU(){
    echo -e "\nHere is a list of services we offer:"
    SERVICE_LIST=$($PSQL "select * from services")
    echo "$SERVICE_LIST" | while read SERVICE_ID BASH NAME
    do 
      echo "$SERVICE_ID) $NAME"
    done
    echo -e "\nPlease enter service_id" 
    read SERVICE_ID_SELECTED

}

MAIN_MENU

if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then
  MAIN_MENU
fi

echo -e "\nPlease enter phone number"
read CUSTOMER_PHONE 

#if customer not exist
CUSTOMER_EXIST=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_EXIST ]]
then
  echo -e "\nPlease enter name"
  read CUSTOMER_NAME
fi

#if phone not exist
PHONE_EXIST=$($PSQL "select phone from customers where phone='$CUSTOMER_PHONE'")
if [[ -z $PHONE_EXIST ]]
then
  INSERT_CUSTOMER_DETAILS=$($PSQL "insert into customers(phone,name) values('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  echo $INSERT_CUSTOMER_DETAILS
fi

echo -e "\nPlease enter time"
read SERVICE_TIME

#create appointment
CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")
# echo $INSERT_APPOINTMENT

CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
SERVICE_NAME=$($PSQL "select name from services where service_id='$SERVICE_ID_SELECTED'")

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."
