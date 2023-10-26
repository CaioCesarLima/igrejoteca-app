class ClubModel {
  final String clubId;
  final String clubName;
  final String bookId;
  final String bookName;
  final String ownerId;
  final String ownerName;

  ClubModel(
      {required this.clubId,
      required this.clubName,
      required this.bookId,
      required this.bookName,
      required this.ownerId,
      required this.ownerName});

  factory ClubModel.fromjson(Map<String, dynamic> json) {
    final String clubId = json['id'];
    final String clubName = json['name'] ?? "";
    final String bookId = json['book']['id'] ?? "";
    final String bookName = json['book']['name'] ?? "";
    final String ownerId = json['owner']['id'] ?? "";
    final String ownerName = json['owner']['name'] ?? "";
    return ClubModel(
        clubId: clubId,
        clubName: clubName,
        bookId: bookId,
        bookName: bookName,
        ownerId: ownerId,
        ownerName: ownerName);
  }
}
