class PostModel {
  final String postId;
  final String text;
  final String userName;

  PostModel({required this.postId, required this.text, required this.userName});

  factory PostModel.fromjson(Map<String, dynamic> json) {
    final String postId = json['id'];
    final String text = json['text'] ?? "";
    final String userName = json['user']['name'] ?? "";

    return PostModel(postId: postId, text: text, userName: userName);
  }
}


class ClubPayload {
  final List<String> members;
  final List<PostModel> posts;

  ClubPayload({required this.members, required this.posts});
}