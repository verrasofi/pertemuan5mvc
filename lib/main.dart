import 'package:flutter/material.dart';
import 'loginform.dart';
import 'sidebar.dart';

//ditambahkan jika sudah masuk mvc
import 'package:provider/provider.dart';
import 'mvc/PoliController.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PoliController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: LoginPage(), // Halaman pertama adalah halaman login
    );
  }
}

// Halaman Login
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(
          onLogin: (username, password) {
            // Jika login berhasil, pindah ke halaman beranda
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(username: username)),
            );
          },
        ),
      ),
    );
  }
}

// Halaman Beranda setelah login berhasil
class HomePage extends StatelessWidget {
  final String username; // Username yang didapat dari login

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
      ),
      drawer: Sidebar(),
      body: Center(
        child: Text(
          'Selamat datang, $username!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
