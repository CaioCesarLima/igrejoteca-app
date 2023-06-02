import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});
  static const String route = '/clubs';
  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Club do Livro"),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text(
          "Em breve...",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300
          ),
        ),
      ),
    );
  }
}
