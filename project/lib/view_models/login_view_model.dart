import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rare_crew_test/models/http_handler.dart';

import '../models/shared_pref.dart';

class LoginViewModel {
  login({required String username, required String password}) async {
    HttpHandler httpHandler = HttpHandler();
    Uri url = Uri.parse(httpHandler.baseUrl + "login");
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      var tokens = jsonDecode(response.body);
      storeToken(type: TokenType.accessToken, token: tokens['accessToken']);
      storeToken(type: TokenType.refreshToken, token: tokens['refreshToken']);
      return true;
    } else {
      removeToken(type: TokenType.accessToken);
      removeToken(type: TokenType.refreshToken);
      return false;
    }
  }
}
