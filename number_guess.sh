#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

# check if user is in database
USERNAME_RESULT=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username = '$USERNAME'")

# if user doesn't exist
if [[ -z $USERNAME_RESULT ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."

  #insert new user
else
  echo -e "\n Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi


