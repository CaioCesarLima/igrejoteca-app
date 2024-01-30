import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/serialize_name.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/club_page.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/clubs_repositories_impl.dart';
import 'package:igrejoteca_app/modules/clubs/store/bloc/clubs_bloc.dart';
import 'package:igrejoteca_app/modules/clubs/store/event/clubs_event.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';
import 'package:logger/logger.dart';

import '../../../../shared/Widgets/app_button.dart';
import '../../../../shared/Widgets/app_text_main_widget.dart';
import '../../../../shared/Widgets/custom_dialog.dart';
import '../../store/state/clubs_state.dart';

class ClubsPage extends StatefulWidget {
  final String? bookId;
  const ClubsPage({super.key, this.bookId});
  static const String route = '/clubs';
  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  late ClubBloc _clubBloc;

  @override
  void initState() {
    _clubBloc = GetIt.I<ClubBloc>();
    if (widget.bookId != null) {
      _clubBloc.add(GetBookClubsEvent(widget.bookId!));
    } else {
      _clubBloc.add(GetClubsEvent());
    }
    super.initState();
  }

  _bottomSheet() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,

        backgroundColor: Colors.transparent,
        builder: (context) {
          return BottomSheetPrayer(bookId: widget.bookId!,);
        }).then((value) {
           if(value != null){
            _clubBloc.add(GetBookClubsEvent(widget.bookId!));
           }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      floatingActionButton: widget.bookId != null
          ?  SizedBox(
            width: 150,
            child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      _bottomSheet();
                    },
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Criar Grupo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )),
                  ),
          )
          : Container(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clube do Livro"),
        actions: [
          BlocBuilder(
            bloc: _clubBloc,
            builder: (context, state) {
              if (state is LoadedClubsState) {
                return IconButton(
                    onPressed: () {
                      _clubBloc.add(GetUserClubsEvent());
                    },
                    icon: const Text(
                      "Meus grupos",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ));
              }

              if (state is LoadedUserClubsState) {
                return IconButton(
                    onPressed: () {
                      _clubBloc.add(GetClubsEvent());
                    },
                    icon: const Text(
                      "Todos Grupos",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ));
              }

              return Container();
            },
          )
        ],
      ),
      drawer: const CustomDrawer(),
      // body: const Center(child: Text("Em Breve ...")),
      body: BlocBuilder(
        bloc: _clubBloc,
        builder: (context, state) {
          if (state is LoadedClubsState) {
            return ListView.builder(
              itemCount: state.clubs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, ClubPage.route,
                      arguments: state.clubs[index]);
                }),
                child: ClubCard(
                  club: state.clubs[index],
                ),
              ),
            );
          }
          if (state is LoadedUserClubsState) {
            return ListView.builder(
              itemCount: state.clubs.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, ClubPage.route,
                      arguments: state.clubs[index]);
                }),
                child: ClubCard(
                  club: state.clubs[index],
                ),
              ),
            );
          }
          if (state is LoadingLoaClubsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("Sem clubs no momento"),
          );
        },
      ),
    );
  }
}

class ClubCard extends StatelessWidget {
  final ClubModel club;
  const ClubCard({
    super.key,
    required this.club,
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
          Container(
            decoration: const BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    club.clubName.serialize(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, bottom: 15),
                  child: Text(
                    club.bookName,
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
            child: Text(
              "Criador: ${club.ownerName.serialize()}",
              style: const TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}


class BottomSheetPrayer extends StatefulWidget {
  final String bookId;
  const BottomSheetPrayer({
    super.key, required this.bookId,
  });

  @override
  State<BottomSheetPrayer> createState() => _BottomSheetPrayerState();
}

class _BottomSheetPrayerState extends State<BottomSheetPrayer> {
  final TextEditingController nameController = TextEditingController();
  final ClubsRepositories postsRepository = ClubsRepositoriesImpl();
  bool loading = false;

  _BottomSheetPrayerState();

  Future<bool> onSubmit() async {
    setState(() {
      loading = true;
    });

    bool result = await postsRepository.createClub(bookId: widget.bookId, name: nameController.text);

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
              child: AppTextMainWidget(text: "Criar Novo Grupo"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(border: OutlineInputBorder(), hintText: "Nome do grupo"),
              ),
            ),
            AppButton(
                loading: loading ? true : null,
                label: "Criar",
                backgroundColor: AppColors.primaryColor,
                ontap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onSubmit().then((value) {
                    if (value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog(
                              text: "Grupo Criado com sucesso!",
                            );
                          }).whenComplete(() => Navigator.of(context).pop(value));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog(
                              text: "Ocorreu um erro ao criar o grupo",
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