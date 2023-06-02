
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/emprestimos/UI/pages/emprestimos_page.dart';

class EmprestimoRoutes {
  static const String emprestimo = EmprestimosPage.route;

  static final Map<String, WidgetBuilder> routes = {
    emprestimo: (context) => const EmprestimosPage(),
  };
}