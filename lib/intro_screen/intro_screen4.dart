import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen4 extends StatelessWidget {
  final TextEditingController _namaPanggilanController;

  const IntroScreen4(this._namaPanggilanController, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double lottieHeight = MediaQuery.of(context).size.height * 0.3;

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
              Theme.of(context).brightness == Brightness.light
                  ? Lottie.asset('lib/assets/lottie/introPage4.json',
                      height: lottieHeight)
                  : Lottie.asset('lib/assets/lottie/introPage4_2.json',
                      height: lottieHeight),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Text(
                        'Ayo, Beri Nama Anda untuk Memulai!',
                        style: GoogleFonts.poppins(
                            textStyle: textTheme.headlineSmall),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: TextFormField(
                        cursorColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                        controller: _namaPanggilanController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          hintText: 'Nama Panggilan anda?',
                          labelText: 'Nama ',
                          hintStyle: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black),
                          labelStyle: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.black),
                        validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                    )
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
