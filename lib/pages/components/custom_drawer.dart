import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medal/pages/home/home.dart';
import 'package:medal/services/auth_service.dart';
import 'package:medal/pages/calculator/calculator_list.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: Text(
                FirebaseAuth.instance.currentUser?.email?.substring(0, 1) ?? '',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Pengingat Obat'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()));
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Jadwal Kunjungan'),
            onTap: () {
              // Navigate to Jadwal Kunjungan
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: Text('Kalkulator Tubuh'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CalculatorList()));
            },
          ),
          // Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Logout action
              await AuthService().signout(context: context);
            },
          ),
        ],
      ),
    );
  }
}
