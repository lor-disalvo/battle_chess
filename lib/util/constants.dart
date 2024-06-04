enum PieceType { pawn, rook, knight, bishop, queen, king }

enum PieceColor { white, black }

enum ActionType { attack, movement, support }

const Set<int> initialPawnPos = {
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56
};
const Set<int> initialRookPos = {0, 7, 56, 63};
const Set<int> initialKnightPos = {1, 6, 57, 62};
const Set<int> initialBishopPos = {2, 5, 58, 61};
const Set<int> initialQueenPos = {3, 59};
const Set<int> initialKingPos = {4, 60};


const String imagePath = "assets/images/";