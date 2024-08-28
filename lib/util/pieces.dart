import 'package:battle_chess/handler/assets_handler.dart';
import 'package:battle_chess/util/exceptions.dart';
import 'package:flutter/material.dart';

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
  int position;

  Piece(this.type, this.color, this.position);

  get icon => Container(decoration: _image);

  Draggable? toDraggable(context) {
    return null;
  }
}

class BattlePiece extends Piece {
  // Class Variables
  Piece get basePiece => Piece(type, color, position);
  DiceRoller roll = DiceRoller();
  bool secondAttack = false;
  final int maxHealth;
  final int maxSpeed;

  // Instance Variables
  late int currentHealth;
  late int currentSpeed;

  BattlePiece(super.type, super.color, super.position)
      : maxHealth = pieceStats[type]!.first,
        maxSpeed = pieceStats[type]!.last {
    secondAttack = (type == PieceType.knight) || (type == PieceType.queen);
    _image = AssetsHandler().getPieceDecoration(type, color);
    resetHealth();
    resetMove();
  }

  @override
  Draggable toDraggable(context) => Draggable(
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
