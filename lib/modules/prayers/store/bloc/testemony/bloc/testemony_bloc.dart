import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/prayers/data/models/testemonie_model.dart';
import 'package:igrejoteca_app/modules/prayers/data/testemonies_repository_impl.dart';
import 'package:igrejoteca_app/modules/prayers/data/tetemonies_repository.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/event/testemony_event.dart';
import 'package:igrejoteca_app/modules/prayers/store/bloc/testemony/state/testemony_state.dart';
import 'package:result_dart/result_dart.dart';

class TestemonyBloc extends Bloc<TestemonieEvent, TestemonyState>{
  TestemoniesRepository testemoniesRepository = TestemoniesRepositoryImpl();
  TestemonyBloc(): super(EmptyTestemonyState()){
    on<GetAllTestemonieEvent>(_getAllTestemonies);
  }


  Future<void> _getAllTestemonies(GetAllTestemonieEvent event, Emitter emit) async{
    emit(LoadingTestemonyState());
    Result<List<TestemonieModel>, Exception> result = await testemoniesRepository.getTestimonies();
    result.fold((success) {
      if(success.isEmpty){
        emit(EmptyTestemonyState());
      }else{
        emit(LoadedTestemonyState(success));
      }
    }, (failure) => emit(ErrorTestemonyState()));
  }
}