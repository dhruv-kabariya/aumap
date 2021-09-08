import 'package:http/http.dart' as http;

class API {
  static String url = 'http://127.0.0.1:8000/';
  static Future<http.Response> getrequest(String geturl,
      {int id, String query}) async {
    return await http
        .get(Uri.parse(url + geturl), headers: {"Accept": "application/json"});
  }

  static Future<http.Response> postrequest(String geturl, String body,
      {int id, String query}) async {
    // String data = jsonEncode(body);
    return await http
        .post(Uri.parse(url + geturl),
            headers: {
              "Accept": "application/json",
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: body)
        .then((value) {
      return value;
    });
  }
}
