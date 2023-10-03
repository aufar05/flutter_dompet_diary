import 'package:app_hemat/intro_screen/intro_screen1.dart';
import 'package:app_hemat/intro_screen/intro_screen2.dart';
import 'package:app_hemat/intro_screen/intro_screen3.dart';
import 'package:app_hemat/intro_screen/intro_screen4.dart';
import 'package:app_hemat/screen/navigasi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  bool halamanTerakhir = false;
  final TextEditingController _namaPanggilanController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              halamanTerakhir = (index == 3);
            });
          },
          children: [
            const IntroScreen1(),
            const IntroScreen2(),
            const IntroScreen3(),
            IntroScreen4(_namaPanggilanController),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text('Lewati'),
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                ),
                SmoothPageIndicator(controller: _controller, count: 4),
                halamanTerakhir
                    ? GestureDetector(
                        child: const Text('Selesai'),
                        onTap: () {
                          String namaPanggilan = _namaPanggilanController.text;
                          if (namaPanggilan.isNotEmpty &&
                              namaPanggilan.length <= 10) {
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setString('nama_panggilan', namaPanggilan);
                            });

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Navigasi()),
                            );
                          } else {
                            // Tampilkan pesan kesalahan jika nama panggilan kosong atau lebih dari 10 huruf
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Nama panggilan harus diisi dan tidak boleh lebih dari 10 huruf.'),
                              ),
                            );
                          }
                        },
                      )
                    : GestureDetector(
                        child: const Text('Lanjut'),
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
              ],
            ))
      ]),
    );
  }
}
