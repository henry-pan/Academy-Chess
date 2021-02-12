# Academy Chess
### Authors: Henry Pan, Michael Dean

This is a terminal chess program written in Ruby, made at App Academy as a pair programming project ([seen here](https://github.com/henry-pan/AA-Classwork/tree/main/W4D3)).

## How to Play
In the terminal, run `ruby game.rb`.

Use the arrow keys to move the cursor, and press `enter` or `spacebar` to select a piece. After selecting a piece, use `enter` or `spacebar` to choose where to move the piece.

## Rules
This version only features basic rules and does not yet implement castling, en passant, or pawn promotion.

## Planned Features
- Error Handling - Invalid inputs will not end the game.
- Improved Selection - Allow for deselecting a piece, and also selecting a piece will display its valid moves.
- Pawn Promotion - A pawn that reaches the end of the board is promoted to a Queen.
- Horde Mode - One team will only have 4 rows of pawns.
- Zombie Computer - A computer player that chooses moves randomly and captures pieces whenever possible.
- Replay System - Rewatch a completed game, pieces will move on their own. After a game is completed, the log of all moves taken in the game are stored in a file.
- New Game Mode - A new game mode with some new pieces and random events.
- Bandit Piece - A teamless piece that moves around the field randomly like the King. If it finds a non-Pawn piece, it will demote that piece to a Pawn and disappear.
- Promotion Piece - A teamless piece that is stationary once spawned onto the board. Any piece that captures it is promoted.
- Amazon Piece - A promoted piece that can move like a Queen and a Knight.
- Martyr Piece - A promoted piece that can move to any spot on the board, but cannot capture other Pieces. Pieces that capture this piece are demoted to Pawn. (A player using a King to capture this piece will lose the game.)
