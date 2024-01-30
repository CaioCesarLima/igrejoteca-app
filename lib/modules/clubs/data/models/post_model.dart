class PostModel {
  final String postId;
  final String text;
  final String userName;
  final int pageNumber;

  PostModel({required this.pageNumber,required this.postId, required this.text, required this.userName});

  factory PostModel.fromjson(Map<String, dynamic> json) {
    final String postId = json['id'];
    final String text = json['text'] ?? "";
    final String userName = json['user']['name'] ?? "";
    final int pageNumber = json['page']?? 0;

    return PostModel(postId: postId, text: text, userName: userName, pageNumber: pageNumber);
  }
}


class ClubPayload {
  final List<String> members;
  final List<PostModel> posts;

  ClubPayload({required this.members, required this.posts});
}