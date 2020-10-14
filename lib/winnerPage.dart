import "dart:math";
import "package:confetti/confetti.dart";
import "package:flutter/material.dart";
import "match.dart";

class StatsRow extends StatelessWidget {
  final Match match;
  final String stat, title;
  StatsRow(this.match, this.stat, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${match.players[0].get(stat)}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${match.players[1].get(stat)}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WinnerPage extends StatefulWidget {
  final Match match;
  WinnerPage(this.match);

  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();
    match = widget.match;
    super.initState();
  }

  Match match;

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("STATISTICS"),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 1,
              minBlastForce: 0.5,
              emissionFrequency: 0.5,
              numberOfParticles: 10,
              gravity: 0.2,
            ),
          ),
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "FIRST TO ${match.setLimit} ${match.setLimit == 1 ? "SET" : "SETS"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(height: 10),
          StatsRow(match, "name", "Player"),
          Container(height: 10),
          StatsRow(match, "sets", "Sets"),
          Container(height: 10),
          StatsRow(match, "totalLegs", "Total Legs"),
          Container(height: 10),
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "SCORING",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(height: 10),
          StatsRow(match, "avg", "3 Dart Average"),
          Container(height: 10),
          StatsRow(match, "f9avg", "First 9 Darts Average"),
          Container(height: 10),
          StatsRow(match, "80s", "80+"),
          Container(height: 10),
          StatsRow(match, "100s", "100+"),
          Container(height: 10),
          StatsRow(match, "140s", "140+"),
          Container(height: 10),
          StatsRow(match, "180s", "180+"),
          Container(height: 10),
          StatsRow(match, "maxCheckout", "Highest Checkout"),
          Container(height: 10),
        ],
      ),
    );
  }
}
