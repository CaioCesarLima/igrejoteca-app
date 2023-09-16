class RankModel {
  final int rank;
  final String name;
  final int score;

  RankModel({required this.rank, required this.name, required this.score,});

  factory RankModel.fromJson(Map<String, dynamic> json, int rankUser) {

    final int rank = rankUser;
    final String name = json['name'];
    final int score = json['score'] ?? 0;

    return RankModel(rank: rank, name: name, score: score);
  }
}