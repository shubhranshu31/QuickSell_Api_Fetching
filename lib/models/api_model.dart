import 'dart:convert';

List<String> productIdFromJson(String str) => List<String>.from(
      json.decode(str).map((x) => x));

// String productIdToJson(List<String> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x)));
