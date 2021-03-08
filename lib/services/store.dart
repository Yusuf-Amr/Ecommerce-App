import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _fireStore.collection(kProductCollections).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _fireStore.collection(kProductCollections).snapshots();
  }
}
