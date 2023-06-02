import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/modules/books/UI/pages/home_books_page.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/clubs_page.dart';
import 'package:igrejoteca_app/modules/emprestimos/UI/pages/emprestimos_page.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/initial_page.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/auth_event.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';
import 'package:igrejoteca_app/modules/prayers/UI/pages/prayers_page.dart';
import 'package:igrejoteca_app/modules/quiz/UI/pages/quiz_page.dart';
import 'package:igrejoteca_app/modules/reservations/UI/pages/reservation_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.I<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is LogoutAuthState) {
          Navigator.of(context).pushReplacementNamed(InitialPage.route);
        }
      },
      builder: (context, state) {
        if (state is UserLoggedState) {
          return Drawer(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text(
                      "Olá, ${(state).user.name}!",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeBooksPage.route, ((route) => false));
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Livros",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              PrayersPage.route, ((route) => false));
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Orações",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.pushNamed(context, ReservatiionPage.route);
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Reservas",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.pushNamed(context, EmprestimosPage.route);
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Empréstimos",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ClubsPage.route, ((route) => false));
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Clube do livro",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      ListTile(
                        iconColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              QuizPage.route, ((route) => false));
                        },
                        leading: const Icon(Icons.monetization_on),
                        title: const Text(
                          "Quiz",
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      authBloc.add(LogOutEvent());
                    },
                    child: const Text(
                      "Sair",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                  ),
                )
              ],
            ),
          );
          
        }
        return Container();
      },
    );
  }
}
