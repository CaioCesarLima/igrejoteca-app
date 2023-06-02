
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/reservations/UI/pages/reservation_page.dart';

class ReservationRoutes {
  static const String reservation = ReservatiionPage.route;

  static final Map<String, WidgetBuilder> routes = {
    reservation: (context) => const ReservatiionPage(),
  };
}