import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/club_page.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/clubs_page.dart';
import 'package:igrejoteca_app/modules/clubs/data/models/club_model.dart';
import 'package:logger/logger.dart';

class ClubsRoutes {
  static const String clubs = ClubsPage.route;
  static const String club = ClubPage.route;

  static final Map<String, WidgetBuilder> routes = {
    clubs: (context) {
      final String? bookId = ModalRoute.of(context)!.settings.arguments as String ?;
      return ClubsPage(
        bookId: bookId,
      );
    },
    club: (context) {
      final club = ModalRoute.of(context)!.settings.arguments as ClubModel;
      return ClubPage(
        club: club,
      );
    },
  };
}
