import 'package:flutter/material.dart';
import 'poker_page.dart';
import 'blackjack_page.dart';
import 'bridge_page.dart';
import 'estimate_page.dart';

class PlayerInputPage extends StatefulWidget {
  final String game;
  const PlayerInputPage({super.key, required this.game});

  @override
  _PlayerInputPageState createState() => _PlayerInputPageState();
}

class _PlayerInputPageState extends State<PlayerInputPage> {
  final List<TextEditingController> _controllers = [];

  void _addPlayer() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removePlayer(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  void _startGame() {
    List<String> playerNames =
        _controllers.map((controller) => controller.text).toList();

    Widget nextPage;
    switch (widget.game) {
      case 'Poker':
        nextPage = PokerPage(playerNames: playerNames);
        break;
      case 'Blackjack':
        nextPage = BlackjackPage(playerNames: playerNames);
        break;
      case 'Bridge':
        nextPage = BridgePage(playerNames: playerNames);
        break;
      case 'Estimate':
        nextPage = EstimatePage(playerNames: playerNames);
        break;
      default:
        nextPage = Container();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Player Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () => _removePlayer(index),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPlayer,
              child: const Text('Add Player'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
