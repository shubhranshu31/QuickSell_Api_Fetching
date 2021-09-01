import 'package:http/http.dart' as http;
import 'package:quicksell_android_task/models/api_model.dart';
import 'package:quicksell_android_task/utils/constants/string_constants.dart';

class ProductIdApi {
  Future<List<String>> getId() async {
    var client = http.Client();
    var url = Uri.parse(StringConstants.idApi);
    List<String> prodIds = [];
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        prodIds = productIdFromJson(jsonString);
        return prodIds;
      }
    } catch (e) {
      print("Error is ${e.toString()}");
    }
    return prodIds;
  }
}
