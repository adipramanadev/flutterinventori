import 'package:flutter/material.dart';
import 'package:flutterinventori/model/LoginModel.dart';
import 'package:flutterinventori/services/LoginService.dart';
import 'package:flutterinventori/views/homepage.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //variable deklarasi form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  //buat function
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true; //tampilkan indikator loading
    });

    final loginService = LoginService();
    final loginModel = await loginService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false; //hilangkan indikator loading
    });

    //jika login berhasil
    if (loginModel != null) {
      print('Login Succesful');
      print('Email : ${loginModel.user?.email}');
      print('Token : ${loginModel.token}');
      // navigasi ke homescreen
      //home
      Get.to(Homepage());
    } else {
      //jika gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed, Please Try Again')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 26.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        )),
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose(); 
    _passwordController.dispose();
    super.dispose();
  }
}
