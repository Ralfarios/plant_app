import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import 'package:provider/provider.dart';

import 'page_settingsModelWidgets.dart';
import '../../../core/consts/style/color.dart';
import '../../../core/consts/style/theme.dart';
import '../../../core/service/authenticator.dart';

class SetEmail extends StatefulWidget {
  @override
  _SetEmailState createState() => _SetEmailState();
}

class _SetEmailState extends State<SetEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  Future<bool> _signOutAlert(context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text("Confirmation",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: cgGreenLeft)),
            content: Text(
                "Are you sure want to logout?\n\nWe hate to say good bye to you.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: cBlack)),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: cgGreenLeft, fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () async {
                  try {
                    AuthService authService = Provider.of(context).authService;
                    await authService.signOut(context);
                    print("Signed Out");
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Yes",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: cgGreenLeft, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    _user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelEmail(context, "Username"),
              Text("${_user?.displayName}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: cBlack, fontWeight: FontMedium)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelEmail(context, "Email"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${_user?.email}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: cBlack, fontWeight: FontMedium)),
                InkWell(
                  onTap: () {
                    _signOutAlert(context);
                  },
                  child: GradientText(
                    "Logout",
                    gradient: LinearGradient(
                      colors: [cgGreenLeft, cgGreenRight],
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontMedium),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class BudgetSlider extends StatefulWidget {
  @override
  _BudgetSliderState createState() => _BudgetSliderState();
}

class _BudgetSliderState extends State<BudgetSlider> {
  double sliderBudget = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("Budget",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: cDGray, fontWeight: FontRegular)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Slider(
            activeColor: cgGreenLeft,
            value: sliderBudget,
            min: 0,
            max: 1000,
            onChanged: (value) {
              setState(() {
                sliderBudget = value.roundToDouble();
              });
            },
            divisions: 10,
          ),
        ),
        Text(
          "\$ " + sliderBudget.toInt().toString(),
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: cDGray, fontWeight: FontRegular, fontSize: 12),
        ),
      ],
    );
  }
}

class MonthlySlider extends StatefulWidget {
  @override
  _MonthlySliderState createState() => _MonthlySliderState();
}

class _MonthlySliderState extends State<MonthlySlider> {
  double sliderMonthly = 1000;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("Monthly Cap",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: cDGray, fontWeight: FontRegular)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Slider(
            activeColor: cgGreenLeft,
            value: sliderMonthly,
            min: 1000,
            max: 10000,
            onChanged: (value) {
              setState(() {
                sliderMonthly = value.roundToDouble();
              });
            },
            divisions: 9,
          ),
        ),
        Text(
          "\$ " + sliderMonthly.toInt().toString(),
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: cDGray, fontWeight: FontRegular, fontSize: 12),
        ),
      ],
    );
  }
}

class NotifSwitch extends StatefulWidget {
  @override
  _NotifSwitchState createState() => _NotifSwitchState();
}

class _NotifSwitchState extends State<NotifSwitch> {
  bool _switchNotif = false;
  void _onChangeNotif(bool value) => setState(() {
        _switchNotif = value;
      });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Notification",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: cDGray, fontWeight: FontRegular),
        ),
        Switch(
          activeColor: cgGreenLeft,
          value: _switchNotif,
          onChanged: _onChangeNotif,
        ),
      ],
    );
  }
}

class NewsSwitch extends StatefulWidget {
  @override
  _NewsSwitchState createState() => _NewsSwitchState();
}

class _NewsSwitchState extends State<NewsSwitch> {
  bool _switchNews = false;
  void _onChangeNotif(bool value) => setState(() {
        _switchNews = value;
      });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "News",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: cDGray, fontWeight: FontRegular),
        ),
        Switch(
          activeColor: cgGreenLeft,
          value: _switchNews,
          onChanged: _onChangeNotif,
        ),
      ],
    );
  }
}
