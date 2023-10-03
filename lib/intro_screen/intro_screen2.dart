import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Menghitung tinggi animasi Lottie sesuai dengan layar
    double lottieHeight = MediaQuery.of(context).size.height * 0.3;
    double lottieHeightsm = MediaQuery.of(context).size.height * 0.2;

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
              Column(
                children: [
                  SizedBox(
                    height: lottieHeight,
                    child: Lottie.asset(
                      'lib/assets/lottie/introPage2.json',
                      width: screenWidth * 0.8,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: lottieHeightsm,
                        child: Lottie.asset(
                          'lib/assets/lottie/introPage2_1.json',
                          width: screenWidth * 0.4,
                        ),
                      ),
                      SizedBox(
                        height: lottieHeightsm,
                        child: Lottie.asset(
                          'lib/assets/lottie/introPage2_2.json',
                          width: screenWidth * 0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(
                        'Kelola Keuangan Anda Secara Efisien',
                        style: GoogleFonts.poppins(
                          textStyle: textTheme.headlineSmall,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      child: Text(
                        'Catat Pemasukan dan Pengeluaran',
                        style: GoogleFonts.montserrat(
                          textStyle: textTheme.bodyMedium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      child: Text(
                        'Dimana saja dan kapan saja',
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
