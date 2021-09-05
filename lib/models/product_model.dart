import 'package:firebase_database/firebase_database.dart';

class PriceModel {
  // String? productName;
  String? productPrice;
  // String? productImage;
  // String? productDes;

  PriceModel({
    // this.productName,
    this.productPrice,
    // this.productImage,
    // this.productDes,
  });

  factory PriceModel.fromRTDB(Map<String, dynamic> data) {
    return PriceModel(
      // productName: data['name'] ?? 'null',
      productPrice: data['price'] ?? '-',
      // productImage: data['image'] ?? 'https://picsum.photos/200/300?random=1',
      // productDes: data['desc'] ?? 'null',
    );
  }
}
