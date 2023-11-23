import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_univ_janken/janken.dart';

class LookThatWay extends StatefulWidget {
  // Look That Way = あっち向いてホイ
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
  bool isWaiting = false;

  void chooseComputerDirection() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final direction = Direction.values[randomNumber];

    setState(() {
      computerDirection = direction;
    });
    decideResultLTW();
    decideResultOverall();

    if (resultOverall == ResultOverall.draw) {
      // 引き分けの場合、jankenへ戻る
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

    if (resultLTW == ResultLTW.match) {
      if (widget.resultJanken == ResultJanken.win) {
        resultOverall = ResultOverall.win;
      } else if (widget.resultJanken == ResultJanken.lose) {
        resultOverall = ResultOverall.lose;
      } else {
        resultOverall = ResultOverall.draw;
      }
    } else {
      resultOverall = ResultOverall.draw;
    }

    setState(() {
      this.resultOverall = resultOverall;
      isWaiting = true;
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
              height: 40,
            ),
            Text(
              resultOverall?.text ?? '手を選択してください',
              style: const TextStyle(fontSize: 30),
            ),
            if (resultOverall == ResultOverall.win ||
                resultOverall == ResultOverall.lose)
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('もういっかい'),
              ),
            const SizedBox(
              height: 40,
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
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myDirection = Direction.up;
                    });
                    chooseComputerDirection();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'up',
            tooltip: 'up',
            child: Text(
              Direction.up.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myDirection = Direction.down;
                    });
                    chooseComputerDirection();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'down',
            tooltip: 'down',
            child: Text(
              Direction.down.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myDirection = Direction.right;
                    });
                    chooseComputerDirection();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'right',
            tooltip: 'right',
            child: Text(
              Direction.right.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myDirection = Direction.left;
                    });
                    chooseComputerDirection();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
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
  // じゃんけん・あっち向いてホイを合算した、全体の勝敗
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
