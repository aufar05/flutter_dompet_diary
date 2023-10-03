import 'package:app_hemat/utils/formatRupiah.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database.dart';
import '../data/transaksi_dan_kategori.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<int>? calculateTotalPemasukanBulan() async {
    return await Provider.of<AppDb>(context).calculateTotalPemasukanBulanRepo();
  }

  Future<int>? calculateTotalPengeluaranBulan() async {
    return await Provider.of<AppDb>(context)
        .calculateTotalPengeluaranBulanRepo();
  }

  Future<int>? calculateTotalSaldo() async {
    return await Provider.of<AppDb>(context).calculateTotalSaldoRepo();
  }

  @override
  void initState() {
    initializeDateFormatting('id_ID');

    super.initState();
  }

  String getNamaBulanSekarang() {
    final now = DateTime.now();
    final formatter = DateFormat.MMMM('id_ID');
    return formatter.format(now);
  }

  Future<String> getNamaPanggilan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String namaPanggilan = prefs.getString('nama_panggilan') ?? 'Jomblo';
    return namaPanggilan;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Future<void> handleRefresh() async {
      setState(() {});
      return await Future.delayed(const Duration(seconds: 1));
    }

    return SafeArea(
      child: Scaffold(
          body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.primary,
        animSpeedFactor: 10,
        onRefresh: handleRefresh,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: ListView(children: [
            Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.015),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder<String>(
                    future: getNamaPanggilan(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String namaPanggilan = snapshot.data ?? 'Jomblo';
                        return Center(
                          child: Text('Halo, $namaPanggilan',
                              style: GoogleFonts.roboto(
                                  textStyle: textTheme.titleMedium)),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  child: Column(
                    children: [
                      Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                  width: screenWidth * 0.005,
                                  color:
                                      Theme.of(context).colorScheme.outline)),
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Column(
                            children: [
                              Lottie.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 'lib/assets/lottie/dompet2.json' // Display buat dark mode
                                    : 'lib/assets/lottie/dompet.json', // Display buat light mode
                                height: screenHeight * 0.085,
                                width: screenHeight * 0.085,
                              ),
                              FutureBuilder<int>(
                                future: calculateTotalSaldo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final totalSaldo = snapshot.data ?? 0;

                                    return Column(
                                      children: [
                                        Text('Saldo',
                                            style: GoogleFonts.roboto(
                                                textStyle:
                                                    textTheme.headlineSmall)),
                                        Text(
                                          totalSaldo == 0
                                              ? 'Rp 0'
                                              : CurrencyFormat.convertToIdr(
                                                  totalSaldo, 0),
                                          style: GoogleFonts.nunito(
                                              textStyle:
                                                  textTheme.headlineMedium),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015),
                            child: Text(
                              'Arus Kas Bulan ${getNamaBulanSekarang()}',
                              style: GoogleFonts.roboto(
                                  textStyle: textTheme.titleSmall),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.02),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      border: Border.all(
                                          width: screenWidth * 0.005,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.02),
                                        child: Lottie.asset(
                                          'lib/assets/lottie/pemasukan.json',
                                          height: screenHeight * 0.04,
                                          width: screenWidth * 0.08,
                                        ),
                                      ),
                                      FutureBuilder<int>(
                                        future: calculateTotalPemasukanBulan(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            final totalPemasukan =
                                                snapshot.data ?? 0;

                                            return Column(
                                              children: [
                                                Text(
                                                  'Pemasukan',
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          textTheme.titleSmall),
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      totalPemasukan, 0),
                                                  style: GoogleFonts.nunito(
                                                      textStyle: textTheme
                                                          .titleMedium),
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.02),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    border: Border.all(
                                        width: screenWidth * 0.005,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.02),
                                        child: Lottie.asset(
                                            'lib/assets/lottie/pengeluaran.json',
                                            height: screenHeight * 0.04,
                                            width: screenWidth * 0.08),
                                      ),
                                      FutureBuilder<int>(
                                        future:
                                            calculateTotalPengeluaranBulan(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            final totalPengeluaran =
                                                snapshot.data ?? 0;

                                            return Column(
                                              children: [
                                                Text(
                                                  'Pengeluaran',
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          textTheme.titleSmall),
                                                ),
                                                Text(
                                                  CurrencyFormat.convertToIdr(
                                                      totalPengeluaran, 0),
                                                  style: GoogleFonts.nunito(
                                                      textStyle: textTheme
                                                          .titleMedium),
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Transaksi Terkini',
                          style: textTheme.titleLarge,
                        ),
                      ),
                      StreamBuilder<List<TransaksiWithKategori>>(
                          stream: Provider.of<AppDb>(context)
                              .getTransaksiTerbaruRepo(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: screenHeight * 0.21,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  return SizedBox(
                                    height: screenHeight * 0.21,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 5,
                                            child: ListTile(
                                              leading: (snapshot.data![index]
                                                          .kategori.tipe ==
                                                      2)
                                                  ? Lottie.asset(
                                                      'lib/assets/lottie/pengeluaran.json',
                                                      height:
                                                          screenHeight * 0.04,
                                                      width: screenWidth * 0.08)
                                                  : Lottie.asset(
                                                      'lib/assets/lottie/pemasukan.json',
                                                      height:
                                                          screenHeight * 0.04,
                                                      width:
                                                          screenWidth * 0.08),
                                              title: Text(
                                                  CurrencyFormat.convertToIdr(
                                                      snapshot.data![index]
                                                          .transaksi.nominal,
                                                      0)),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                      snapshot.data![index]
                                                          .kategori.nama,
                                                      style: GoogleFonts.roboto(
                                                          textStyle: textTheme
                                                              .titleSmall)),
                                                  SizedBox(
                                                    width: screenWidth * 0.01,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data![index]
                                                        .transaksi
                                                        .tanggal_transaksi
                                                        .toString()
                                                        .substring(0, 10),
                                                    style: GoogleFonts.roboto(
                                                        textStyle: textTheme
                                                            .titleSmall,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? 'lib/assets/lottie/noDataTransaksi.json'
                                                : 'lib/assets/lottie/noDataTransaksi2.json',
                                            height: screenHeight * 0.2,
                                            width: screenWidth * 0.4),
                                        Text('Data kosong',
                                            style: GoogleFonts.roboto(
                                              textStyle: textTheme.titleSmall,
                                            ))
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: Text(
                                    'Data Kosong',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ),
      )),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
