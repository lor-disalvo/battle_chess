import 'package:battle_chess/handler/assets_handler.dart';
import 'package:battle_chess/util/exceptions.dart';
import 'package:flutter/material.dart';

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
  late BoxDecoration _image;

  Piece(this.type, this.color);

  get icon => Container(decoration: _image);

  get toDraggable => null;
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
    _init();
  }

  BattlePiece.knight(PieceColor color)
      : maxHealth = 20,
        maxSpeed = 0,
        secondAttack = true,
        super(PieceType.knight, color) {
    _init();
  }

  BattlePiece.bishop(PieceColor color)
      : maxHealth = 10,
        maxSpeed = 5,
        super(PieceType.bishop, color) {
    _init();
  }

  BattlePiece.rook(PieceColor color)
      : maxHealth = 30,
        maxSpeed = 5,
        super(PieceType.rook, color) {
    _init();
  }

  BattlePiece.queen(PieceColor color)
      : maxHealth = 25,
        maxSpeed = 5,
        secondAttack = true,
        super(PieceType.queen, color) {
    _init();
  }

  BattlePiece.king(PieceColor color)
      : maxHealth = 50,
        maxSpeed = 1,
        super(PieceType.king, color) {
    _init();
  }

  void _init() {
    _image = AssetsHandler().getPieceDecoration(type, color);
    resetHealth();
    resetMove();
  }

  @override
  get toDraggable => Draggable(
        childWhenDragging: Container(),
        feedback: icon,
        child: icon,
        data: [type, color],
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
      throw NoHealthException();
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
