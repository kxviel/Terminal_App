import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HTTP {
  final String url;
  HTTP(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
  }
}
