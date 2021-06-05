import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/provider/cart_item.dart';
import 'package:shopper/screens/user/cart_screen.dart';
import 'package:shopper/widgets/custom_text.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  double _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Container(
      child: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
                Image.network(product.pLocation),),
        Container(
          height: MediaQuery.of(context).size.height * 0.118,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(kPurpleColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    color: Color(kPurpleColor),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(children: [
            Opacity(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: product.pName,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: '\$${product.pPrice}',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: Color(kPurpleColor),
                                child: GestureDetector(
                                  onTap: subtract,
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: _quantity.toStringAsFixed(0),
                              fontSize: 30,
                              color: Color(kPurpleColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ClipOval(
                              child: Material(
                                color: Color(kPurpleColor),
                                child: GestureDetector(
                                  onTap: adding,
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: product.pDescription,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              opacity: 0.7,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    addToCart(context, product);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(kPurpleColor), onPrimary: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    child: CustomText(
                      text: 'Add to Cart',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    ));
  }

  void subtract() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  void adding() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    var productsInCart = cartItem.products;
    bool exist = false;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('you added this item before')));
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added to Cart')));
    }
  }
}
