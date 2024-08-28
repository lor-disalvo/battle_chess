import 'package:battle_chess/handler/game_handler.dart';
import 'package:equatable/equatable.dart';

import '../util/pieces.dart';

abstract class BoardState {
  late final List<Piece?> board;
}

class InitialState extends BoardState {
  @override
  final List<Piece?> board;

  InitialState() : board = GameHandler.initialBoard();
}

class InGameState extends BoardState {
  @override
  final List<Piece?> board;

  InGameState(this.board);
}
