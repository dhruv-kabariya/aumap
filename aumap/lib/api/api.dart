import 'package:http/http.dart' as http;

class API {
  static String url = 'http://127.0.0.1:8000/';
  static Future<http.Response> getrequest(String geturl,
      {int id, String query}) async {
    return await http.get(Uri.parse(url + geturl));
  }
}
