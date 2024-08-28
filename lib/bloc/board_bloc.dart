import 'package:battle_chess/bloc/board_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This is the chess_board.dart counterpart
// class BoardBloc extends Bloc<BoardEvent, BoardState> {
//   BoardBloc() : super(InitialState());
//
//   @override
//   Stream<BoardState> mapEventToState(BoardEvent event) async* {
//     if (event is PieceMovedEvent) {
//       yield InGameState(state is InGameState ? (state as InGameState).count + 1 : 1);
//     }
//   }
// }

class BoardCubit extends Cubit<BoardState>{
  BoardCubit(super.initialState);


}
