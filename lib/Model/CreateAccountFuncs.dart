import 'dart:convert';
import 'package:order_delievery/main.dart';
import 'package:http/http.dart' as http;

import '../View/create_account.dart';
class CreateAccountFuncs{
  static Future <void> dataEntry () async{

try{
  final response=await http.post(
    Uri.parse(back_url+"/api/dataEntry"),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String> {"first_name": controller.first_name,
          "last_name": controller.last_name,
          "location": controller.location,
          "card_number": controller.card_number,
          "profile_picture": controller.profile_picture.toString(),
          "email" :controller.email,
          'number': controller.number,
          'password' : controller.password
        }
    )

  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('create account Successfully: ${data['message']}');
    userData?.setString('token', data['token']);
  } else if (response.statusCode == 401) {
    final data = jsonDecode(response.body);
    print('Error: ${data['message']}');
  } else {
    print('Unexpected error: ${response.statusCode}');
  }
} catch (e) {
  print('Error: $e');
}
}
static Future<void> sendVerificationCode() async{
    try{
      final response= await http.post(
        Uri.parse(back_url+"/api/sendVerificationCode"),
        headers:<String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{
          'email':controller.email,
          'number':controller.number,
          'password':controller.password
        })
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('sent Successfully: ${data['message']}');
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        print('Error: ${data['message']}');
      } else {
        print('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

}
static Future<bool?> verifyCode(String code) async{
    try{
      final  response= await http.post(
        Uri.parse(back_url+"/api/verifyCode"),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body:jsonEncode(
            <String,String>{
          'email' :controller.email,
          'code' : code,
        })

      );
      if(response.statusCode==200)
        return true;
      else
        return false;
    }
    catch (e) {
      print('Error: $e');
    }
    return null;
}

}

