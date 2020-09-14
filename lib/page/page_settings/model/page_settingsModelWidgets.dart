import 'package:flutter/material.dart';
import '../../../core/consts/style/color.dart';
import '../../../core/consts/style/theme.dart';

Widget labelEmail(context, label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      label,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          .copyWith(color: cDGray, fontWeight: FontRegular),
    ),
  );
}
