import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_univ_janken/main.dart';

class LookThatWay extends StatefulWidget {
  const LookThatWay({
    super.key,
    required this.resultJanken,
  });
  final ResultJanken resultJanken;

  @override
  State<LookThatWay> createState() => _LookThatWayState();
}

class _LookThatWayState extends State<LookThatWay> {
  Direction? myDirection;
  Direction? computerDirection;
  ResultLTW? resultLTW;
  ResultOverall? resultOverall;

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final direction = Direction.values[randomNumber];
    setState(() {
      computerDirection = direction;
    });
    decideResultLTW();
    decideResultOverall();

    if (resultOverall == ResultOverall.draw) {
      Timer(const Duration(milliseconds: 1500), () {
        Navigator.pop(context);
      });
    }
  }

  void decideResultLTW() {
    final ResultLTW resultLTW;
    if (myDirection == computerDirection) {
      resultLTW = ResultLTW.match;
    } else {
      resultLTW = ResultLTW.different;
    }
    setState(() {
      this.resultLTW = resultLTW;
    });
  }

  void decideResultOverall() {
    final ResultOverall resultOverall;
    if (widget.resultJanken == ResultJanken.win) {
      if (resultLTW == ResultLTW.match) {
        resultOverall = ResultOverall.win;
      } else {
        resultOverall = ResultOverall.draw;
      }
    } else if (widget.resultJanken == ResultJanken.lose) {
      if (resultLTW == ResultLTW.match) {
        resultOverall = ResultOverall.lose;
      } else {
        resultOverall = ResultOverall.draw;
      }
    } else {
      resultOverall = ResultOverall.draw;
    }

    setState(() {
      this.resultOverall = resultOverall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('あっち向いてホイ！！'),
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
              computerDirection?.text ?? '?',
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              resultOverall?.text ?? '?',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              myDirection?.text ?? '?',
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
                myDirection = Direction.up;
              });
              chooseComputerText();
            },
            heroTag: 'up',
            tooltip: 'up',
            child: Text(
              Direction.up.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myDirection = Direction.down;
              });
              chooseComputerText();
            },
            heroTag: 'down',
            tooltip: 'down',
            child: Text(
              Direction.down.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myDirection = Direction.right;
              });
              chooseComputerText();
            },
            heroTag: 'right',
            tooltip: 'right',
            child: Text(
              Direction.right.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myDirection = Direction.left;
              });
              chooseComputerText();
            },
            heroTag: 'left',
            tooltip: 'left',
            child: Text(
              Direction.left.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}

enum Direction {
  up,
  down,
  right,
  left;

  String get text {
    switch (this) {
      case Direction.up:
        return '👆';
      case Direction.down:
        return '👇';
      case Direction.right:
        return '👉';
      case Direction.left:
        return '👈';
    }
  }
}

enum ResultLTW {
  // あっち向いてホイの勝敗
  match,
  different,
}

enum ResultOverall {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case ResultOverall.win:
        return 'あなたの勝ち！';
      case ResultOverall.lose:
        return 'あなたの負け';
      case ResultOverall.draw:
        return 'あいこ！もういっかい！';
    }
  }
}
