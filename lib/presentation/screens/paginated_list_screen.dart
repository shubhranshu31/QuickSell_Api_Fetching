import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quicksell_android_task/models/api_model.dart';
import 'package:quicksell_android_task/presentation/widgets/product_list_item.dart';
import 'package:quicksell_android_task/utils/constants/string_constants.dart';

class PaginatedListScreen extends StatefulWidget {
  const PaginatedListScreen({Key? key}) : super(key: key);

  @override
  _PaginatedListScreenState createState() => _PaginatedListScreenState();
}

class _PaginatedListScreenState extends State<PaginatedListScreen> {
  List<String> apiList = [];
  List<String> paginatedList = [];
  ScrollController _scrollController = ScrollController();
  int stVal = 0;
  bool isLoading = false;

  String name = 'null';
  String desc = 'null';
  String price = '-';
  String image = "https://picsum.photos/200/300?random=1";

  final _database = FirebaseDatabase.instance.reference();

  fetchId() async {
    final response = await http.get(Uri.parse(StringConstants.idApi));
    if (response.statusCode == 200) {
      setState(() {
        apiList = productIdFromJson(response.body);
      });
    } else {
      apiList = [];
    }
    fetchPaginatedItem();
  }

  fetchPaginatedItem() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      for (int i = 0; i < 20; i++) {
        paginatedList.add(apiList[i + stVal]);
      }
      stVal += 20;
    });
    setState(() {
      isLoading = false;
    });
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
  void initState() {
    fetchId();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchPaginatedItem();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: LayoutBuilder(
        builder: (_, constrains) {
          if (paginatedList.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemBuilder: (_, idx) {
                    return productListTile(
                    height: height * 0.14,
                    width: width,
                    productName: showName(paginatedList[idx]),
                    productDesc: showDesc(paginatedList[idx]),
                    productPrice: showPrice(paginatedList[idx]),
                    productImg: showImage(paginatedList[idx]),
                  );
                  },
                  separatorBuilder: (_, idx) => Divider(
                    thickness: 2,
                  ),
                  itemCount: paginatedList.length,
                ),
                if (isLoading) ...[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 80,
                      width: constrains.maxWidth,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ]
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
