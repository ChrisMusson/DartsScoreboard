import "package:flutter/material.dart";
import "player.dart";
import "utils.dart";

class PlayerCard extends StatelessWidget {
  final Player player;
  PlayerCard(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: player.active ? Colors.grey[600] : Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            player.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          Text(
            player.remaining.toString(),
            style: TextStyle(color: Colors.white, fontSize: 38.0),
          ),
          c.containsKey(player.remaining)
              ? Text(
                  c[player.remaining],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              : Text(
                  " ",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16.0,
                  ),
                ),
          Text(
            "Sets: ${player.sets}   Legs: ${player.legs}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Text(
            "Avg: ${roundDouble(player.avg, 2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerCardRow extends StatelessWidget {
  PlayerCardRow(this.players, this.spacing);
  final List<Player> players;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: PlayerCard(players[0])),
        Container(width: spacing * 8),
        Expanded(child: PlayerCard(players[1])),
      ],
    );
  }
}
