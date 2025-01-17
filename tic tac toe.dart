import 'dart:io';

void main() {
  while (true) {
    playGame();
    print("Game over! Do you want to play again? (y/n): ");
    String? restart = stdin.readLineSync();
    if (restart != null && restart.toLowerCase() != 'y') {
      break;
    }
  }
}

void playGame() {
  List<String> board = List.generate(9, (index) => (index + 1).toString());
  String currentPlayer = 'X';
  int moves = 0;

  while (true) {
    printBoard(board);
    print("Player $currentPlayer's turn. Enter a number 1-9 :");
    String? input = stdin.readLineSync();
    int? move = int.tryParse(input ?? '');

    if (move == null || move < 1 || move > 9 || board[move - 1] == 'X' || board[move - 1] == 'O') {
      print("Invalid input. Please enter a number 1-9 for an empty cell.");
      continue;
    }

    board[move - 1] = currentPlayer;
    moves++;

    if (checkWinner(board, currentPlayer)) {
      printBoard(board);
      print("Player $currentPlayer wins");
      break;
    }

    if (moves == 9) {
      printBoard(board);
      print("The game is a draw.");
      break;
    }
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}

void printBoard(List<String> board) {
  print('');
  for (int i = 0; i < 3; i++) {
    print("${board[i * 3]} | ${board[i * 3 + 1]} | ${board[i * 3 + 2]}");
    if (i < 2) print("--+---+--");
  }
  print('');
}

bool checkWinner(List<String> board, String player) {
  List<List<int>> winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], 
    [0, 3, 6], [1, 4, 7], [2, 5, 8], 
    [0, 4, 8], [2, 4, 6]             
  ];

  for (var combination in winningCombinations) {
    if (board[combination[0]] == player &&
        board[combination[1]] == player &&
        board[combination[2]] == player) {
      return true;
    }
  }
  return false;
}
