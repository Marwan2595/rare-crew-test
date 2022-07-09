import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHandler {
  String baseUrl = 'http://10.0.2.2:3000/';

  login({required String username, required String password}) async {
    Uri url = Uri.parse(baseUrl + "login");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    print('Response body: ${response.body}');
  }
}
