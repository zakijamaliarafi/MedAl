import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medal/pages/reminder/add.dart';
import 'package:medal/pages/reminder/detail.dart';
import 'package:medal/services/auth_service.dart';
import 'package:medal/services/reminder_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengingat Obat', style: GoogleFonts.raleway()),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddReminder()),
              );
            }
          ),
        ],
      ),
      drawer: Drawer(
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
                // Navigate to Pengingat Obat
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Jadwal Kunjungan'),
              onTap: () {
                // Navigate to Jadwal Kunjungan
              },
            ),
            Spacer(),
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
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ReminderService().getUserRemindersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reminders found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var reminder = snapshot.data![index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailReminder(reminder: reminder),
                        ),
                      );
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reminder['times'].join(' / ')),
                            Text(reminder['waktuKonsumsi']),
                          ],
                        ),
                        Text(reminder['namaObat']),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}