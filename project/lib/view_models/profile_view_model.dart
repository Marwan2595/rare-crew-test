import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rare_crew_test/models/user.dart';

import '../models/http_handler.dart';
import '../models/shared_pref.dart';

class ProfileViewModel {
  User user = User();

  getUser() async {
    HttpHandler httpHandler = HttpHandler();
    Uri url = Uri.parse(httpHandler.baseUrl + "users");
    String token = await getToken(type: TokenType.accessToken);
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if (response.statusCode == 200) {
      user = jsonDecode(response.body);
    } else {}
  }
}
