import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quicksell_android_task/presentation/widgets/product_list_item.dart';
import 'package:quicksell_android_task/services/api_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late List<String> _idList;
  final _database = FirebaseDatabase.instance.reference();
  String name = 'null';
  String desc = 'null';
  String price = '-';
  String image = "https://picsum.photos/200/300?random=1";

  @override
  void initState() {
    getIds();
    super.initState();
  }

  void getIds() async {
    _idList = await ProductIdApi().getId();
  }

  String showName(String prodId) {
    _database.child('product-name/$prodId').onValue.listen((event) {
      setState(() {
        name = event.snapshot.value;
      });
    });
    return name;
  }

  String showDesc(String prodId) {
    _database.child('product-desc/$prodId').onValue.listen((event) {
      setState(() {
        desc = event.snapshot.value;
      });
    });
    return desc;
  }

  String showPrice(String prodId) {
    _database.child('product-price/$prodId').onValue.listen((event) {
      setState(() {
        price = event.snapshot.value.toString();
      });
    });
    return price;
  }

  String showImage(String prodId) {
    _database.child('product-image/$prodId').onValue.listen((event) {
      setState(() {
        image = event.snapshot.value;
      });
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "List Screen",
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ProductIdApi().getId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (_, idx) {
                  return productListTile(
                    height: height * 0.14,
                    width: width,
                    productName: showName(_idList[idx]),
                    productDesc: showDesc(_idList[idx]),
                    productPrice: showPrice(_idList[idx]),
                    productImg: showImage(_idList[idx]),
                  );
                },
                separatorBuilder: (_, idx) => Divider(),
                itemCount: _idList.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
