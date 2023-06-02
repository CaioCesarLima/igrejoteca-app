import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/books/UI/pages/home_books_page.dart';
import 'package:igrejoteca_app/modules/emprestimos/data/models/loan_model.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/bloc/loan_bloc.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/event/loan_event.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/state/loan_state.dart';
import 'package:igrejoteca_app/shared/Widgets/app_button.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

class EmprestimosPage extends StatefulWidget {
  const EmprestimosPage({super.key});

  static const String route = "/emprestimos";

  @override
  State<EmprestimosPage> createState() => _EmprestimosPageState();
}

class _EmprestimosPageState extends State<EmprestimosPage> {
  late LoanBloc _loanBloc;

  @override
  void initState() {
    super.initState();
    _loanBloc = GetIt.I<LoanBloc>();
    _loanBloc.add(GetLoanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Empréstimos"),
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<LoanBloc, LoanState>(
        bloc: _loanBloc,
        builder: (context, state) {
          if (state is LoadingLoanState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is EmptyLoanState){
            return const Center(
              child: Text("Lista de Empréstimos vazia"),
            );
          }
          if (state is LoadedLoanState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30,
                      left: Consts.khorintalPading,
                      right: Consts.khorintalPading),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          "Todos",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            border: Border.all(
                                color: AppColors.accentColor, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          "Devolvidos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          "Comigo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading, vertical: 10),
                    child: ListView.builder(
                      itemCount: state.loans.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CardReservationBook(loan: state.loans[index],),
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
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CardReservationBook extends StatelessWidget {
  final LoanModel loan;
  const CardReservationBook({
    Key? key, required this.loan,
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
            CircleAvatar(
              backgroundColor: loan.returned ? AppColors.accentColor : AppColors.primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                loan.book.title,
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            loan.isLoanExpired() && !loan.returned ? const Text("Atrasado", style: TextStyle(color: Colors.red),) : Container()
          ],
        ),
      ),
    );
  }
}
