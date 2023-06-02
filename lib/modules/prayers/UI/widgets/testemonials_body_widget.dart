import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/prayers/UI/widgets/testemonial_card_widget.dart';
import 'package:igrejoteca_app/modules/prayers/data/testemonies_repository_impl.dart';
import 'package:igrejoteca_app/modules/prayers/data/tetemonies_repository.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/bloc/testemony_bloc.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/event/testemony_event.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/state/testemony_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_dialog.dart';

class TestemonialsWidget extends StatefulWidget {
  const TestemonialsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TestemonialsWidget> createState() => _TestemonialsWidgetState();
}

class _TestemonialsWidgetState extends State<TestemonialsWidget> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TestemonyBloc, TestemonyState>(
        bloc: testemonyBloc,
        builder: (context, state) {
          if(state is EmptyTestemonyState){
            return const Center(child: Text('Lista de testemunhos vazia'),);
          }
          if (state is LoadedTestemonyState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.testemonies.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Consts.khorintalPading, vertical: 10),
                        child: TestemonialCardWidget(
                            testemonieModel: state.testemonies[index]),
                      );
                    }),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
              child: AppTextMainWidget(text: "registrar um novo testemunho"),
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
