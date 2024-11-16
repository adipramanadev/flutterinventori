import 'package:flutter/material.dart';
import 'package:flutterinventori/services/LoginService.dart';
import 'package:flutterinventori/views/homepage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variable deklarasi form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Fungsi untuk memeriksa status login
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Token retrieved: $token'); // Debug log
    if (token != null) {
      // Token ada, pengguna sudah login
      _navigateToHome();
    } else {
      // Token tidak ada, pengguna belum login
      print('gagal ke home');
    }
  }

  // Fungsi untuk menyimpan token setelah login berhasil
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved: $token'); // Debug log
  }

  // Fungsi untuk navigasi ke halaman home
  void _navigateToHome() {
    print('Navigating to homepage');
    Get.off(() => Homepage());
  }

  // handleLogin
  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email dan password tidak boleh kosong.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final loginService = LoginService(); // Buat instance LoginService
    final loginModel =
        await loginService.login(email, password); // Panggil metode login

    setState(() {
      _isLoading = false;
    });

    if (loginModel != null) {
      print('Login Succesfully');
      await _saveToken(loginModel.token!);
      _navigateToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email atau password salah.')),
      );
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
                const SizedBox(height: 100),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                  ),
                ),
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
