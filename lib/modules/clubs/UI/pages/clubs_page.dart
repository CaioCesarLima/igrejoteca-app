import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/club_page.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:igrejoteca_app/modules/clubs/store/bloc/clubs_bloc.dart';
import 'package:igrejoteca_app/modules/clubs/store/event/clubs_event.dart';
import 'package:igrejoteca_app/modules/clubs/store/state/clubs_state.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});
  static const String route = '/clubs';
  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  late ClubBloc _clubBloc;

  @override
  void initState() {
    _clubBloc = GetIt.I<ClubBloc>();
    _clubBloc.add(GetClubsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBlueColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Club do Livro"),
        ),
        drawer: const CustomDrawer(),
        body: const Center(child: Text("Em Breve ...")),
        // body: BlocBuilder(
        //   bloc: _clubBloc,
        //   builder: (context, state) {
        //     if (state is LoadedClubsState) {
        //       return ListView.builder(
        //         itemCount: state.clubs.length,
        //         itemBuilder: (context, index) => GestureDetector(
        //           onTap: (() {
        //             Navigator.pushNamed(context, ClubPage.route);
        //           }),
        //           child: ClubCard(club: state.clubs[index],),
        //         ),
        //       );
        //     }
        //     if (state is LoadingLoaClubsState) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     return const Center(
        //       child: Text("Sem clubs no momento"),
        //     );
        //   },
        // ),
        );
  }
}

class ClubCard extends StatelessWidget {
  final ClubModel club;
  const ClubCard({
    super.key, required this.club,
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
                    club.clubName,
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
              club.ownerName,
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
