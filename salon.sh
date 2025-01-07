#! /bin/bash
echo "~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?"

SERVICES=$(psql --username=freecodecamp --dbname=salon -t -c "SELECT service_id, name FROM services;")
while true; do
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  read SERVICE_ID_SELECTED
  SERVICE_NAME=$(psql --username=freecodecamp --dbname=salon -t -c "SELECT name FROM services where service_id=$SERVICE_ID_SELECTED;")
  if [[ -z $SERVICE_NAME ]]; then
    echo -e "I could not find that service. What would you like today?"
  else
    break
  fi
done
echo -e "\nYou have selected$SERVICE_NAME service."
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_NAME=$(psql --username=freecodecamp --dbname=salon -t -c "SELECT name FROM customers where phone='$CUSTOMER_PHONE';")
if [[ -z $CUSTOMER_NAME ]]; then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  psql --username=freecodecamp --dbname=salon -t -c "INSERT INTO customers(name,phone) values ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');"
fi

echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
read SERVICE_TIME
CUSTOMER_ID=$(psql --username=freecodecamp --dbname=salon -t -c "SELECT customer_id FROM customers where phone='$CUSTOMER_PHONE';")
psql --username=freecodecamp --dbname=salon -t -c "INSERT INTO appointments(time,service_id,customer_id) values ('$SERVICE_TIME', $SERVICE_ID_SELECTED, $CUSTOMER_ID);"
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
exit