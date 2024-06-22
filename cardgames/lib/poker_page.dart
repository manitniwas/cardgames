import 'package:flutter/material.dart';

class PokerPage extends StatelessWidget {
  final List<String> playerNames;

  const PokerPage({super.key, required this.playerNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poker Game'),
      ),
      body: Center(
        child: Text('Poker game with players: ${playerNames.join(', ')}'),
      ),
    );
  }
}
