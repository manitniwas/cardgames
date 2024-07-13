import 'package:flutter/material.dart';
// import 'utilities.dart';

class EstimatePage extends StatefulWidget {
  final List<String> playerNames;

  const EstimatePage({super.key, required this.playerNames});

  @override
  _EstimatePageState createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  late int rounds;
  late bool isVisible;
  late List<List<TextEditingController>> scores;
  int currentRound = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    rounds = (52 / widget.playerNames.length).floor();
    scores = List.generate(widget.playerNames.length,
        (i) => List.generate(rounds, (j) => TextEditingController()));
  }

  void _nextRound() {
    if (currentRound < rounds - 1) {
      setState(() {
        currentRound++;
        _focusNode.unfocus();
      });
    }
  }

  void _previousRound() {
    if (currentRound > 0) {
      setState(() {
        currentRound--;
        _focusNode.unfocus();
      });
    }
  }

  List<int> _calculateScores() {
    return scores.map((playerScores) {
      return playerScores.fold<int>(
          0,
          (previousValue, controller) =>
              previousValue + (int.tryParse(controller.text) ?? 0));
    }).toList();
  }

  @override
  void dispose() {
    for (var playerScores in scores) {
      for (var controller in playerScores) {
        controller.dispose();
      }
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalScores = _calculateScores();
    isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimate Game'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Table(
                    defaultColumnWidth: const FixedColumnWidth(100.0),
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          const TableCell(
                            child: Center(child: Text('Player')),
                          ),
                          for (int i = 0; i < rounds; i++)
                            TableCell(
                              child: Center(
                                child: Text(
                                  'Round ${i + 1}',
                                  style: TextStyle(
                                      fontWeight: i == currentRound
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            ),
                          const TableCell(
                            child: Center(child: Text('Total Score')),
                          ),
                        ],
                      ),
                      for (int i = 0; i < widget.playerNames.length; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text(widget.playerNames[i])),
                            ),
                            for (int j = 0; j < rounds; j++)
                              TableCell(
                                child: Center(
                                  child: TextField(
                                    controller: scores[i][j],
                                    enabled: j == currentRound,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (value) {
                                      _focusNode
                                          .unfocus(); // Dismiss the keyboard when the "Done" button is pressed
                                    },
                                    decoration: InputDecoration(
                                      border: j == currentRound
                                          ? OutlineInputBorder()
                                          : InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            TableCell(
                              child: Center(
                                  child: Text(totalScores[i].toString())),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 100), // Extra space for buttons
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousRound,
                  child: const Text('Previous Round'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextRound,
                  child: const Text('Next Round'),
                ),
              ],
            ),
          ),
          if (isVisible)
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Done',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      ),
                    )))
        ],
      ),
    );
  }
}
