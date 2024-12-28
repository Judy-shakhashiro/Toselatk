import 'package:http/http.dart' as http;
import 'package:order_delievery/main.dart';
import 'dart:convert';

 class LoginFuncs{

  static Future<void> login(String number, String password) async {

    try {

      final response = await http.post(
        Uri.parse(back_url+"/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'number': number,
          'password' : password
        }),
       );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login Successful: ${data['message']}');
        userData?.setString('token', data['token']);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        print('Error: ${data['message']}');
      } else {
        final data = jsonDecode(response.body);
        print('Unexpected error: ${response.statusCode}');
        print('message: ${data['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static Future<void> logout(String token) async {

     String apiUrl = back_url+"/api/logout";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers:<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userData?.remove('token');
        print('Logout Successful: ${data['message']}');
      } else {
        print('Error: ${response.statusCode}  ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}