import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/provider/modal_hud.dart';
import 'package:shopper/screens/admin_page.dart';
import 'package:shopper/screens/home_page.dart';
import 'package:shopper/screens/register_screen.dart';
import 'package:shopper/widgets/custom_elevated_button.dart';
import 'package:shopper/widgets/custom_text.dart';
import 'package:shopper/widgets/custom_text_form_field.dart';
import 'package:shopper/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'Loginscreen';
  String _email, _password;
  final _auth = Auth();
  final adminEmail = 'admin@gmail.com';
  final adminPassword = 'admin123';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              color: Color(kPurpleColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 36, horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: "ShopLovers",
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: 'EagleLake'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                              text: "Enter a beautiful world",
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'EagleLake'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              onClick: (value) {
                                _email = value;
                              },
                              hintText: 'Email',
                              iconType: Icons.email,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              onClick: (value) {
                                _password = value;
                              },
                              obsecureText: true,
                              hintText: 'Password',
                              iconType: Icons.lock,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: 'Forgot password?',
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Builder(
                              builder: (context) => CustomElevatedButton(
                                onPressed: () {
                                  _validate(context);
                                },
                                text: 'Login',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                CustomText(text: 'Don\'t have an account?'),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RegisterScreen.id);
                                  },
                                  child: Text('Let\'s Register',
                                      style: TextStyle(
                                          color: Color(kPurpleColor),
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ],
                            ),
                          ],
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
    );
  }

  void _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context, listen: false);
    modalHud.changeIsLoading(true);

    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      try {
        if (_email == adminEmail && _password == adminPassword) {
          await _auth.login(_email, _password);
          Navigator.pushNamed(context, AdminPage.id);
        } else {
          await _auth.login(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        }
      } on FirebaseAuthException catch (error) {
        modalHud.changeIsLoading(false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
    modalHud.changeIsLoading(false);
  }
}
