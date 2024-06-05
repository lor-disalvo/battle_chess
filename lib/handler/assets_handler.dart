import 'package:battle_chess/util/constants.dart';
import 'package:flutter/material.dart';

class AssetsHandler {
  static final AssetsHandler _instance = AssetsHandler._internal();

  get board => customDecoration("$imagePath""Board.png");

  factory AssetsHandler() {
    return _instance;
  }

  AssetsHandler._internal();

  BoxDecoration customDecoration(String url) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(url),
      ),
    );
  }

  BoxDecoration getPieceDecoration(PieceType type, PieceColor color) {
    String col = color == PieceColor.white ? "W" : "B";
    String piece;
    switch (type) {
      case PieceType.pawn:
        piece = "Pawn";
      case PieceType.rook:
        piece = "Rook";
      case PieceType.knight:
        piece = "Knight";
      case PieceType.bishop:
        piece = "Bishop";
      case PieceType.queen:
        piece = "Queen";
      case PieceType.king:
        piece = "King";
    }

    return customDecoration("$imagePath$col$piece.png");
  }
}
