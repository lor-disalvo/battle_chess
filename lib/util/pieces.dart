import 'package:flutter/cupertino.dart';

import '../bloc/board_event.dart';
import 'constants.dart';
import 'dart:math';

class DiceRoller {
  Random rng = Random();

  int rollD(int n) => 1 + rng.nextInt(n);

  int get d6 => rollD(6);

  int get d10 => rollD(10);

  int rollXdY(int x, int y) {
    int res = 0;
    for (int i = 0; i < x; i++) {
      res += rollD(y);
    }
    return res;
  }
}

class Piece {
  final PieceType type;
  final PieceColor color;
  int? row;
  int? column;

  Piece(this.type, this.color);

  void setPosition(int row, int column) {
    this.row = row;
    this.column = column;
  }
}

class BattlePiece extends Piece {
  // Class Variables
  Piece get basePiece => Piece(type, color);
  DiceRoller roll = DiceRoller();
  bool secondAttack = false;
  final int maxHealth;
  final int maxSpeed;

  // Instance Variables
  List<BoardEvent> actionList = <BoardEvent>[];
  late int currentHealth;
  late int currentSpeed;

  BattlePiece.pawn(PieceColor color)
      : maxHealth = 5,
        maxSpeed = 1,
        super(PieceType.pawn, color) {
    resetHealth();
    resetMove();
  }

  BattlePiece.knight(PieceColor color)
      : maxHealth = 20,
        maxSpeed = 0,
        secondAttack = true,
        super(PieceType.knight, color) {
    resetHealth();
    resetMove();
  }

  BattlePiece.bishop(PieceColor color)
      : maxHealth = 10,
        maxSpeed = 5,
        super(PieceType.bishop, color) {
    resetHealth();
    resetMove();
  }

  BattlePiece.rook(PieceColor color)
      : maxHealth = 30,
        maxSpeed = 5,
        super(PieceType.rook, color) {
    resetHealth();
    resetMove();
  }

  BattlePiece.queen(PieceColor color)
      : maxHealth = 25,
        maxSpeed = 5,
        secondAttack = true,
        super(PieceType.queen, color) {
    resetHealth();
    resetMove();
  }

  BattlePiece.king(PieceColor color)
      : maxHealth = 50,
        maxSpeed = 1,
        super(PieceType.king, color) {
    resetHealth();
    resetMove();
  }

  Draggable get toDraggable => Draggable(
        axis: Axis.vertical,
        childWhenDragging: Container(),
        feedback: const Placeholder(),
        child: const Placeholder(),
      );

  // Combat Methods
  // TODO change this to a Board Event
  int get baseAtk {
    int dmg = roll.d6;
    if (secondAttack) {
      secondAttack = false;
      dmg += baseAtk;
      secondAttack = true;
    }
    if (dmg < 2) return 0;

    switch (type) {
      case PieceType.queen:
        dmg--;
      case PieceType.rook:
      case PieceType.knight:
        dmg += 3 + roll.d6;
        break;
      case PieceType.king:
        dmg++;
        break;
      case PieceType.pawn:
        dmg--;
      case PieceType.bishop:
    }
    return dmg;
  }

  void takeDamage(int dmg) {
    int hp = currentHealth - dmg;
    if (hp < 1) {
      throw ArgumentError();
    }
    currentHealth = hp;
  }

  void resetHealth() => currentHealth = maxHealth;

  // Movement Methods
  void move(int n) {
    int move = currentSpeed - n;
    if (move < 0) {
      throw ArgumentError();
    }
    currentSpeed = move;
  }

  void resetMove() => currentSpeed = maxSpeed;
}
