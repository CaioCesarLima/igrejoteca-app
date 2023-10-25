import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key, this.clubId});
  final String? clubId;
  static const String route = '/club';
  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final bool participante = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBlueColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Nome do Livro"),
        ),
        drawer: const CustomDrawer(),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => GestureDetector(
            onTap: (() {}),
            child: const PostCard(),
          ),
        ),
        floatingActionButtonLocation: participante ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: participante
            ? FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : SizedBox(
              width: 150,
              child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {},
                  child: const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Participar", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),),
                  )),
                ),
            ));
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              "Nome do usuário",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
            child: Text(
              "Esse é meu comentário sobre o livro que eu queria compartilhar com todos vocês",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
