#!/bin/bash

echo -e "Enter your username:"

while :; do
read USERNAME
  if [[ ${#USERNAME} -gt 22 ]]; then
    echo "Username must be 22 characters or less. try again:"
  else
    break
  fi
done

SECRETE_NUMBER=$((RANDOM %1000 + 1))
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

GET_USER_DETAILS=$($PSQL "select games_played, best_game from records where username='$USERNAME'")

if [[ ! -z $GET_USER_DETAILS ]]
then
    IFS="|" read GAMES_PLAYED BEST_GAME <<< "$GET_USER_DETAILS"
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  #welcome message
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    GAMES_PLAYED=0
    BEST_GAME=""
    INSERT_RECORD=$($PSQL "insert into records values('$USERNAME',$GAMES_PLAYED,'$BEST_GAME')")
    
fi


echo -e "Guess the secret number between 1 and 1000:"
guess_count=0

while :; do
  read GUESS
  guess_count=$((guess_count + 1))

  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"

  elif [[ $GUESS -gt $SECRETE_NUMBER ]]
  then
    echo "It's lower than that, guess again:"

  elif [[ $GUESS -lt $SECRETE_NUMBER ]]
  then
    echo "It's higher than that, guess again:"

  else
    echo "You guessed it in $guess_count tries. The secret number was $SECRETE_NUMBER. Nice job!"
    break
  fi
done

if [[ -z $BEST_GAME || $guess_count -lt $BEST_GAME ]]
then
  BEST_GAME=$guess_count
fi

GAMES_PLAYED=$((GAMES_PLAYED + 1))
 
 #insert into database
UPDATE_RECORD=$($PSQL "update records set games_played=$GAMES_PLAYED,best_game=$BEST_GAME where username='$USERNAME'")