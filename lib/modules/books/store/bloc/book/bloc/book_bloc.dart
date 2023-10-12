import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_app/modules/books/data/repositories/book_repository.dart';
import 'package:igrejoteca_app/modules/books/data/repositories/book_repository_impl.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/event/book_event.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/state/book_state.dart';
import 'package:result_dart/result_dart.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository = BookBackendRepository();
  BookBloc() : super(EmptyBookState()) {
    on<GetBook>(_getListBooks);
    on<GetSearchBook>(_getSearchBooks);
    on<ReserveBook>(_reserveBook);
  }

  Future<void> _getListBooks(
    GetBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingListBooksState());
    Result<List<BookModel>, Exception> response =
        await _bookRepository.getAllBooks();

    response.fold((success) {
      emit(LoadedBookState(books: success));
    }, (failure) => emit(ErrorBookState()));
  }

  Future<void> _getSearchBooks(
    GetSearchBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingListBooksState());
    Result<List<BookModel>, Exception> response =
        await _bookRepository.getSearchBook(event.search);

    response.fold((success) {
      emit(LoadedBookState(books: success));
    }, (failure) => emit(ErrorBookState()));
  }

  Future<void> _reserveBook(
    ReserveBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingReservedBookState());
    Result<bool, Exception> response =
        await _bookRepository.reserveBook(event.bookId);

    response.fold((success) {
      emit(ReservedBookState());
    }, (failure) => emit(ErrorReservedBookState()));
  }
}
