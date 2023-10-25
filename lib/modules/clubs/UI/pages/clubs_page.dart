import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/modules/clubs/UI/pages/club_page.dart';
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          onTap: (() {
            Navigator.pushNamed(context, ClubPage.route);
          }),
          child: const ClubCard(),
        ),
      ),
    );
  }
}

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      // width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    "Nome do Clube",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 15, bottom: 15),
                  child: Text(
                    "Nome do livro",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 15, bottom: 10),
            child: Text(
              "Nome do usuário",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
