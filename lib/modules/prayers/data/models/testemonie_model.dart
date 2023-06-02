class TestemonieModel {
  final String id;
  final String description;
  final String owner;

  TestemonieModel({
    required this.id,
    required this.description,
    required this.owner,
  });

  factory TestemonieModel.fromjson(Map<String, dynamic> json) {
    final String id = json['id'];
    final String description = json['description'];
    final String owner = json['owner'];

    return TestemonieModel(
        id: id,
        description: description,
        owner: owner);
  }
}
