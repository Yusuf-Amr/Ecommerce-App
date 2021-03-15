import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopper/provider/modal_hud.dart';
import 'package:shopper/screens/admin/add_product.dart';
import 'package:shopper/screens/admin/admin_page.dart';
import 'package:shopper/screens/admin/edit_product.dart';
import 'package:shopper/screens/admin/manage_product.dart';
import 'package:shopper/screens/user/home_page.dart';
import 'package:shopper/screens/login_screen.dart';
import 'package:shopper/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shopper/screens/user/productinfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (context) => ModalHud(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          AdminPage.id: (context) => AdminPage(),
          HomePage.id: (context) => HomePage(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          ProductInfo.id: (context) => ProductInfo(),
        },
      ),
    );
  }
}
