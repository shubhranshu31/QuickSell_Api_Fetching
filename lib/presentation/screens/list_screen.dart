import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quicksell_android_task/models/product_model.dart';
import 'package:quicksell_android_task/presentation/widgets/product_list_item.dart';
import 'package:quicksell_android_task/services/api_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> _idList = [];
  // final _database = FirebaseDatabase.instance.reference();
  String name = 'null';
  String desc = 'null';
  String price = '-';
  String image = "https://picsum.photos/200/300?random=1";
  List<String> _data = [];
  bool loading = false, allLoaded = false;
  ScrollController _scrollController = ScrollController();
  int stVal = 0;

  @override
  void initState() {
    getIds();
    // paginatedFetch();
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent) {
    //     paginatedFetch();
    //   }
    // });
  }

  // paginatedFetch() {
  //   if (allLoaded) {
  //     return;
  //   }
  //   setState(() {
  //     loading = true;
  //   });
  //   if (_idList.isEmpty) print("Empty Api List");
  //   for (int i = 0; i < 20; i++) {
  //     _data.add(_idList[stVal + i]);
  //   }
  //   setState(() {
  //     loading = false;
  //     allLoaded = _data.isEmpty;
  //     stVal += 20;
  //   });
  // }

  void getIds() async {
    _idList = await ProductIdApi().getId();
  }

  // String showName(String prodId) {
  //   _database.child('product-name/$prodId').onValue.listen((event) {
  //     setState(() {
  //       name = event.snapshot.value;
  //     });
  //   });
  //   return name;
  // }

  // String showDesc(String prodId) {
  //   _database.child('product-desc/$prodId').onValue.listen((event) {
  //     setState(() {
  //       desc = event.snapshot.value;
  //     });
  //   });
  //   return desc;
  // }

  // String showPrice(String prodId) {
  //   _database.child('product-price/$prodId').onValue.listen((event) {
  //     setState(() {
  //       price = event.snapshot.value.toString();
  //     });
  //   });
  //   return price;
  // }

  // String showImage(String prodId) {
  //   _database.child('product-image/$prodId').onValue.listen((event) {
  //     setState(() {
  //       image = event.snapshot.value;
  //     });
  //   });
  //   return image;
  // }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "List Screen",
          ),
        ),
      ),

      body: LayoutBuilder(
        builder: (_, constrains) {
          if (_data.isNotEmpty) {
            return ListView.separated(
              controller: _scrollController,
              itemBuilder: (_, idx) {
                return ListTile(
                  title: Text(_data[idx]),
                );
              },
              separatorBuilder: (_, idx) => Divider(),
              itemCount: _data.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // body: SafeArea(
      //   child: FutureBuilder(
      //     future: ProductIdApi().getId(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return ListView.separated(
      //           padding: EdgeInsets.zero,
      //           itemBuilder: (_, idx) {
                  // return productListTile(
                  //   height: height * 0.14,
                  //   width: width,
                  //   productName: showName(_idList[idx]),
                  //   productDesc: showDesc(_idList[idx]),
                  //   productPrice: showPrice(_idList[idx]),
                  //   productImg: showImage(_idList[idx]),
                  // );
      //           },
      //           separatorBuilder: (_, idx) => Divider(),
      //           itemCount: 50,
      //         );
      //       } else {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
