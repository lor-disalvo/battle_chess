import 'package:battle_chess/bloc/board_bloc.dart';
import 'package:battle_chess/bloc/board_state.dart';
import 'package:battle_chess/handler/assets_handler.dart';
import 'package:battle_chess/util/pieces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardInterface extends StatelessWidget {
  const BoardInterface({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: AssetsHandler().board,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BoardBloc, BoardState>(
              bloc: context.read<BoardBloc>(),
              builder: (context, BoardState state) {
                return ChessBoardUI(context, state);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChessBoardUI extends StatelessWidget {
  late final List<Container> board;
  late final double pieceSize;

  ChessBoardUI(BuildContext context, BoardState state, {super.key}) {
    pieceSize = MediaQuery.of(context).size.width * 0.1111;
    List<Piece?> gameState = state.board;

    board = List.generate(64, (index) {
      return Container(
        color: getSquareColor(index),
        child: gameState[index] == null
            ? Container()
            : gameState[index]!.toDraggable,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8889,
      height: MediaQuery.of(context).size.width * 0.8889,
      child: DragTarget(
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return GridView.count(
            crossAxisCount: 8,
            children: board,
          );
        },
        onAcceptWithDetails: (data) {},
      ),
    );
  }

  MaterialColor getSquareColor(int index) {
    bool evenRow = ((index + 1) / 8).ceil() % 2 == 0;
    if (index % 2 == (evenRow ? 0 : 1)) {
      return Colors.brown;
    } else {
      return Colors.yellow;
    }
  }
}
