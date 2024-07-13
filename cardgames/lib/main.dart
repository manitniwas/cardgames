import 'package:flutter/material.dart';
import 'player_input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Games',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.red,
          primaryContainer: Colors.red[700]!,
          secondary: Colors.black,
          secondaryContainer: Colors.black54,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Card Games'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a game to play:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: null, // Disable the Poker button
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
                onPrimary: Colors.white,
              ),
              child: const Text('Poker (Coming Soon)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: null, // Disable the Blackjack button
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
                onPrimary: Colors.white,
              ),
              child: const Text('Blackjack (Coming Soon)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: null, // Disable the Bridge button
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
                onPrimary: Colors.white,
              ),
              child: const Text('Bridge (Coming Soon)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PlayerInputPage(game: 'Estimate'),
                  ),
                );
              },
              child: const Text('Estimate'),
            ),
          ],
        ),
      ),
    );
  }
}
