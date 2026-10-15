enum PlayerRole { mafiaBoss, mafiaMute, doctor, sniper, goodKid, detective, citizen }
enum PlayerStatus { alive, dead, ghost }

class Player {
  final String id;
  String name;
  PlayerRole role;
  PlayerStatus status;
  bool isMuted;
  String pinCode;

  Player({
    required this.id,
    required this.name,
    this.role = PlayerRole.citizen,
    this.status = PlayerStatus.alive,
    this.isMuted = false,
    required this.pinCode,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role.index,
    'status': status.index,
    'isMuted': isMuted,
    'pinCode': pinCode,
  };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json['id'],
    name: json['name'],
    role: PlayerRole.values[json['role']],
    status: PlayerStatus.values[json['status']],
    isMuted: json['isMuted'],
    pinCode: json['pinCode'],
  );
}
