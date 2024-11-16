import 'dart:convert';

import 'package:flutterinventori/model/LoginModel.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String _baseUrl = 'http://192.168.100.17:8000/api/login';

  //function loginnya
  Future<LoginModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginModel.fromJson(data);
      } else {
        print('login failed : ${response.statusCode}');
        return null;
      }
    } catch (e) {
      //tambahkan di bagian catch
      print('Error during login : $e');
      return null;
    }
  }
}
