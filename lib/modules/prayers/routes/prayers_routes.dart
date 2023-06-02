
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/prayers/UI/pages/prayers_page.dart';

class PrayersRoutes {
  static const String prayers = PrayersPage.route;

  static final Map<String, WidgetBuilder> routes = {
    prayers: (context) => const PrayersPage(),
  };
}