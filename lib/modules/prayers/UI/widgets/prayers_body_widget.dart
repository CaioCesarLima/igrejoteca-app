import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/prayers/UI/widgets/prayer_card_widget.dart';
import 'package:igrejoteca_app/modules/prayers/data/prayer_repository.dart';
import 'package:igrejoteca_app/modules/prayers/data/prayer_repository_impl.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/bloc/loan_bloc.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/event/prayer_event.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/state/prayer_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_dialog.dart';

class PrayersWidget extends StatefulWidget {
  const PrayersWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PrayersWidget> createState() => _PrayersWidgetState();
}

class _PrayersWidgetState extends State<PrayersWidget> {
  late PrayerBloc prayerBloc;

  @override
  void initState() {
    super.initState();
    prayerBloc = GetIt.I<PrayerBloc>();
    prayerBloc.add(GetAllPrayersEvent());
  }

  _bottomSheet() {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return const BottomSheetPrayer();
        }).whenComplete(() => prayerBloc.add(GetAllPrayersEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      floatingActionButton: FloatingActionButton(
        onPressed: _bottomSheet,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        bloc: prayerBloc,
        builder: (context, state) {
          if(state is EmptyPrayerState){
            return const Center(child: Text('Lista de orações vazia'),);
          }
          if (state is LoadedPrayerState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.prayers.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Consts.khorintalPading, vertical: 10),
                        child:
                            PrayerCardWidget(prayerModel: state.prayers[index]),
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
  final PrayerRepository prayerRepository = PrayerRepositoryImpl();
  bool loading = false;
  bool? isAnonymous = false;

  Future<bool> onSubmit() async {
    setState(() {
      loading = true;
    });

    bool result = await prayerRepository.createPrayers(
        description: prayerController.text, isAnonymous: isAnonymous ?? false);

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
              child: AppTextMainWidget(text: "Realizar Novo Pedido"),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Checkbox(
                      value: isAnonymous,
                      onChanged: (value) {
                        setState(() {
                          isAnonymous = value;
                        });
                      }),
                  const Text("Deseja anonimato?")
                ],
              ),
            ),
            AppButton(
                loading: loading ? true : null,
                label: "Salvar",
                backgroundColor: AppColors.primaryColor,
                ontap: () {
                  onSubmit().then((value) {
                    if (value) {
                      showDialog(context: context, builder: (context){
                        return const CustomDialog(text: "Pedido registrado com sucesso!",);
                      }).whenComplete(() => Navigator.of(context).pop());
                      
                    }else{
                      showDialog(context: context, builder: (context){
                        return const CustomDialog(text: "Ocorreu um erro ao salvar",);
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
