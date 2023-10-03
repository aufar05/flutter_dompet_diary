import 'package:app_hemat/provider/themeProvider.dart';
import 'package:app_hemat/screen/editProfil_screen.dart';
import 'package:app_hemat/screen/pKategori_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingItem(
            'Pengaturan Profil',
            Icons.person,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileSettingsScreen()),
              );
            },
          ),
          const SizedBox(height: 16.0),
          _buildSettingItem(
            'Pengaturan Kategori',
            Icons.category,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PkategoriScreen()),
              );
            },
          ),
          const SizedBox(height: 16.0),
          _buildDarkModeSwitch(themeProvider),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      String title, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onBackground),
          const SizedBox(width: 16.0),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeSwitch(ThemeProvider themeProvider) {
    return Row(
      children: [
        Icon(
          themeProvider.isDarkModeEnabled
              ? Icons.nightlight_round_sharp
              : Icons.sunny,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        const SizedBox(width: 16.0),
        Text(
          themeProvider.isDarkModeEnabled ? 'Mode Gelap' : 'Mode Terang',
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const Spacer(),
        Switch(
          value: themeProvider.isDarkModeEnabled,
          onChanged: (newValue) {
            themeProvider.toggleDarkMode(newValue);
          },
        ),
      ],
    );
  }
}
