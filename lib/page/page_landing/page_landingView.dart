import 'package:flutter/material.dart';

import '../../core/consts/element/provider.dart';
import '../../core/consts/element/widget.dart';
import '../../core/service/authenticator.dart';

class PageLandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context, null, withButton(context, "Browse", Icon(Icons.settings))),
      body: Center(
        child: Column(
          children: [
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
