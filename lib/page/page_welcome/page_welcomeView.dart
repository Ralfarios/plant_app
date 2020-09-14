import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

import '../../core/consts/element/widget.dart';
import '../../core/consts/path/image.dart' as images;
import '../../core/consts/style/color.dart';

class PageWelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FINAL

    final _size = MediaQuery.of(context).size;

    //CONTENT

    return Scaffold(
      appBar: defaultAppBar(context, null),
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Your Home. ",
                            style: Theme.of(context).textTheme.headline1),
                        GradientText(
                          "Greener",
                          gradient: LinearGradient(
                            colors: [cgGreenLeft, cgGreenRight],
                          ),
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Center(
                        child: Text("Enjoy the experience.",
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _size.height * 0.025,
                ),
                Image(
                  image: images.imWelcomeIllust,
                  height: _size.height * 0.475,
                ),
                SizedBox(
                  height: _size.height * 0.025,
                ),
                Column(
                  children: [
                    //SIGN IN

                    GradientButton(
                        widthButton: 300.0,
                        buttonLabel: "Sign In",
                        press: () {
                          Navigator.pushNamed(context, "/signIn");
                        }),

                    //SIGN UP

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: 300,
                        height: 50.0,
                        child: RaisedButton(
                          elevation: 0.5,
                          highlightElevation: 1,
                          onPressed: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Text("Sign Up",
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: "Greener",
                            applicationLegalese:
                                "EXAMPLE OF [Term of service] PAGE \n\nCoded by Muamar Al Farabi \nDesigned by Paolo Spazzini",
                            applicationVersion: "1.0.0",
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          child: Text("Term of service",
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//CLASS: ANIMATION - Fade In

class FadeInAnime extends StatefulWidget {
  final Widget child;

  FadeInAnime({@required this.child});

  @override
  _FadeInAnimeState createState() => _FadeInAnimeState();
}

class _FadeInAnimeState extends State<FadeInAnime>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _opacity;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 3),
    );
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
