import "package:flutter/material.dart";
import "keypad.dart";
import "scoreBox.dart";
import "playerCard.dart";
import "match.dart";

class MatchPage extends StatefulWidget {
  final Match match;
  MatchPage(this.match);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  void initState() {
    super.initState();
    match = widget.match;
  }

  Match match;
  String scoreBoxDisplay = "Score";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spacing = width * 0.01;
    double keypadHeightFactor = 0.45;

    void updateScorebox(String buttonText) {
      String newText;
      if (buttonText == "DEL") {
        if (scoreBoxDisplay == "Score" || scoreBoxDisplay == "") {
          return;
        } else {
          newText = scoreBoxDisplay.substring(0, scoreBoxDisplay.length - 1);
        }
      } else if (buttonText == "OK") {
        match.updateScore(int.parse(scoreBoxDisplay));
        newText = "Score";
      } else {
        if (scoreBoxDisplay == "Score") {
          newText = buttonText;
        } else if (int.parse(scoreBoxDisplay + buttonText) > 180 ||
            scoreBoxDisplay.length == 3) {
          return;
        } else {
          newText = scoreBoxDisplay + buttonText;
        }
      }
      return setState(() {
        scoreBoxDisplay = newText;
      });
    }

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Are you sure you want to go back?"),
          content: Text("All current progress in this match will be lost"),
          actions: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ??
      false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
                "${match.players[0].name.trim()} vs. ${match.players[1].name.trim()}    Sets: ${match.setLimit.toString()}, Legs: ${match.legLimit.toString()}"),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(spacing),
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.grey[900],
                    child: Padding(
                      padding: EdgeInsets.all(spacing * 4),
                      child: PlayerCardRow(match.players, spacing),
                    ),
                  ),
                ),
                Container(height: spacing),
                Container(
                  height: (height * keypadHeightFactor - 3 * spacing) / 4,
                  child: ScoreBox(scoreBoxDisplay),
                ),
                Container(height: spacing),
                Container(
                    height: height * keypadHeightFactor,
                    child: Keypad(updateScorebox, spacing)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
