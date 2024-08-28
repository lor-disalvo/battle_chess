import 'constants.dart';

enum PieceType { pawn, rook, knight, bishop, queen, king }

enum PieceColor { white, black }

enum ActionType { attack, movement, support }

Map<PieceType, Set<int>> pieceStats = {
  PieceType.pawn: {5, 1},
  PieceType.knight: {20, 0},
  PieceType.bishop: {10, 5},
  PieceType.rook: {30, 5},
  PieceType.queen: {25, 5},
  PieceType.king: {50, 1}
};

final List<int> initialPawnPosition = List.generate(8, (index) => index + 8)
  ..addAll(List.generate(8, (index) => index + 48));

const Set<int> initialRookPosition = {0, 7, 56, 63};
const Set<int> initialKnightPosition = {1, 6, 57, 62};
const Set<int> initialBishopPosition = {2, 5, 58, 61};
const Set<int> initialQueenPosition = {3, 59};
const Set<int> initialKingPosition = {4, 60};

const String imagePath = "assets/images/";
