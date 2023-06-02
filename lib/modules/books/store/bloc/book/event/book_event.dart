
abstract class BookEvent {}

class GetBook implements BookEvent {
  final String token;

  GetBook({required this.token});
}


class ReserveBook implements BookEvent {
  final String bookId;

  ReserveBook(this.bookId);
}


