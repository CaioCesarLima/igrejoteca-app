import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/emprestimos/data/loan_repository.dart';
import 'package:igrejoteca_app/modules/emprestimos/data/loan_repository_impl.dart';
import 'package:igrejoteca_app/modules/emprestimos/data/models/loan_model.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/event/loan_event.dart';
import 'package:igrejoteca_app/modules/emprestimos/store/bloc/loan/state/loan_state.dart';
import 'package:result_dart/result_dart.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState>{
  LoanRepository loanRepository = LoanRepositoryImpl();
  LoanBloc(): super(EmptyLoanState()){
    on<GetLoanEvent>(_getLoan);
  }


  Future<void> _getLoan(GetLoanEvent event, Emitter emit) async{
    emit(LoadingLoanState());
    Result<List<LoanModel>, Exception> result = await loanRepository.getUserLoan();
    result.fold((success) {
      if(success.isEmpty){
        emit(EmptyLoanState());
      }else{
        emit(LoadedLoanState(success));
      }
    }, (failure) => emit(ErrorLoanState()));
  }
}