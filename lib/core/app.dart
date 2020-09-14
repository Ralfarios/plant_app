import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'consts/element/provider.dart';
import 'consts/style/theme.dart';
import 'service/authenticator.dart';

import '../page/page_landing/page_landingView.dart';
import '../page/page_signUp/page_signUpView.dart';
import '../page/page_welcome/page_welcomeView.dart';

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Provider(
      authService: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: tLightGreener,
        title: "Greener",
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (context) => PageSignUpView(fieldType: FieldType.signUp),
          '/signIn': (context) => PageSignUpView(fieldType: FieldType.signIn),
          '/landing': (context) => HomeController(),
          '/landhome': (context) => PageLandingView(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of(context).authService;
    return StreamBuilder(
      stream: authService.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? PageLandingView() : PageWelcomeView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
