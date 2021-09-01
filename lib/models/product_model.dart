import 'package:firebase_database/firebase_database.dart';

class ProductModel {
  String? productName;
  String? productPrice;
  String? productImage;
  String? productDes;

  ProductModel(
    this.productName,
    this.productPrice,
    this.productImage,
    this.productDes,
  );

  ProductModel.fromSnapshot(DataSnapshot snap) {
    productName = snap.value['name'];
    productPrice = snap.value['price'];
    productImage = snap.value['image'];
    productDes = snap.value['desc'];
  }
}
