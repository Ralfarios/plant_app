import 'package:flutter/material.dart';

import '../../core/consts/element/provider.dart';
import '../../core/consts/element/widget.dart';
import '../../core/service/authenticator.dart';

class PageLandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body: Center(
        child: Column(
          children: [
            Text("This is PageLandingView",
                style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 32),
            RaisedButton(
              onPressed: () async {
                try {
                  AuthService authService = Provider.of(context).authService;
                  await authService.signOut(context);
                  print("Signed Out");
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Sign Out",
              ),
            )
          ],
        ),
      ),
    );
  }
}
