import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

import '../../../../shared/Widgets/app_button.dart';
import '../../../../shared/Widgets/app_text_main_widget.dart';
import '../../../../shared/Widgets/custom_dialog.dart';
import '../../../prayers/data/testemonies_repository_impl.dart';
import '../../../prayers/data/tetemonies_repository.dart';
import '../../../prayers/store/bloc/testemony/bloc/testemony_bloc.dart';
import '../../../prayers/store/bloc/testemony/event/testemony_event.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key, this.clubId});
  final String? clubId;
  static const String route = '/club';
  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final bool participante = true;
  late TestemonyBloc testemonyBloc;

  @override
  void initState() {
    super.initState();
    testemonyBloc = GetIt.I<TestemonyBloc>();
    testemonyBloc.add(GetAllTestemonieEvent());
  }

  _bottomSheet() {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return const BottomSheetPrayer();
        }).whenComplete(() => testemonyBloc.add(GetAllTestemonieEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBlueColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Nome do Livro"),
        ),
        drawer: const CustomDrawer(),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => GestureDetector(
            onTap: (() {}),
            child: const PostCard(),
          ),
        ),
        floatingActionButtonLocation: participante
            ? FloatingActionButtonLocation.endFloat
            : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: participante
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
                  onPressed: () {},
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
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              "Nome do usuário",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
            child: Text(
              "Esse é meu comentário sobre o livro que eu queria compartilhar com todos vocês",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetPrayer extends StatefulWidget {
  const BottomSheetPrayer({
    super.key,
  });

  @override
  State<BottomSheetPrayer> createState() => _BottomSheetPrayerState();
}

class _BottomSheetPrayerState extends State<BottomSheetPrayer> {
  final TextEditingController prayerController = TextEditingController();
  final TestemoniesRepository testemoniesRepository =
      TestemoniesRepositoryImpl();
  bool loading = false;
  bool? isAnonymous = false;

  Future<bool> onSubmit() async {
    setState(() {
      loading = true;
    });

    bool result = await testemoniesRepository.createTestimony(
        description: prayerController.text);

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: TextField(
                  controller: prayerController,
                  maxLines: 5,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
            AppButton(
                loading: loading ? true : null,
                label: "Salvar",
                backgroundColor: AppColors.primaryColor,
                ontap: () {
                  onSubmit().then((value) {
                    if (value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDialog(
                              text: "testemunho registrado com sucesso!",
                            );
                          }).whenComplete(() => Navigator.of(context).pop());
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
