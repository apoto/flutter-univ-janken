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
  Hand? myHand;
  Hand? computerHand;
  Result? result;

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerHand = hand;
    });
    decideResult();
  }

  void decideResult() {
    if (myHand == null || computerHand == null) {
      return;
    }

    final Result result;

    if (myHand == computerHand) {
      result = Result.draw;
    } else if (myHand == Hand.rock && computerHand == Hand.scissors) {
      result = Result.win;
    } else if (myHand == Hand.scissors && computerHand == Hand.paper) {
      result = Result.win;
    } else if (myHand == Hand.paper && computerHand == Hand.rock) {
      result = Result.win;
    } else {
      result = Result.lose;
    }

    setState(() {
      this.result = result;
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
              computerHand?.text ?? '?',
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              result?.text ?? '?',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              myHand?.text ?? '?',
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
                myHand = Hand.rock;
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
                myHand = Hand.scissors;
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
                myHand = Hand.paper;
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
