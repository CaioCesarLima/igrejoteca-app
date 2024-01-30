import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/post_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/posts_repositories.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/posts_repositories_impl.dart';
import 'package:igrejoteca_app/modules/clubs/store/event/posts_event.dart';
import 'package:igrejoteca_app/modules/clubs/store/state/posts_state.dart';
import 'package:result_dart/result_dart.dart';

class PostBloc extends Bloc<PostsEvent, PostState> {
  PostsRepository postsRepository = PostsRepositoryImpl();
  PostBloc() : super((EmptyPostsState([]))) {
    on<GetPostsEvent>(_getPostsClub);
  }

  Future<void> _getPostsClub(GetPostsEvent event, Emitter emit) async {
    emit(LoadingPostsState());
    Result<ClubPayload, Exception> result = await postsRepository.getPosts(event.clubId);
    result.fold((success) {
      if (success.posts.isEmpty) {
        emit(EmptyPostsState(success.members));
      } else {
        emit(LoadedPostsState(success));
      }
    }, (failure) => emit(ErrorPostsState()));
  }
}
