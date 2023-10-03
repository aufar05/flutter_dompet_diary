import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ProfileSettingsScreenState createState() => ProfileSettingsScreenState();
}

class ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final TextEditingController _namaController = TextEditingController();
  bool loadNama = true;

  @override
  void initState() {
    super.initState();
    _loadNamaPanggilan();
  }

  void _loadNamaPanggilan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String namaPanggilan = prefs.getString('nama_panggilan') ?? '';
    setState(() {
      _namaController.text = namaPanggilan;
    });
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      loadNama = false;
    });
  }

  Future<void> _simpanNamaPanggilan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_panggilan', _namaController.text);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Nama berhasil diubah'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama Panggilan'),
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(
                hintText: loadNama ? '' : 'Masukkan Nama Panggilan Anda',
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10)
              ], // Batasan 10 huruf
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _simpanNamaPanggilan();
                Navigator.of(context).pop(); // Kembali ke halaman pengaturan
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
