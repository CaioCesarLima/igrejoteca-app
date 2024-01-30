import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/serialize_name.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/post_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories_impl.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/posts_repositories.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/posts_repositories_impl.dart';
import 'package:igrejoteca_app/modules/clubs/store/bloc/posts_bloc.dart';
import 'package:igrejoteca_app/modules/clubs/store/event/posts_event.dart';
import 'package:igrejoteca_app/modules/clubs/store/state/posts_state.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

import '../../../../shared/Widgets/app_button.dart';
import '../../../../shared/Widgets/app_text_main_widget.dart';
import '../../../../shared/Widgets/custom_dialog.dart';
import '../../../login/store/auth_state.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key, required this.club});
  final ClubModel club;
  static const String route = '/club';
  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final bool participante = true;

  late PostBloc postBloc;
  bool isMember = false;

  @override
  void initState() {
    super.initState();
    postBloc = GetIt.I<PostBloc>();
    postBloc.add(GetPostsEvent(widget.club.clubId));
  }

  _bottomSheet() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,

        backgroundColor: Colors.transparent,
        builder: (context) {
          return BottomSheetPrayer(clubId: widget.club.clubId);
        }).then((value) {
           if(value != null){
            postBloc.add(GetPostsEvent(widget.club.clubId));
           }
        });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: GetIt.I<AuthBloc>(),
      builder: (context, authState) {
      return Scaffold(
        backgroundColor: AppColors.lightBlueColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.club.bookName.serialize()),
        ),
        drawer: const CustomDrawer(),
        body: BlocConsumer(
          listener: (context, state) {
            String authId = (authState as UserLoggedState).user.id;
            if(state is EmptyPostsState){
              setState(() {
                isMember = state.members.any((element) => element == authId);
              });
            }

            if(state is LoadedPostsState){
              setState(() {
                isMember = state.payload.members.any((element) => element == authId);
              });
            }
          },
          bloc: postBloc,
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedPostsState) {
              return ListView.builder(
                itemCount: state.payload.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: state.payload.posts[index]);
                }
              );
            }
            if(state is EmptyPostsState){
              return const Center(
              child: Text("Ainda sem postagens"),
            );
            }
            return const Center(
              child: Text("Falha ao carregar postagens!"),
            );
          },
        ),
        floatingActionButtonLocation: isMember
            ? FloatingActionButtonLocation.endFloat
            : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isMember
            ? FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  _bottomSheet();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : SizedBox(
                width: 150,
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    ClubsRepositoriesImpl().addMember(clubId: widget.club.clubId).then((value) {
                      setState(() {
                        isMember = value;
                      });
                    });
                  },
                  child: const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Participar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )),
                ),
              ));
    },);
  }
}

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      // width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              post.userName.serialize(),
              style: const TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
            child: Text(
              post.text,
              style: const TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
              child: Text(
                "página: ${post.pageNumber}",
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetPrayer extends StatefulWidget {
  final String clubId;
  const BottomSheetPrayer({
    super.key, required this.clubId,
  });

  @override
  State<BottomSheetPrayer> createState() => _BottomSheetPrayerState();
}

class _BottomSheetPrayerState extends State<BottomSheetPrayer> {
  final TextEditingController postController = TextEditingController();
  final TextEditingController pageNumberController = TextEditingController();
  final PostsRepository postsRepository = PostsRepositoryImpl();
  bool loading = false;

  Future<PostModel?> onSubmit() async {
    setState(() {
      loading = true;
    });

    PostModel? result = await postsRepository.createPost(clubId: widget.clubId, text: postController.text, pageNumber: int.tryParse(pageNumberController.text) ?? 0);

    setState(() {
      loading = false;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: AppTextMainWidget(text: "Criar uma postagem"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: TextField(
                controller: postController,

                maxLines: 5,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: "Sua Postagem"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: pageNumberController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), label: Text("Página de referência")),
              ),
            ),
            AppButton(
                loading: loading ? true : null,
                label: "Salvar",
                backgroundColor: AppColors.primaryColor,
                ontap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onSubmit().then((value) {
                    if (value != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog(
                              text: "Post Criado com sucesso!",
                            );
                          }).whenComplete(() => Navigator.of(context).pop(value));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog(
                              text: "Ocorreu um erro ao salvar",
                            );
                          });
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
