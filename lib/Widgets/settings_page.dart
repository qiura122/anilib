import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String _storedValue = '';

  Future<void> _saveData() async {
    await secureStorage.write(key: 'token', value: '1234567890abcdef');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil disimpan secara aman!')),
      );
    }
  }

  Future<void> _readData() async {
    String? value = await secureStorage.read(key: 'token');

    if (mounted) {
      setState(() {
        _storedValue = value ?? 'Tidak ada data.';
      });
    }
  }

  Future<void> _deleteData() async {
    await secureStorage.delete(key: 'token');

    if (mounted) {
      setState(() {
        _storedValue = 'Data dihapus.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: _saveData, child: Text('Simpan backup')),
            ElevatedButton(onPressed: _readData, child: Text('Baca backup')),
            ElevatedButton(onPressed: _deleteData, child: Text('Hapus backup')),
            SizedBox(height: 20),
            Text('Isi Token: $_storedValue'),
          ],
        ),
      ),
    );
  }
}
