import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

PreferredSize appBarAuth(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      backgroundColor: AppColors.lightBlueColor,
      centerTitle: true,
      title: Text(title),
    ),
  );
}
