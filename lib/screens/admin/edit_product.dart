import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/services/store.dart';
import 'package:shopper/widgets/custom_elevated_button.dart';
import 'package:shopper/widgets/custom_text_form_field.dart';

class EditProduct extends StatelessWidget {
  static String id = 'editProduct';
  String _productName,
      _productPrice,
      _productDescription,
      _productCategory,
      _productLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  initialValue: product.pName,
                  onClick: (value) {
                    _productName = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  initialValue: product.pPrice,
                  onClick: (value) {
                    _productPrice = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  initialValue: product.pDescription,
                  onClick: (value) {
                    _productDescription = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  initialValue: product.pCategory,
                  onClick: (value) {
                    _productCategory = value;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  initialValue: product.pLocation,
                  onClick: (value) {
                    _productLocation = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  text: 'Edit Product',
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();

                      _store.editProduct(
                          ({
                            kProductName: _productName,
                            kProductPrice: _productPrice,
                            kProductDescription: _productDescription,
                            kProductCategory: _productCategory,
                            kProductLocation: _productLocation,
                          }),
                          product.pId);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
