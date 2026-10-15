import '../models/player_model.dart';

class GameRolesHandler {
  // 1. قاعدة العمدة: إذا كشف نفسه يصبح صوته بـ 3 أصوات
  static int getPlayerVotePower(Player player, bool isMayorRevealed) {
    if (player.role == PlayerRole.detective && isMayorRevealed) {
      return 3;
    }
    return 1;
  }

  // 2. فحص شروط الفوز تلقائياً
  static String checkWinCondition(List<Player> players) {
    int aliveMafia = players.where((p) => (p.role == PlayerRole.mafiaBoss || p.role == PlayerRole.mafiaMute) && p.status == PlayerStatus.alive).length;
    int aliveCitizens = players.where((p) => p.role != PlayerRole.mafiaBoss && p.role != PlayerRole.mafiaMute && p.status == PlayerStatus.alive).length;

    if (aliveMafia == 0) {
      return "فوز الفريق الصالح! تم اجتثاث جميع أفراد المافيا.";
    } else if (aliveMafia >= aliveCitizens) {
      return "فوز المافيا! لقد سيطروا على الأغلبية المطلقة.";
    }
    return "اللعبة مستمرة";
  }
}
