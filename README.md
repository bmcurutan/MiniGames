Mini Games

The classic "Memory" game

## Instructions

- This template sets up a basic game board
- Your task is to finish the impelementation for a few core features
- You can work either in the `UIKit` or `SwiftUI` versions (by choosing the corresponding Scheme/Target)

## Tasks

1. Make the game start with all cards "face down", showing the default logo image instead
    - there is an image named "default" in the asset catolog for you to use
2. When a card is tapped, show it face up
3. When the 2nd card is flipped face-up, compare it to the other face-up card:
    - If the cards match (i.e. show the same funko, and have the same `tag` value) --> increment the score (and show it in the label), and leave the cards face-up and continue the game
    - If the cards don't match --> turn them both back face-down and continue the game
4. When all funkos are face up - display "Game Over!" caption in the score label
5. After the game is completed, show a button to play again
    - Shuffle the cards and start a new game
