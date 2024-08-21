#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

# check if user is in database
USERNAME_RESULT=$($PSQL "SELECT games_played, best_game FROM users WHERE username = '$USERNAME'")

# if user doesn't exist
if [[ -z $USERNAME_RESULT ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."

  # insert new user
else
  # fetch user stats and store in variables
  echo $"$USERNAME_RESULT" | while IFS='|' read GAMES_PLAYED BEST_GAME
  do
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi
