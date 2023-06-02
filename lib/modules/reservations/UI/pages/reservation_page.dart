import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/books/UI/pages/home_books_page.dart';
import 'package:igrejoteca_app/modules/reservations/data/models/reservation_model.dart';
import 'package:igrejoteca_app/modules/reservations/store/bloc/reservation/bloc/reservation_bloc.dart';
import 'package:igrejoteca_app/modules/reservations/store/bloc/reservation/event/reservation_event.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

import '../../store/bloc/reservation/state/reservation_state.dart';

class ReservatiionPage extends StatefulWidget {
  const ReservatiionPage({super.key});

  static const String route = "/reservation";

  @override
  State<ReservatiionPage> createState() => _ReservatiionPageState();
}

class _ReservatiionPageState extends State<ReservatiionPage> {
  late ReservationBloc _reservationBloc;

  @override
  void initState() {
    super.initState();
    _reservationBloc = GetIt.I<ReservationBloc>();
    _reservationBloc.add(LoadReservationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reservas"),
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        bloc: _reservationBloc,
        builder: (context, state) {
          if (state is LoadingReservationState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EmptyReservationState) {
            return const Center(
              child: Text("Nenhuma Reserva realizada ainda"),
            );
          }
          if (state is LoadedReservationState) {
            return Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Consts.khorintalPading, vertical: 10),
                  child: ListView.builder(
                    itemCount: state.reserves.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CardReservationBook(reserve: state.reserves[index]),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: Consts.khorintalPading),
                child: AppButton(
                    label: "Reservar",
                    backgroundColor: AppColors.primaryColor,
                    ontap: () {
                      Navigator.of(context).pushNamed(HomeBooksPage.route);
                    }),
              ),
            ]);
          }
          return Container();
        },
      ),
    );
  }
}

class CardReservationBook extends StatelessWidget {
  final ReservationModel reserve;
  const CardReservationBook({
    Key? key, required this.reserve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                spreadRadius: .2,
                offset: Offset(1, 3))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Consts.khorintalPading),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.accentColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              reserve.book.title,
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
