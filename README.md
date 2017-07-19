# Chess

Chess is a classic version of the game chess, playable in the Ruby console.

To play clone the download the repository and run game.rb in the console.

## Features and Implementation

### Moving Pieces

The logic to move pieces is implemented using modules. Two modules handle the movement of the two different types of movement, one space at a time, or multiple spaces at a time. The Stepable module determines which spaces a piece can move to depending on whether that space is empty, is on the board, or has an opponents piece occupying it. The Slideable module utilizes the same logic, checks each space in each movable direction and add them to its moves array until that space isn't a valid move. Move directions depend on the piece class, Bishops can only move diagonally, Rooks up and down, while Queens can move in all directions.

### Placing a player in check

Placing a player in check involves checking all the positions a players pieces can move to and comparing against the opponents Kings' position. The player is now considered 'in check' and can only move a piece that will result in the King no longer being in check.

### Moving out of check

Examining whether a move takes your King out of check involves duplicating the current board. Once duplicated, each potential move is executed on the duplicated board, and after each move all the opponents new potential moves are checked against the Kings current position. If the King is taken out of check that move is added to a valid_moves array for that specific piece. Then, on the real board, only moves in the valid_moves array are allowed.

### Checkmate

Solving for a checkmate uses the same logic for checking whether a player is in check. If all the players pieces have no moves in the valid_moves array, then the game is over, checkmate.
