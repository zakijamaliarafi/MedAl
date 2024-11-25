import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medal/pages/reminder/add.dart';
import 'package:medal/services/auth_service.dart';

class CalculatorBmi extends StatefulWidget {
  const CalculatorBmi({super.key});

  @override
  _CalculatorBmiState createState() => _CalculatorBmiState();
}

class _CalculatorBmiState extends State<CalculatorBmi> {
  final _tinggiBadanTextboxController = TextEditingController();
  final _beratBadanTextboxController = TextEditingController();

  double? _hasilBmi;

  void _hitungBmi() {
    final tinggi = double.tryParse(_tinggiBadanTextboxController.text);
    final berat = double.tryParse(_beratBadanTextboxController.text);

    if (tinggi != null && berat != null) {
      // Menghitung BMI
      final tinggiMeter = tinggi / 100; // Konversi tinggi ke meter
      final bmi = berat / (tinggiMeter * tinggiMeter);

      // Set hasil BMI
      setState(() {
        _hasilBmi = bmi;
      });
    } else {
      // Jika input tidak valid
      setState(() {
        _hasilBmi = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukkan nilai tinggi dan berat badan yang valid!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "Body Mass Index (BMI)",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _tinggiBadanTextField(),
            SizedBox(
              height: 12,
            ),
            _beratBadanTextField(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _hitungBmi,
              child: Text("Hitung BMI"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0077B6),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_hasilBmi != null)
              Text(
                "Hasil BMI Anda: ${_hasilBmi!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tinggiBadanTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tinggi Badan",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Radius border
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _tinggiBadanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tinggi badan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _beratBadanTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Berat Badan",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Radius border
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _beratBadanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Berat badan harus diisi";
        }
        return null;
      },
    );
  }
}
