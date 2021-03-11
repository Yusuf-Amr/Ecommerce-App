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
                  onClick: (value) {
                    _productName = value;
                  },
                  hintText: 'Product Name',
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  onClick: (value) {
                    _productPrice = value;
                  },
                  hintText: 'Product Price',
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  onClick: (value) {
                    _productDescription = value;
                  },
                  hintText: 'Product Description',
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  onClick: (value) {
                    _productCategory = value;
                  },
                  hintText: 'Product Category',
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  onClick: (value) {
                    _productLocation = value;
                  },
                  hintText: 'Product Location',
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
