import 'package:flutter/material.dart';



class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin; // Fungsi callback untuk login

  const LoginForm({Key? key, required this.onLogin}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key untuk form validasi

  // Fungsi untuk menampilkan pesan konfirmasi
  void _showConfirmationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  // Fungsi untuk validasi form dan login
  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      if (username == "admin" && password == "admin123") {
        widget.onLogin(username, password); // Panggil fungsi login dari parent
        _showConfirmationDialog('Login berhasil!'); // Tampilkan pesan sukses
      } else {
        _showConfirmationDialog(
            'Username atau password salah!'); // Tampilkan pesan kesalahan
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Silahkan masukkan username",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Silahkan masukkan password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                } else if (value.length < 6) {
                  return 'Password harus lebih dari 6 karakter';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: _validateAndLogin,
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
