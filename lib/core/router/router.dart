import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/modules/books/routes.dart';
import 'package:igrejoteca_app/modules/clubs/routes/clubs_routes.dart';
import 'package:igrejoteca_app/modules/emprestimos/routes/emprestimos_routes.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/initial_page.dart';
import 'package:igrejoteca_app/modules/login/routes/routes.dart';
import 'package:igrejoteca_app/modules/prayers/routes/prayers_routes.dart';
import 'package:igrejoteca_app/modules/quiz/routes/quiz_routes.dart';
import 'package:igrejoteca_app/modules/reservations/routes/reservation_routes.dart';
import 'package:logger/logger.dart';
class Router {
  final GetIt getIt;

  Router(this.getIt);

  String get initialRoute {
    return InitialPage.route;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      ...BookRoutes.routes,
      ...LoginRoutes.routes,
      ...ReservationRoutes.routes,
      ...EmprestimoRoutes.routes,
      ...PrayersRoutes.routes,
      ...QuizRoutes.routes,
      ...ClubsRoutes.routes
    };
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: (context) => builder(context), settings: settings);
    } else {
      // Tratar o caso em que a rota não foi encontrada.
      return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
