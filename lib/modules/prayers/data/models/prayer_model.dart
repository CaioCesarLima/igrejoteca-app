class PrayerModel {
  final String id;
  final String description;
  final bool isAnonymous;
  final int like;
  final String owner;

  PrayerModel( 
      {required this.id, required this.description, required this.isAnonymous, required this.like, required this.owner,});

  factory PrayerModel.fromjson(Map<String, dynamic> json) {
    final String id = json['id'];
    final String description = json['description'];
    final bool isAnonymous = json['is_anonymous'];
    final int like = json['like'];
    final String owner = json['owner'];

    return PrayerModel(id: id, description: description, isAnonymous: isAnonymous, like: like, owner: owner);
  }
}
