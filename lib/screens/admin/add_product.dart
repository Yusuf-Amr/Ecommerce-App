import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/services/store.dart';
import 'package:shopper/widgets/custom_elevated_button.dart';
import 'package:shopper/widgets/custom_text_form_field.dart';

//ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static String id = 'Add Product';
  String _productName,
      _productPrice,
      _productDescription,
      _productCategory,
      _productLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
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
              hintText: 'Product URL',
            ),
           
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              text: 'Add Product',
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                    pName: _productName,
                    pPrice: _productPrice,
                    pCategory: _productCategory,
                    pDescription: _productDescription,
                    pLocation: _productLocation,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
