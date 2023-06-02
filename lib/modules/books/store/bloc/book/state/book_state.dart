

import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';

abstract class BookState {}

class LoadedBookState implements BookState {
  final List<BookModel> books;

  LoadedBookState({required this.books});
}

class LoadingListBooksState implements BookState {}

class ErrorBookState implements BookState {}

class ReservedBookState implements BookState {}

class ErrorReservedBookState implements BookState {}
class LoadingReservedBookState implements BookState {}

class EmptyBookState implements BookState {}



