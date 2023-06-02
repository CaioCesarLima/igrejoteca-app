import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/prayers/data/models/testemonie_model.dart';

class TestemonialCardWidget extends StatelessWidget {
  final TestemonieModel testemonieModel;
  const TestemonialCardWidget({
    Key? key, required this.testemonieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                left: Consts.khorintalPading, top: 40),
            child: Icon(Icons.handshake, color: AppColors.primaryColor,),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(testemonieModel.owner, style: const TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 18
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 15),
                  child: Text(
                    testemonieModel.description,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
