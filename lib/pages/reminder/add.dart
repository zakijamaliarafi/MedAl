import 'package:flutter/material.dart';
import 'package:medal/services/reminder_service.dart'; // Update with your actual project name

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  String _namaObat = '';
  String _waktuKonsumsi = 'sebelum makan';
  int _konsumsiPerHari = 1;
  List<TextEditingController> _timeControllers = [
    TextEditingController(text: '08:00')
  ];
  final TextEditingController _keteranganController = TextEditingController();
  final ReminderService _reminderService = ReminderService();

  @override
  void dispose() {
    for (var controller in _timeControllers) {
      controller.dispose();
    }
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _reminderService.addReminder(
          namaObat: _namaObat,
          waktuKonsumsi: _waktuKonsumsi,
          konsumsiPerHari: _konsumsiPerHari,
          times: _timeControllers.map((controller) => controller.text).toList(),
          keterangan: _keteranganController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reminder added successfully')),
        );
        Navigator.of(context).pop(); // Navigate back to the home screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add reminder: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengingat Obat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Obat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Obat tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _namaObat = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Waktu Konsumsi'),
                value: _waktuKonsumsi,
                items: ['sebelum makan', 'sesudah makan']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _waktuKonsumsi = value!;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Konsumsi per Hari'),
                value: _konsumsiPerHari,
                items: [1, 2, 3]
                    .map((label) => DropdownMenuItem(
                          child: Text(label.toString()),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _konsumsiPerHari = value!;
                    _updateTimes();
                  });
                },
              ),
              ..._timeControllers.map((controller) {
                return TextFormField(
                  decoration: InputDecoration(labelText: 'Waktu Konsumsi'),
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      // No need to update _times list as controllers are already managing the values
                    });
                  },
                );
              }).toList(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Keterangan'),
                controller: _keteranganController,
                maxLines: 3,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTimes() {
    List<String> defaultTimes;
    switch (_konsumsiPerHari) {
      case 1:
        defaultTimes = ['08:00'];
        break;
      case 2:
        defaultTimes = ['08:00', '20:00'];
        break;
      case 3:
        defaultTimes = ['08:00', '14:00', '20:00'];
        break;
      default:
        defaultTimes = ['08:00'];
    }

    // Dispose old controllers
    for (var controller in _timeControllers) {
      controller.dispose();
    }

    // Create new controllers with default times
    _timeControllers = defaultTimes
        .map((time) => TextEditingController(text: time))
        .toList();
  }
}