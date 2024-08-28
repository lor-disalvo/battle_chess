import 'package:battle_chess/bloc/board_bloc.dart';
import 'package:battle_chess/ui/board_interface.dart';
import 'package:battle_chess/ui/user_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BattleChess());
}

class BattleChess extends StatelessWidget {
  const BattleChess({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Battle Chess',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true),
      home: BlocProvider(
        create: (context) => BoardBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title = 'Battle Chess';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            BoardInterface(),
            UserInterface(),
          ],
        ),
      ),
    );
  }
}
