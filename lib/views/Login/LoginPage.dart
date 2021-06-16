import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Animation/RightToLeftTransition.dart';
import 'package:reportapp/config/globalKeySharedPref.dart';
import 'package:reportapp/model/Login.dart';
import 'package:reportapp/provider/AuthProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:reportapp/views/Dashboard/DashboardPage.dart';
import 'package:reportapp/views/Login/component/InputField.dart';
import 'package:reportapp/views/Login/component/InputFieldPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _load = false;

  loadOn() => setState(() => _load = true);

  loadOff() => setState(() => _load = false);

  navigateTo(context, target) {
    Navigator.of(context).pushReplacement(
      rightToLeftTransition(target),
    );
  }

  sendLogin(BuildContext context) async {
    loadOn();
    int statusCode = await Provider.of<AuthProvider>(context, listen: false)
        .postLogin(_usernameController.text, _passwordController.text);
    if (statusCode == 200) {
      Login loginResponse =
          Provider.of<AuthProvider>(context, listen: false).loginResponse;
      savePrefData(loginResponse);
      navigateTo(
        context,
        DasboardPage(),
      );
    } else {
      loadOff();
      showSnackbar('Login Gagal');
    }
  }

  Future savePrefData(Login responseLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(GlobalKeySharedPref.statusLogin, true);
    preferences.setString(GlobalKeySharedPref.token, responseLogin.message);
    preferences.setString(GlobalKeySharedPref.idUser, responseLogin.data.idUser);

  }

  void showSnackbar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: SpacingDimens.spacing24,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 130,
                          ),
                        ),
                        SizedBox(
                          height: SpacingDimens.spacing88,
                        ),
                        InputField(
                          title: "Username",
                          controller: _usernameController,
                          type: TextInputType.text,
                          hint: "Masukkan Username",
                        ),
                        SizedBox(
                          height: SpacingDimens.spacing36,
                        ),
                        InputFieldPassword(
                          title: 'Password',
                          hint: 'Masukkan Password',
                          controller: _passwordController,
                        ),

                        SizedBox(
                          height: SpacingDimens.spacing88,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: PaletteColor.primary,
                          ),
                          onPressed: () {
                            sendLogin(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: SpacingDimens.spacing48,
                            child: Text(
                              'Masuk',
                              style: TypographyStyle.subtitle1.merge(
                                TextStyle(
                                  color: PaletteColor.primarybg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
