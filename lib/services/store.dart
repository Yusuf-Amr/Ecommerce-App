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

  deleteProduct(documentId) {
    _fireStore.collection(kProductCollections).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _fireStore.collection(kProductCollections).doc(documentId).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentReference = _fireStore.collection(kOrders).doc();
    documentReference.set(data);
    for (var products in products) {
      documentReference.collection(kOrderDetails).doc().set({
        kProductName: products.pName,
        kProductLocation: products.pLocation,
        kProductPrice: products.pPrice,
        kProductQuantity: products.pQuantity
      });
    }
  }
}
