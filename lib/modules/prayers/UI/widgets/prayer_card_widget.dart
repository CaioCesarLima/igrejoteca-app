import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/prayers/data/models/prayer_model.dart';

class PrayerCardWidget extends StatelessWidget {
  final PrayerModel prayerModel;
  const PrayerCardWidget({
    Key? key, required this.prayerModel,
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
                  child: Text(prayerModel.isAnonymous ? "Anônimo" : prayerModel.owner, style: const TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 18
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 15),
                  child: Text(
                    prayerModel.description,
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
