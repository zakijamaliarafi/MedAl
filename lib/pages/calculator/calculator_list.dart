import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medal/pages/components/custom_drawer.dart';
import 'package:medal/pages/reminder/add.dart';
import 'package:medal/services/auth_service.dart';
import 'package:medal/pages/calculator/calculator_bmi.dart';

class CalculatorList extends StatelessWidget {
  const CalculatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Kalkulator Tubuh', style: GoogleFonts.raleway()),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddReminder()),
                );
              }),
        ],
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 100,
        child: Container(
          height: 60, // Tinggi bar
          alignment: Alignment.center,
          child: Text(
            'Bottom App Bar',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "Kalkulator Tubuh",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorBmi()),
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                height: 60,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFCAF0F8),
                ),
                child: Text(
                  "Body Mass Index (BMI)",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF03045E),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorBmi()),
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                height: 60,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFCAF0F8),
                ),
                child: Text(
                  "Body Mass Index (BMI)",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF03045E),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorBmi()),
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                height: 60,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFCAF0F8),
                ),
                child: Text(
                  "Body Mass Index (BMI)",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF03045E),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorBmi()),
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                height: 60,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFCAF0F8),
                ),
                child: Text(
                  "Body Mass Index (BMI)",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF03045E),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
