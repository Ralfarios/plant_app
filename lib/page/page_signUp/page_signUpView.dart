import 'package:flutter/material.dart';
import 'package:plant_app/core/service/authenticator.dart';

import '../../core/consts/element/provider.dart';
import '../../core/consts/element/widget.dart';
import '../../core/consts/style/color.dart';

enum FieldType { signIn, signUp }

class PageSignUpView extends StatefulWidget {
  PageSignUpView({Key key, @required this.fieldType}) : super(key: key);

  final FieldType fieldType;

  @override
  _PageSignUpViewState createState() =>
      _PageSignUpViewState(fieldType: this.fieldType);
}

class _PageSignUpViewState extends State<PageSignUpView> {
  FieldType fieldType;
  _PageSignUpViewState({this.fieldType});

  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _conpassController = TextEditingController();

  String _email, _pass, _username, _error;
  bool _isHidePass = true;
  bool _isHideConPass = true;

  void _toggleShowPass() {
    setState(() {
      _isHidePass = !_isHidePass;
    });
  }

  void _toggleShowConPass() {
    setState(() {
      _isHideConPass = !_isHideConPass;
    });
  }

  void switchFormField(String state) {
    _formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        fieldType = FieldType.signUp;
      });
    } else {
      setState(() {
        fieldType = FieldType.signIn;
      });
    }
  }

  bool validate() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submitFormField() async {
    if (validate()) {
      try {
        final authenticator = Provider.of(context).authService;
        if (fieldType == FieldType.signIn) {
          String uID = await authenticator.signIn(_email, _pass);
          print("Signed in with ID $uID"); //DEBUG TEST: DELETE AFTERWARD
          Navigator.of(context).pushReplacementNamed("/landing");
        } else {
          String uID = await authenticator.signUp(_email, _pass, _username);
          print("Signed iup with ID $uID"); //DEBUG TEST: DELETE AFTERWARD
          Navigator.of(context).pushReplacementNamed("/landing");
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  Widget _showAlert() {
    if (_error != null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline, color: cRed),
            ),
            Expanded(
              child: Text(
                _error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: cRed,
                      fontSize: 12,
                    ),
                maxLines: 3,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: cRed,
                ),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                })
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _showAlert(),
            Form(
              key: _formKey,
              child: Column(
                children: buildInputs() + buildButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomAppBar(BuildContext context) {
    String _appBarText;
    if (fieldType == FieldType.signUp) {
      _appBarText = "Sign Up";
    } else {
      _appBarText = "Sign In";
    }

    return customAppBar(
      context,
      backArrow(context),
      withoutButton(context, _appBarText),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    //ADDITIONAL: Username

    if (fieldType == FieldType.signUp) {
      textFields.add(
        TextFormField(
          autofocus: false,
          validator: UserNameVal.validate,
          onSaved: (value) => _username = value.trim(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: cBlack),
          cursorColor: cGray,
          decoration: buildFormFieldInputDeco("Username", null),
        ),
      );
      textFields.add(
        SizedBox(
          height: 16.0,
        ),
      );
    }

    //COMMON: Email

    textFields.add(
      TextFormField(
        autofocus: false,
        validator: EmailVal.validate,
        onSaved: (value) => _email = value.trim(),
        style: Theme.of(context).textTheme.bodyText1.copyWith(color: cBlack),
        cursorColor: cGray,
        decoration: buildFormFieldInputDeco("Email", null),
      ),
    );

    //SPACE
    textFields.add(
      SizedBox(
        height: 16.0,
      ),
    );
    //SPACE

    //COMMON: Password

    textFields.add(
      TextFormField(
        obscureText: _isHidePass,
        controller: _passController,
        autofocus: false,
        validator: PasswordVal.validate,
        onSaved: (value) => _pass = value.trim(),
        style: Theme.of(context).textTheme.bodyText1.copyWith(color: cBlack),
        cursorColor: cGray,
        decoration: buildFormFieldInputDeco("Password", toggleShowPassIcon()),
      ),
    );

    //ADDITIONAL: Confirm Password

    if (fieldType == FieldType.signUp) {
      //SPACE
      textFields.add(
        SizedBox(
          height: 16.0,
        ),
      );
      //SPACE
      textFields.add(
        TextFormField(
          obscureText: _isHideConPass,
          controller: _conpassController,
          autofocus: false,
          validator: (value) {
            if (value.isEmpty) {
              return "Please retype your password";
            } else {
              if (value != _passController.text) {
                return "Password isn't match";
              }
            }
            return null;
          },
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: cBlack),
          cursorColor: cGray,
          decoration: buildFormFieldInputDeco(
              "Confirm Password", toggleShowConPassIcon()),
        ),
      );
    }

    return textFields;
  }

  Widget toggleShowPassIcon() {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        _toggleShowPass();
      },
      child: Icon(
        _isHidePass ? Icons.visibility : Icons.visibility_off,
        color: cGray,
      ),
    );
  }

  Widget toggleShowConPassIcon() {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        _toggleShowConPass();
      },
      child: Icon(
        _isHideConPass ? Icons.visibility : Icons.visibility_off,
        color: cGray,
      ),
    );
  }

  InputDecoration buildFormFieldInputDeco(String label, Widget child) {
    return InputDecoration(
      suffixIcon: child,
      contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      labelText: label,
      errorStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: cRed),
      labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: cGray),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cGray),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cGray),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: cRed),
      ),
    );
  }

  List<Widget> buildButtons() {
    String _fieldButtonType, _fieldButtonSubmit, _changeFieldType;

    if (fieldType == FieldType.signIn) {
      _fieldButtonType = "Don't have an account? Sign Up";
      _changeFieldType = "signUp";
      _fieldButtonSubmit = "Sign In";
    } else {
      _fieldButtonType = "Already have an account? Sign In";
      _changeFieldType = "signIn";
      _fieldButtonSubmit = "Sign Up";
    }

    return [
      //SPACE
      SizedBox(
        height: 32.0,
      ),
      //SPACE

      //BUTTON: Submit

      GradientButton(
        widthButton: 400.0,
        buttonLabel: _fieldButtonSubmit,
        press: submitFormField,
      ),

      //BUTTON: Switch

      Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: () {
            switchFormField(_changeFieldType);
          },
          child: Container(
            padding: EdgeInsets.all(2.0),
            child: Text(
              _fieldButtonType,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: cGray, decoration: TextDecoration.underline),
            ),
          ),
        ),
      ),
    ];
  }
}
