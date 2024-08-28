import 'package:equatable/equatable.dart';

abstract class BoardEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PieceMovedEvent extends BoardEvent {}

// class Action {
//   final ActionType type;
//   final Piece origin;
//
//   Action.attack(this.origin) : type = ActionType.attack;
//
//   Report execute() {
//     return Report(type: type, origin: origin);
//   }
// }
//
// class Report {
//   ActionType type;
//   Piece origin;
//   Piece? target;
//
//   Report({required this.type, required this.origin, this.target});
// }
