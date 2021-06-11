import 'package:flutter/material.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:reportapp/views/Login/component/InputField.dart';
import 'package:reportapp/views/Login/component/InputFieldPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

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
//                          child: Image.asset(
//                            "assets/images/addinlogo.png",
//                            height: 130,
//                          ),
                        ),
                        SizedBox(
                          height: SpacingDimens.spacing88,
                        ),
                        InputField(
                          title: "Email",
                          controller: _usernameController,
                          type: TextInputType.text,
                          hint: "Masukkan Email",
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
                          height: SpacingDimens.spacing16,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: RichText(
                            text: TextSpan(
                              style: TypographyStyle.caption,
                              text: 'Belum Punya Akun? ',
                              children: [
                                TextSpan(
                                  text: 'Daftar',
                                  style: TypographyStyle.caption.merge(
                                    TextStyle(
                                      color: PaletteColor.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SpacingDimens.spacing88,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: PaletteColor.primary,
                          ),
                          onPressed: () {
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
