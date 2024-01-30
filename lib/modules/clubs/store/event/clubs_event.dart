abstract class ClubEvent{}


class GetClubsEvent extends ClubEvent{}

class GetUserClubsEvent extends ClubEvent{}

class GetBookClubsEvent extends ClubEvent{
  final String bookId;

  GetBookClubsEvent(this.bookId);
}