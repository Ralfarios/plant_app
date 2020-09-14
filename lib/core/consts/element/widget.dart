import 'package:flutter/material.dart';

import '../style/color.dart';
import '../path/image.dart' as images;

//WIDGET: Default App Bar

Widget defaultAppBar(BuildContext context, Widget itemApp) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    brightness: Brightness.light,
    flexibleSpace: itemApp,
  );
}

//WIDGET: Custom App Bar

Widget customAppBar(BuildContext context, Widget itemApp) {
  return PreferredSize(
    preferredSize: Size.fromHeight(120),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
          leading: Container(
            margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                customBorder: CircleBorder(),
                child: Image(image: images.icBackArrow),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        itemApp,
      ],
    ),
  );
}

Widget withButton(context, string, icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 13),
        child: Text(string, style: Theme.of(context).textTheme.headline1),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(20, 20, 30, 13),
        child: InkWell(
          customBorder: CircleBorder(),
          child: icon,
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ),
    ],
  );
}

Widget withoutButton(context, string) {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 20, 30, 13),
    child: Text(
      string,
      style: Theme.of(context).textTheme.headline1,
    ),
  );
}

//CLASS: Gradient Button

class GradientButton extends StatelessWidget {
  final Function press;
  final double widthButton;
  final String buttonLabel;
  const GradientButton(
      {Key key, this.press, this.widthButton, this.buttonLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          child: RaisedButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: press,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cgGreenLeft, cgGreenRight],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: widthButton, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  buttonLabel,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
