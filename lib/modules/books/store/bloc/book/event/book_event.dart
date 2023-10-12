
abstract class BookEvent {}

class GetBook implements BookEvent {
  final String token;

  GetBook({required this.token});
}

class GetSearchBook implements BookEvent {
  final String search;

  GetSearchBook({required this.search});
}

class ReserveBook implements BookEvent {
  final String bookId;

  ReserveBook(this.bookId);
}


