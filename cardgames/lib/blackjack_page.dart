import 'package:flutter/material.dart';

class BlackjackPage extends StatelessWidget {
  final List<String> playerNames;

  const BlackjackPage({super.key, required this.playerNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blackjack Game'),
      ),
      body: Center(
        child: Text('Blackjack game with players: ${playerNames.join(', ')}'),
      ),
    );
  }
}
