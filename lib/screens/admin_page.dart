import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/add_product.dart';
import 'package:shopper/screens/edit_product.dart';
import 'package:shopper/widgets/custom_elevated_button.dart';

class AdminPage extends StatelessWidget {
  static String id = 'AdminPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              text: 'Add Prodect',
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProduct.id);
                },
                text: 'Edit Product'),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(onPressed: () {}, text: 'View Orders'),
          ],
        ),
      ),
    );
  }
}
