import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_univ_janken/look_that_way.dart';

class Janken extends StatefulWidget {
  const Janken({super.key, required this.title});

  final String title;

  @override
  State<Janken> createState() => _JankenState();
}

class _JankenState extends State<Janken> {
  Hand? myHand;
  Hand? computerHand;
  ResultJanken? resultJanken;
  bool isWaiting = false;

  void chooseComputerHand() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerHand = hand;
    });
    decideResultJanken();

    if (resultJanken == ResultJanken.win || resultJanken == ResultJanken.lose) {
      setState(() {
        isWaiting = true;
      });

      Timer(const Duration(milliseconds: 1500), () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LookThatWay(resultJanken: resultJanken!),
            fullscreenDialog: true,
          ),
        );

        // LookThatWayから戻ったら、全ての状態をリセット
        setState(() {
          myHand = null;
          computerHand = null;
          resultJanken = null;
          isWaiting = false;
        });
      });
    }
  }

  void decideResultJanken() {
    if (myHand == null || computerHand == null) {
      return;
    }

    final ResultJanken resultJanken;

    if (myHand == computerHand) {
      resultJanken = ResultJanken.draw;
    } else if (myHand == Hand.rock && computerHand == Hand.scissors) {
      resultJanken = ResultJanken.win;
    } else if (myHand == Hand.scissors && computerHand == Hand.paper) {
      resultJanken = ResultJanken.win;
    } else if (myHand == Hand.paper && computerHand == Hand.rock) {
      resultJanken = ResultJanken.win;
    } else {
      resultJanken = ResultJanken.lose;
    }

    setState(() {
      this.resultJanken = resultJanken;
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
              height: 40,
            ),
            Text(
              resultJanken?.text ?? '手を選択してください',
              style: const TextStyle(fontSize: 30),
            ),
            if (resultJanken == ResultJanken.win ||
                resultJanken == ResultJanken.lose)
              const Text(
                'あっち向いてホイへ進みます',
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(
              height: 40,
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
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myHand = Hand.rock;
                    });
                    chooseComputerHand();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'rock',
            tooltip: 'rock',
            child: Text(
              Hand.rock.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myHand = Hand.scissors;
                    });
                    chooseComputerHand();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'scissors',
            tooltip: 'scissors',
            child: Text(
              Hand.scissors.text,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: isWaiting
                ? null
                : () {
                    setState(() {
                      myHand = Hand.paper;
                    });
                    chooseComputerHand();
                  },
            disabledElevation: 0,
            backgroundColor: isWaiting ? Colors.black12 : null,
            heroTag: 'paper',
            tooltip: 'paper',
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

enum ResultJanken {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case ResultJanken.win:
        return '勝ち！';
      case ResultJanken.lose:
        return '負け！';
      case ResultJanken.draw:
        return 'あいこ！もういっかい！';
    }
  }
}
