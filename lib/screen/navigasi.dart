import 'package:app_hemat/screen/home_screen.dart';
import 'package:app_hemat/screen/kalender_screen.dart';
import 'package:app_hemat/screen/laporan_screen.dart';
import 'package:app_hemat/screen/settings_screen.dart';
import 'package:app_hemat/screen/transaksi_screen.dart';
import 'package:flutter/material.dart';

class Navigasi extends StatefulWidget {
  const Navigasi({Key? key}) : super(key: key);

  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  int currentTab = 0;
  final List<Widget> Screens = [
    const HomeScreen(),
    const KalenderScreen(),
    const LaporanScreen(),
    const SettingScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext scaffoldContext) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) =>
                  const TransaksiScreen(transaksiWithKategori: null),
            ))
                .then((value) {
              setState(() {});
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeScreen();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          Text(
                            'Dasbor',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const KalenderScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: currentTab == 1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          Text(
                            'Kalender',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const LaporanScreen();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: currentTab == 2
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          Text(
                            'Laporan',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const SettingScreen();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          Text(
                            'Setelan',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
