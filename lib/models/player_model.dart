enum PlayerRole { mafiaBoss, mafiaMute, doctor, sniper, goodKid, detective, citizen }
enum PlayerStatus { alive, dead, ghost }

class Player {
  final String id;
  String name;
  PlayerRole role;
  PlayerStatus status;
  bool isMuted;
  bool hasUsedSniperBullet;
  int votesCount;

  Player({
    required this.id,
    required this.name,
    required this.role,
    this.status = PlayerStatus.alive,
    this.isMuted = false,
    this.hasUsedSniperBullet = false,
    this.votesCount = 1,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role.index,
    'status': status.index,
    'isMuted': isMuted,
  };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json['id'],
    name: json['name'],
    role: PlayerRole.values[json['role']],
    status: PlayerStatus.values[json['status']],
    isMuted: json['isMuted'],
  );
}
