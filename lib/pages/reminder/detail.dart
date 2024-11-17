import 'package:flutter/material.dart';
import 'package:medal/services/reminder_service.dart';
import 'package:medal/pages/reminder/update.dart'; // Import the update page

class DetailReminder extends StatelessWidget {
  final Map<String, dynamic> reminder;

  const DetailReminder({super.key, required this.reminder});

  Future<void> _deleteReminder(BuildContext context) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus pengingat ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await ReminderService().deleteReminder(reminder['id']);
      Navigator.of(context).pop(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengingat Obat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Obat: ${reminder['namaObat']}'),
            SizedBox(height: 8),
            Text('Waktu Konsumsi: ${reminder['waktuKonsumsi']}'),
            SizedBox(height: 8),
            Text('Times: ${reminder['times'].join(' / ')}'),
            if (reminder['keterangan'] != null && reminder['keterangan'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Keterangan: ${reminder['keterangan']}'),
              ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateReminder(reminder: reminder),
                      ),
                    );
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteReminder(context),
                  child: Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}