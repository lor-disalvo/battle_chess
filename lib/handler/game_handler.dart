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

  factory GameHandler() {
    return _instance;
  }

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

  // Utility Methods
  void nextTurn() {
    turn = (turn == white) ? black : white;
  }

  // TODO implement initial board
  static initialBoard() => List<Piece?>.generate(64, (index) {
        PieceColor color = index > 16 ? white : black;
        if (initialPawnPos.contains(index)) return createPiece(color, pawn);
        if (initialRookPos.contains(index)) return createPiece(color, rook);
        if (initialKnightPos.contains(index)) return createPiece(color, knight);
        if (initialBishopPos.contains(index)) return createPiece(color, bishop);
        if (initialQueenPos.contains(index)) return createPiece(color, queen);
        if (initialKingPos.contains(index)) return createPiece(color, king);
        return null;
      });
}

class Move {
  final PieceColor color;
  final PieceType piece;
  final int to;
  final int from;
  final ActionType type; // TODO: use Report class to keep track of moves

  const Move(this.color, this.piece, this.from, this.to, this.type);
}
