#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then 
  echo -e "Please provide an element as an argument."

elif [[ $1 =~ ^[0-9]+$ ]]
then
    GET_ELEMENT=$($PSQL "select p.atomic_number,t.type,atomic_mass,melting_point_celsius,boiling_point_celsius,symbol,name from properties p join elements e on p.atomic_number=e.atomic_number join types t on p.type_id=t.type_id where e.atomic_number=$1")
    
    if [[ -z $GET_ELEMENT ]]
    then
    echo "I could not find that element in the database."
    else
      echo "$GET_ELEMENT" | while IFS="|" read ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_P BOILING_P SYMBOL NAME 
      do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
      done
    fi
else
  GET_ELEMENT=$($PSQL "select p.atomic_number,t.type,atomic_mass,melting_point_celsius,boiling_point_celsius,symbol,name from properties p join elements e on p.atomic_number=e.atomic_number join types t on p.type_id=t.type_id where e.symbol='$1' or e.name='$1'")
  
  if [[ -z $GET_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_P BOILING_P SYMBOL NAME <<< "$GET_ELEMENT"
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
  fi

fi
