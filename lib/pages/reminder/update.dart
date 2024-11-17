import 'package:flutter/material.dart';
import 'package:medal/services/reminder_service.dart'; // Update with your actual project name

class UpdateReminder extends StatefulWidget {
  final Map<String, dynamic> reminder;

  const UpdateReminder({super.key, required this.reminder});

  @override
  _UpdateReminderState createState() => _UpdateReminderState();
}

class _UpdateReminderState extends State<UpdateReminder> {
  final _formKey = GlobalKey<FormState>();
  late String _namaObat;
  late String _waktuKonsumsi;
  late int _konsumsiPerHari;
  late List<TextEditingController> _timeControllers;
  late TextEditingController _keteranganController;
  final ReminderService _reminderService = ReminderService();

  @override
  void initState() {
    super.initState();
    _namaObat = widget.reminder['namaObat'];
    _waktuKonsumsi = widget.reminder['waktuKonsumsi'];
    _konsumsiPerHari = widget.reminder['konsumsiPerHari'];
    _keteranganController = TextEditingController(text: widget.reminder['keterangan']);
    _timeControllers = [];
    _updateTimes();
  }

  @override
  void dispose() {
    for (var controller in _timeControllers) {
      controller.dispose();
    }
    _keteranganController.dispose();
    super.dispose();
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _reminderService.updateReminder(
          id: widget.reminder['id'],
          namaObat: _namaObat,
          waktuKonsumsi: _waktuKonsumsi,
          konsumsiPerHari: _konsumsiPerHari,
          times: _timeControllers.map((controller) => controller.text).toList(),
          keterangan: _keteranganController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reminder updated successfully')),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false); // Navigate back to the home screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update reminder: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nama Obat'),
                      initialValue: _namaObat,
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
                      decoration: InputDecoration(labelText: 'Konsumsi Per Hari'),
                      value: _konsumsiPerHari,
                      items: [1, 2, 3]
                          .map((value) => DropdownMenuItem(
                                child: Text(value.toString()),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _konsumsiPerHari = value!;
                          _updateTimes();
                        });
                      },
                      onSaved: (value) {
                        _konsumsiPerHari = value!;
                      },
                    ),
                    ..._timeControllers.map((controller) {
                      return TextFormField(
                        controller: controller,
                        decoration: InputDecoration(labelText: 'Time'),
                      );
                    }).toList(),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Keterangan'),
                      controller: _keteranganController,
                      onSaved: (value) {
                        _keteranganController.text = value!;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}