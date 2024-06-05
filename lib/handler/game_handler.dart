import 'package:battle_chess/util/constants.dart';
import 'package:battle_chess/util/pieces.dart';

// this is the chess.dart counterpart
class GameHandler {
  static final GameHandler _instance = GameHandler._internal();

  // Constants/Class Variables
  static const PieceColor black = PieceColor.black;
  static const PieceColor white = PieceColor.white;

  static const PieceType pawn = PieceType.pawn;
  static const PieceType knight = PieceType.knight;
  static const PieceType bishop = PieceType.bishop;
  static const PieceType rook = PieceType.rook;
  static const PieceType queen = PieceType.queen;
  static const PieceType king = PieceType.king;

  static const int empty = -1;

  static const int up = -8;
  static const int down = 8;

  // Instance Variables
  PieceColor turn = white;
  List<Piece?> board = initialBoard();

  factory GameHandler() => _instance;

  GameHandler._internal();

  // Initialising
  static BattlePiece createPiece(PieceColor color, PieceType type) {
    switch (type) {
      case pawn:
        return BattlePiece.pawn(color);
      case knight:
        return BattlePiece.knight(color);
      case bishop:
        return BattlePiece.bishop(color);
      case rook:
        return BattlePiece.rook(color);
      case queen:
        return BattlePiece.queen(color);
      case king:
        return BattlePiece.king(color);
    }
  }

  static initialBoard() => List<Piece?>.generate(64, (index) {
        PieceColor color = index > 16 ? white : black;
        PieceType? type;

        if (initialPawnPosition.contains(index)) type = pawn;
        if (initialRookPosition.contains(index)) type = rook;
        if (initialKnightPosition.contains(index)) type = knight;
        if (initialBishopPosition.contains(index)) type = bishop;
        if (initialQueenPosition.contains(index)) type = queen;
        if (initialKingPosition.contains(index)) type = king;

        return type == null ? null : createPiece(color, type);
      });

  // Utility Methods
  void nextTurn() {
    turn = (turn == white) ? black : white;
  }
}

class Move {
  final PieceColor color;
  final PieceType piece;
  final int to;
  final int from;
  final ActionType type; // TODO: use Report class to keep track of moves

  const Move(this.color, this.piece, this.from, this.to, this.type);
}
