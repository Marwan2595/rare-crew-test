import 'package:shared_preferences/shared_preferences.dart';

enum TokenType {
  accessToken,
  refreshToken,
}

storeToken({required TokenType type, required String token}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(type.toString(), token);
}

getToken({required TokenType type}) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString(type.toString());
  return token;
}

removeToken({required TokenType type}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(type.toString());
}

Future<bool> checkToken({required TokenType type}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(type.toString());
}
