#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #add unique team into teams table
  if [[ $WINNER != winner && $OPPONENT != opponent ]]
  then 
      #check if winning team exist in teams table
      WIN_TEAM_ID=$($PSQL"select team_id from teams where name='$WINNER'")
      
      #if not insert winning team 
      if [[ -z $WIN_TEAM_ID ]]
      then 
          INSERT_WIN_TEAM=$($PSQL"insert into teams(name) values('$WINNER')")
          if [[ $INSERT_WIN_TEAM == "INSERT 0 1" ]]
            then echo "Inserted into teams table : $WINNER"
          else
              echo "Failed to insert $WINNER into teams table"
          fi
      fi

      #check if opponent team exist in teams table
      OPP_TEAM_ID=$($PSQL"select team_id from teams where name='$OPPONENT'")
      
      #if not insert opponent team 
      if [[ -z $OPP_TEAM_ID ]]
      then 
          INSERT_OPP_TEAM=$($PSQL"insert into teams(name) values('$OPPONENT')")
          if [[ $INSERT_OPP_TEAM == "INSERT 0 1" ]]
            then echo "Inserted into teams table : $OPPONENT"
          else
              echo "Failed to insert $OPPONENT into teams table"
          fi
      fi

      WIN_TEAM_ID=$($PSQL"select team_id from teams where name='$WINNER'")
      OPP_TEAM_ID=$($PSQL"select team_id from teams where name='$OPPONENT'")

    #Check if games exists in game table
    GAME_ID=$($PSQL"select game_id from games where year=$YEAR and round='$ROUND' and winner_id=$WIN_TEAM_ID and opponent_id=$OPP_TEAM_ID")

    #if game does not exist insert into games table
    if [[ -z $GAME_ID ]]
    then
        INSERT_GAME=$($PSQL"insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR,'$ROUND',$WIN_TEAM_ID,$OPP_TEAM_ID,$WINNER_GOALS,$OPPONENT_GOALS)")

        #Confirm Insert
        if [[ $INSERT_GAME == "INSERT 0 1" ]]
            then echo "Inserted into games table: $YEAR, $ROUND, $WIN_TEAM_ID, $OPP_TEAM_ID, $WINNER_GOALS, $OPPONENT_GOALS"
          else
              echo "Failed to insert into games table: $YEAR, $ROUND, $WIN_TEAM_ID, $OPP_TEAM_ID, $WINNER_GOALS, $OPPONENT_GOALS"
        fi
    fi


  fi

done