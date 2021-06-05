
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/screens/user/productinfo.dart';
import 'package:shopper/services/functions/get_product_bycategory.dart';

Widget productView(String pCategory, List<Product> allProducts) {
  List<Product> products = [];
  products = getProductByCategory(pCategory, allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.8),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
        },
        child: Stack(children: [
          Positioned.fill(
            child: Image.network(products[index].pLocation),),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.6,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (products[index].pName),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(('\$ ${products[index].pPrice}')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
    itemCount: products.length,
  );
}
