import 'package:flutter/material.dart';
import 'mvc/PoliPage.dart';
import 'main.dart';


class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu Sidebar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Data Poli'),
            onTap: () {
              // Tambahkan navigasi ke halaman profil atau logika lain
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PoliPage())); // Tutup drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Tambahkan navigasi ke halaman pengaturan atau logika lain
              Navigator.pop(context); // Tutup drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
              // Tutup drawer
            },
          ),
        ],
      ),
    );
  }
}
