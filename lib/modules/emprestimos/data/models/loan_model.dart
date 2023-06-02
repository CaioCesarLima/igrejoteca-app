
import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';

class LoanModel {
  final String id;
  final BookModel book;
  final bool returned;
  final DateTime loanDay;

  LoanModel({required this.id, required this.book, required this.returned, required this.loanDay});

  factory LoanModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final bool returned = json['returned'];
    final DateTime loanDay= DateTime.parse(json['loan_day']);
    final BookModel book = BookModel.fromjson(json['book']);

    return LoanModel(id: id, book: book, returned: returned, loanDay: loanDay);
  }

  bool isLoanExpired() {
  const fifteenDays = Duration(days: 15);
  final now = DateTime.now();
  final loanExpirationDate = loanDay.add(fifteenDays);
  return loanExpirationDate.isBefore(now);
}
}