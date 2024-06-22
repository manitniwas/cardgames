import 'package:flutter/material.dart';

class BridgePage extends StatelessWidget {
  final List<String> playerNames;

  const BridgePage({super.key, required this.playerNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Game'),
      ),
      body: Center(
        child: Text('Bridge game with players: ${playerNames.join(', ')}'),
      ),
    );
  }
}
