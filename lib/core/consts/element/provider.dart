import 'package:flutter/material.dart';

import '../../service/authenticator.dart';

class Provider extends InheritedWidget {
  final AuthService authService;
  Provider({Key key, Widget child, this.authService})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}
