import 'package:http/http.dart' as http;

class HTTP {
  final String url;
  HTTP(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    return response.body;
  }
}
