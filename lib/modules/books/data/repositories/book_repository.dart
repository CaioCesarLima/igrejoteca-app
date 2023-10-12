import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class BookRepository{
  Future<Result<List<BookModel>, Exception>> getAllBooks();
  Future<Result<List<BookModel>, Exception>> getSearchBook(String search);
  Future<Result<bool, Exception>> reserveBook(String bookId);
}