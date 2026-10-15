import 'dart:math';
import '../models/player_model.dart';

class GameManager {
  static void assignRolesRandomly(List<Player> players) {
    players.shuffle(Random());
    int total = players.length;

    for (int i = 0; i < total; i++) {
      if (i == 0) {
        players[i].role = PlayerRole.mafiaBoss;
      } else if (i == 1 && total >= 6) {
        players[i].role = PlayerRole.mafiaMute;
      } else if (i == 2 && total >= 7) {
        players[i].role = PlayerRole.doctor;
      } else if (i == 3 && total >= 8) {
        players[i].role = PlayerRole.sniper;
      } else if (i == 4 && total >= 9) {
        players[i].role = PlayerRole.detective; // العمدة
      } else {
        players[i].role = PlayerRole.citizen;
      }
    }
  }
}
