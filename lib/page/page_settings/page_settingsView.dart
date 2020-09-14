import 'package:flutter/material.dart';

import 'model/page_settingsModel.dart';
import '../../core/consts/element/widget.dart';

class PageSettingsView extends StatefulWidget {
  @override
  _PageSettingsViewState createState() => _PageSettingsViewState();
}

class _PageSettingsViewState extends State<PageSettingsView> {
  double divHeight = 48;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        backArrow(context),
        withoutButton(context, "Settings"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SetEmail(),
            ],
          ),
          Divider(height: divHeight),
          BudgetSlider(),
          MonthlySlider(),
          Divider(height: divHeight),
          NotifSwitch(),
          NewsSwitch(),
        ],
      ),
    );
  }
}
