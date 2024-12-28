import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  String _role = ''; // Menyimpan role pengguna
  String _userName = ''; // Menyimpan nama pengguna

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get role => _role;
  String get userName => _userName;

  /// 🟢 **Login Method**
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Simpan token, role, dan nama pengguna
        await prefs.setString('token', responseData['token']);
        await prefs.setString('role', responseData['user']['role']);
        await prefs.setString('name', responseData['user']['name']);

        // Update state
        _role = responseData['user']['role'];
        _userName = responseData['user']['name'];
        notifyListeners();

        return true;
      } else {
        _errorMessage = responseData['message'] ?? 'Login gagal';
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = 'Terjadi kesalahan: $error';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🟢 **Register Method**
  Future<bool> register(String name, String email, String password,
      String confirmPassword) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = 'http://127.0.0.1:8000/api/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        }),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201) {
        _errorMessage = 'Pendaftaran berhasil. Silakan login.';
        notifyListeners();
        return true;
      } else {
        if (responseData.containsKey('message')) {
          _errorMessage = responseData['message'];
        } else if (responseData.containsKey('errors')) {
          _errorMessage = (responseData['errors'] as Map<String, dynamic>)
              .values
              .map((e) => e.join(', '))
              .join('\n');
        } else {
          _errorMessage = 'Pendaftaran gagal.';
        }
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = 'Terjadi kesalahan: $error';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🟢 **Logout Method**
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    const url = 'http://127.0.0.1:8000/api/logout';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.clear(); // Hapus semua data sesi
        _role = '';
        _userName = '';
        notifyListeners();
        return true;
      } else {
        throw Exception('Logout gagal');
      }
    } catch (error) {
      _errorMessage = 'Terjadi kesalahan: $error';
      notifyListeners();
      return false;
    }
  }

  /// 🟢 **Load User Session (Optional, saat aplikasi dijalankan ulang)**
  Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') ?? false) {
      _role = prefs.getString('role') ?? '';
      _userName = prefs.getString('name') ?? '';
      notifyListeners();
    }
  }
}
