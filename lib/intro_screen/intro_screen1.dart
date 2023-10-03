import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Lottie.asset(
                'lib/assets/lottie/introPage1.json',
                width: screenWidth * 0.8,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(
                        'Selamat datang di DompetDiary',
                        style: GoogleFonts.poppins(
                          textStyle: textTheme.headlineSmall,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Text(
                        'Kami membantu anda dalam mencatat keuangan anda',
                        style: GoogleFonts.montserrat(
                          textStyle: textTheme.bodyMedium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
