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
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME')")
else
  # fetch user stats and store in variables
  echo $"$USERNAME_RESULT" | while IFS='|' read GAMES_PLAYED BEST_GAME
  do
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

# initialize secret number
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# initialize number of guesses at 0
NUMBER_OF_GUESSES=0

echo -e "\nGuess the secret number between 1 and 1000:"

NUMBER_GUESSER() {
  read GUESS
  NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))

  # if input is not an integer
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "\nThat is not an integer, guess again:"
    NUMBER_GUESSER

  # if input matches the secret number
  elif [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    #update games_played and best_game(if better than previous) in database

  # if input is greater than the secret number
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo -e "\nIt's lower than that, guess again:"
    NUMBER_GUESSER

  # if input is lower than the secret number
  else
    echo -e "\nIt's higher than that, guess again:"
    NUMBER_GUESSER
  fi
}


NUMBER_GUESSER
