import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/modules/emprestimos/UI/pages/emprestimos_page.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/signup_page.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/auth_event.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';

import '../../../../shared/Widgets/app_button.dart';
import '../widgets/appbar_auth_widget.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  static const String route = '/initial-login';

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.I<AuthBloc>();
    authBloc.add(CheckUserLogged());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: authBloc,
      builder: (context, state) {
        if(state is InitialAuthState){
          return Scaffold(
          appBar: appBarAuth("Bem Vindo"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/igrejoteca.png'),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                  child: AppButton(
                    label: "Log in",
                    backgroundColor: AppColors.primaryColor,
                    ontap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                  child: AppButton(
                    label: "Cadastrar",
                    backgroundColor: AppColors.accentColor,
                    ontap: () {
                      Navigator.of(context).pushNamed(SignupPage.route);
                    },
                  )),
            ],
          ),
        );
        }
        return const Center(child: CircularProgressIndicator());
      },
      listener: (context, state) {
        if(state is UserLoggedState){
          Navigator.of(context).pushNamed(EmprestimosPage.route);
        }
      },
    );
  }
}
