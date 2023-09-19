import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/emprestimos/UI/pages/emprestimos_page.dart';
import 'package:igrejoteca_app/modules/login/UI/widgets/appbar_auth_widget.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/auth_event.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/app_text_main_widget.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String route = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc authBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.I<AuthBloc>();
    // ignore: invalid_use_of_visible_for_testing_member
    authBloc.emit(InitialAuthState());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarAuth("Log in"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * .2,
              child: Image.asset('assets/images/logo.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(left: Consts.khorintalPading),
              child: AppTextMainWidget(text: "Qual é o seu E-mail?"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Consts.khorintalPading),
              child: AppTextFieldWidget(
                controller: _emailController,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: Consts.khorintalPading),
              child: AppTextMainWidget(text: "Digite sua senha"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Consts.khorintalPading),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFieldWidget(
                      controller: _passwordController,
                      obscure: obscurePassword,
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  }, icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: Consts.khorintalPading,
                    right: Consts.khorintalPading,
                    top: 80),
                child: BlocConsumer(
                  listener: (context, state) {
                    if (state is ErrorAuthState) {
                      showDialog(
                              context: context,
                              builder: (context) {
                                return const CustomDialog(text: "Usuário ou senha inválidos");
                              })
                          .whenComplete(
                              // ignore: invalid_use_of_visible_for_testing_member
                              () => authBloc.emit(InitialAuthState()));
                    }

                    if (state is UserLoggedState) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          EmprestimosPage.route, (route) => false);
                    }
                  },
                  bloc: authBloc,
                  builder: (context, state) {
                    if (state is InitialAuthState) {
                      return AppButton(
                          label: "Acessar",
                          backgroundColor: AppColors.primaryColor,
                          ontap: () {
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     EmprestimosPage.route, (route) => false);
                            authBloc.add(LoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text));
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
