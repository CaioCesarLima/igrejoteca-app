
import 'package:igrejoteca_app/modules/clubs/data/models/post_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class PostsRepository {
  Future<Result<ClubPayload, Exception>> getPosts(String clubId);
  Future<PostModel?> createPost({required String clubId, required String text});
}