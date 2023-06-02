import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/prayers/UI/widgets/prayer_card_widget.dart';
import 'package:igrejoteca_app/modules/prayers/UI/widgets/prayers_body_widget.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/bloc/loan_bloc.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/event/prayer_event.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/prayer/state/prayer_state.dart';

class UserPrayersWidget extends StatefulWidget {
  const UserPrayersWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPrayersWidget> createState() => _UserPrayersWidgetState();
}

class _UserPrayersWidgetState extends State<UserPrayersWidget> {
  late PrayerBloc prayerBloc;

  @override
  void initState() {
    super.initState();
    prayerBloc = GetIt.I<PrayerBloc>();
    prayerBloc.add(GetUserPrayersEvent());
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
        onPressed: () {
          _bottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        bloc: prayerBloc,
        builder: (context, state) {
          if(state is EmptyPrayerState){
            return const Center(child: Text('Lista de orações vazia'),);
          }
          if(state is LoadedPrayerState){
            return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.prayers.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Consts.khorintalPading, vertical: 10),
                      child: PrayerCardWidget(prayerModel: state.prayers[index]),
                    );
                  }),
                ),
              ),
            ],
          );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
