import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rare_crew_test/models/user.dart';

import '../models/http_handler.dart';
import '../models/shared_pref.dart';

final profileProvider = Provider<ProfileViewModel>((ref) {
  return ProfileViewModel();
});

class ProfileViewModel {
  User user = User();
  final profileDataProvider = FutureProvider.autoDispose<User>((ref) async {
    final dataProvider = ref.read(profileProvider);
    final user = await dataProvider.getUser();
    return user;
  });
  HttpHandler httpHandler = HttpHandler();
  getUser() async {
    Uri url = Uri.parse(httpHandler.baseUrl + "user");
    String token = await getToken(type: TokenType.accessToken);
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode >= 400) {
      print("Access Token Expired");
      refreshAccessToken(getUser);
    } else {
      user = User.fromJson(jsonDecode(response.body));
      return user;
    }
  }

  void refreshAccessToken(Function callBackFunction) async {
    String refreshToken = await getToken(type: TokenType.refreshToken);
    Uri url = Uri.parse(httpHandler.baseUrl + "token");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "refreshToken": refreshToken,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      var tokens = jsonDecode(response.body);
      storeToken(type: TokenType.accessToken, token: tokens['accessToken']);
      storeToken(type: TokenType.refreshToken, token: tokens['refreshToken']);
      print("Access Token Refreshed");
      callBackFunction();
    } else {
      print("Invalid Refresh Token");
    }
  }
}
