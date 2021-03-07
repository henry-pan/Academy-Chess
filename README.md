# Academy Chess
### Authors: Henry Pan, Michael Dean

This is a terminal chess program written in Ruby, originally made at App Academy as a pair programming project ([seen here](https://github.com/henry-pan/AA-Classwork/tree/main/W4D3)). This repository contains independent progression on the project by Henry Pan.

## How to Play
In the terminal, run `ruby game.rb`.

Use the arrow keys to move the cursor, and press `enter` or `spacebar` to select a piece. After selecting a piece, use `enter` or `spacebar` to choose where to move the piece.

## Rules
This version only features basic rules and does not yet implement castling, en passant, or pawn promotion. Stalemates are not detected.

## Planned Features
- Pawn Promotion - A pawn that reaches the end of the board is promoted to a Queen.
- Replay System - Rewatch a completed game, where pieces will move on their own. After a game is completed, the log of all moves taken in the game are stored in a file.

## Stretch Goals
- Horde Mode - One team will only have 4 rows of pawns.
- Zombie Computer - A computer player that chooses moves randomly and captures pieces whenever possible.
