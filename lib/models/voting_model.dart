enum DefenseStatus { defending, votingOnAcquittal, completed }

class VoteManager {
  String? accusedPlayerId;
  DefenseStatus status = DefenseStatus.defending;
  int yesVotes = 0;
  int noVotes = 0;
  
  // قائمة لتتبع من قام بالتصويت حتى لا يصوت اللاعب مرتين
  final Set<String> _votedPlayers = {};

  void startDefense(String playerId) {
    accusedPlayerId = playerId;
    status = DefenseStatus.defending;
    yesVotes = 0;
    noVotes = 0;
    _votedPlayers.clear();
  }

  void openAcquittalVoting() {
    status = DefenseStatus.votingOnAcquittal;
  }

  bool castVote(String voterId, bool saveThePlayer) {
    if (_votedPlayers.contains(voterId)) return false; // صوت مسبقاً
    _votedPlayers.add(voterId);
    
    if (saveThePlayer) {
      yesVotes++;
    } else {
      noVotes++;
    }
    return true;
  }
}
