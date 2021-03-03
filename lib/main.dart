import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopper/provider/model_hud.dart';
import 'package:shopper/screens/login_screen.dart';
import 'package:shopper/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelHud>(
      create: (context) => ModelHud(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen()
        },
      ),
    );
  }
}
