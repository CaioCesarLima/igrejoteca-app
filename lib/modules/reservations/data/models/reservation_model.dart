import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';

class ReservationModel {
  final String id;
  final BookModel book;

  ReservationModel({required this.id, required this.book});

  factory ReservationModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final BookModel book = BookModel.fromjson(json['book']);

    return ReservationModel(id: id, book: book);
  }
}