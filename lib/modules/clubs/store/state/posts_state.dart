import 'package:igrejoteca_app/modules/clubs/data/models/post_model.dart';

abstract class PostState{}

class LoadingPostsState extends PostState{}

class LoadedPostsState extends PostState{
  final ClubPayload payload;

  LoadedPostsState(this.payload);
}

class ErrorPostsState extends PostState{}

class EmptyPostsState extends PostState{
  final List<String> members;

  EmptyPostsState(this.members);
}
