import 'package:battle_chess/handler/game_handler.dart';
import 'package:equatable/equatable.dart';

import '../util/pieces.dart';

class BoardState extends Equatable {
  late final List<Piece?> board;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PlaceholderState extends BoardState {}

class InitialState extends BoardState {
  @override
  final List<Piece?> board;

  InitialState() : board = GameHandler.initialBoard();
}
