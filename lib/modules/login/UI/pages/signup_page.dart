import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/initial_page.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/login_page.dart';
import 'package:igrejoteca_app/modules/login/UI/widgets/appbar_auth_widget.dart';
import 'package:igrejoteca_app/modules/login/UI/widgets/signup_email_widget.dart';
import 'package:igrejoteca_app/modules/login/UI/widgets/signup_name_widget.dart';
import 'package:igrejoteca_app/modules/login/UI/widgets/signup_password_widget.dart';
import 'package:igrejoteca_app/modules/login/store/auth_bloc.dart';
import 'package:igrejoteca_app/modules/login/store/auth_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_dialog.dart';
import 'package:igrejoteca_app/shared/data/models/auth_payload.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository.dart';
import 'package:igrejoteca_app/shared/data/repositories/auth/auth_repository_impl.dart';
import 'package:result_dart/result_dart.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String route = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late AuthBloc authBloc;
  final PageController pageController = PageController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository authRepository = AuthRepositoryImpl();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc();
    // ignore: invalid_use_of_visible_for_testing_member
    authBloc.emit(InitialAuthState());
    
  }

  Future<AuthPayload?> onSubmit() async {
   
    setState(() {
      loading = true;
    });
    Result<AuthPayload, Exception>? response = await authRepository.signup(
      nameController.text,
      emailController.text,
      passwordController.text,
    );

    
    AuthPayload? result =
        response.fold((success) => success, (failure) => null);
    setState(() {
      loading = false;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: appBarAuth("Cadastro"),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: Consts.khorintalPading),
                      child: SignupNameWidget(controller: nameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: Consts.khorintalPading),
                      child: SignupEmailWidget(controller: emailController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: Consts.khorintalPading),
                      child: SignupPasswordWidget(
                        controller: passwordController,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Consts.khorintalPading, vertical: 20),
                child: state is LoadingAuthState
                    ? const Center(child: CircularProgressIndicator())
                    : AppButton(
                        label: "Próximo",
                        loading: loading,
                        backgroundColor: AppColors.primaryColor,
                        icon: Icons.arrow_forward_ios_rounded,
                        ontap: () {

                          if (pageController.page! < 2.0) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          } else if (pageController.page! == 2.0) {
                            setState(() {
                              loading = true;
                            });
                            onSubmit().then((value) {
                              if (value is AuthPayload) {
                                authBloc.emit(UserLoggedState(
                                    token: value.token, user: value.user));
                                showDialog(context: context, builder: (context){
                                  return const CustomDialog(text: "Cadasto realizado com sucesso, faça login no app");
                                }).whenComplete(() => Navigator.of(context).pushReplacementNamed(
                                    LoginPage.route));
                              }else{
                                showDialog(context: context, builder: (context){
                                  return const CustomDialog(text: "Erro ao realizar o cadastro, tente novamente mais tarde");
                              }).whenComplete(() => Navigator.of(context).pushReplacementNamed(
                                    InitialPage.route));;}
                            });
                          }
                        }),
              )
            ],
          ),
        );
      },
    );
  }
}
