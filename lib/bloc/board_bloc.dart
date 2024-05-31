import 'package:battle_chess/bloc/board_event.dart';
import 'package:battle_chess/bloc/board_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the chess_board.dart counterpart
class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(PlaceholderState());
}
