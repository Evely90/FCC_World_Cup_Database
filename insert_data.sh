#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# Insert data from games.csv into the database
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Insert winning countries in table 'teams'
  if [[ $WINNER != "winner" ]] #exclude column names
    then
      # get country name of winner countries
      WINNER_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
      # if country not found in table
      if [[ -z $WINNER_NAME ]]
        then
          # insert country in table
          INSERT_WINNER_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            if [[ $INSERT_WINNER_NAME == "INSERT 0 1" ]]
            then
              echo Inserted into teams, $WINNER
            fi
      fi
  fi
  
  # Insert opponent countries in table 'teams'
  if [[ $OPPONENT != "opponent" ]]; #exclude column names
    then
      # get country name of opponent countries
      OPPONENT_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
      # if country not found in table
      if [[ -z $OPPONENT_NAME ]]
        then
          # insert country in table
          INSERT_OPPONENT_NAME=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
          if [[ $INSERT_OPPONENT_NAME == "INSERT 0 1" ]]
            then
              echo "Inserted into teams, $OPPONENT"
          fi
      fi
  fi


# Insert data in 'games' table
if [[ $YEAR != "year" ]] #exclude column names
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # get opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      # insert game
      INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_GAME == "INSERT 0 1" ]]
        then
          echo Inserted into game $YEAR $ROUND $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS
      fi
fi


done