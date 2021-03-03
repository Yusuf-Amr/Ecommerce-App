import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopper/provider/model_hud.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              color: Color(0xFF141414),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "Shoppers",
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
                                onPressed: () async {
                                  final modelHud = Provider.of<ModelHud>(
                                      context,
                                      listen: false);
                                  modelHud.changeIsLoading(true);

                                  if (_globalKey.currentState.validate()) {
                                    _globalKey.currentState.save();
                                    try {
                                      final result =
                                          await _auth.login(_email, _password);
                                      modelHud.changeIsLoading(false);

                                      Navigator.pushNamed(
                                          context, LoginScreen.id);
                                    } on FirebaseAuthException catch (e) {
                                      modelHud.changeIsLoading(false);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.message)));
                                    }
                                  }
                                  modelHud.changeIsLoading(false);
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
}
