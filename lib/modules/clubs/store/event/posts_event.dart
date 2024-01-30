abstract class PostsEvent{}


class GetPostsEvent extends PostsEvent{
  final String clubId;

  GetPostsEvent(this.clubId);
}