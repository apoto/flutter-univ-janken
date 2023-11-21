import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String myJankenText = '✌️';
  String computerJankenText = '?';

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerJankenText = hand.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '相手',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerJankenText,
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              Result.win.text,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              myJankenText,
              style: const TextStyle(fontSize: 200),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = Hand.rock.text;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: Text(
              Hand.rock.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = Hand.scissors.text;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: Text(
              Hand.scissors.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = Hand.paper.text;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: Text(
              Hand.paper.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}

enum Hand {
  rock,
  scissors,
  paper;

  String get text {
    switch (this) {
      case Hand.rock:
        return '👊';
      case Hand.scissors:
        return '✌️';
      case Hand.paper:
        return '✋';
    }
  }
}

enum Result {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'あいこ';
    }
  }
}
