import 'package:app_hemat/data/transaksi_dan_kategori.dart';
import 'package:app_hemat/screen/transaksi_screen.dart';
import 'package:app_hemat/utils/formatRupiah.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/database.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  late DateTime selectedDate;
  bool isItemBeingDragged = false;

  @override
  void initState() {
    updateView(DateTime.now());
    super.initState();
  }

  void updateView(DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }
    });
  }

  Future<int>? calculateTotalPemasukan(DateTime date) async {
    return await Provider.of<AppDb>(context, listen: false)
        .calculateTotalPemasukanRepo(selectedDate);
  }

  Future<int>? calculateTotalPengeluaran(DateTime date) async {
    return await Provider.of<AppDb>(context, listen: false)
        .calculateTotalPengeluaranRepo(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CalendarAppBar(
          white: Theme.of(context).colorScheme.background,
          locale: 'id',
          backButton: false,
          accent: Theme.of(context).colorScheme.primary,
          onDateChanged: (value) {
            setState(() {
              selectedDate = value;
              updateView(selectedDate);
              calculateTotalPengeluaran(selectedDate);
              calculateTotalPemasukan(selectedDate);
            });
          },
          firstDate: DateTime.now().subtract(const Duration(days: 140)),
          lastDate: DateTime.now(),
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.025),
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                                width: screenWidth * 0.006,
                                color: Theme.of(context).colorScheme.outline)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: Lottie.asset(
                                      'lib/assets/lottie/pemasukan.json',
                                      height: screenHeight * 0.04,
                                      width: screenWidth * 0.08),
                                ),
                                FutureBuilder<int>(
                                  future: calculateTotalPemasukan(selectedDate),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final totalPemasukan = snapshot.data ?? 0;

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
                                                textStyle:
                                                    textTheme.titleMedium),
                                          )
                                        ],
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.025),
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                                width: screenWidth * 0.006,
                                color: Theme.of(context).colorScheme.outline)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: Lottie.asset(
                                      'lib/assets/lottie/pengeluaran.json',
                                      height: screenHeight * 0.04,
                                      width: screenWidth * 0.08),
                                ),
                                FutureBuilder<int>(
                                  future:
                                      calculateTotalPengeluaran(selectedDate),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
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
                                                textStyle:
                                                    textTheme.titleMedium),
                                          )
                                        ],
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Transaksi',
                      style: textTheme.titleLarge,
                    ),
                  ),
                ),
                StreamBuilder<List<TransaksiWithKategori>>(
                    stream: Provider.of<AppDb>(context, listen: false)
                        .getTransaksiDenganHariRepo(selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: screenHeight * 0.32,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return SizedBox(
                              height: screenHeight * 0.32,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final dataTransaksi = snapshot.data![index];
                                    return LongPressDraggable<int>(
                                      onDragStarted: () {
                                        setState(() {
                                          isItemBeingDragged = true;
                                        });
                                      },
                                      onDraggableCanceled: (velocity, offset) {
                                        setState(() {
                                          isItemBeingDragged = false;
                                        });
                                      },
                                      data: dataTransaksi.transaksi.id,
                                      feedback: Material(
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: SizedBox(
                                            height: screenHeight * 0.1,
                                            width: screenWidth,
                                            child: Card(
                                              elevation: 10,
                                              child: ListTile(
                                                leading: (snapshot.data![index]
                                                            .kategori.tipe ==
                                                        2)
                                                    ? Lottie.asset(
                                                        'lib/assets/lottie/pengeluaran.json',
                                                        height:
                                                            screenHeight * 0.06,
                                                        width:
                                                            screenWidth * 0.08)
                                                    : Lottie.asset(
                                                        'lib/assets/lottie/pemasukan.json',
                                                        height:
                                                            screenHeight * 0.06,
                                                        width:
                                                            screenWidth * 0.08),
                                                title: Text(
                                                    CurrencyFormat.convertToIdr(
                                                        snapshot.data![index]
                                                            .transaksi.nominal,
                                                        0)),
                                                subtitle: Text(
                                                    snapshot.data![index]
                                                        .kategori.nama,
                                                    style: GoogleFonts.roboto(
                                                        textStyle: textTheme
                                                            .titleSmall)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(
                                                    screenWidth * 0.15),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              final iconData = snapshot
                                                  .data![index]
                                                  .kategori
                                                  .iconDataString;
                                              return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius.circular(
                                                                screenWidth *
                                                                    0.15)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: (snapshot
                                                                    .data![
                                                                        index]
                                                                    .kategori
                                                                    .tipe ==
                                                                2)
                                                            ? Colors.red
                                                                .withOpacity(
                                                                    0.5)
                                                            : Colors.green
                                                                .withOpacity(
                                                                    0.5),
                                                        spreadRadius: 4,
                                                        blurRadius: 4,
                                                        offset:
                                                            const Offset(2, 0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius.circular(
                                                                screenWidth *
                                                                    0.15)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius.circular(
                                                                    screenWidth *
                                                                        0.15)),
                                                      ),
                                                      height:
                                                          screenHeight * 0.4,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  screenWidth *
                                                                      0.05),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      screenHeight *
                                                                          0.05,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              screenWidth * 0.02,
                                                                        ),
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: (snapshot.data![index].kategori.tipe == 2)
                                                                                ? const Color.fromRGBO(186, 4, 16, 1)
                                                                                : const Color.fromRGBO(53, 186, 4, 1),
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.all(screenWidth * 0.04),
                                                                          child:
                                                                              Icon(
                                                                            IconData(
                                                                              int.tryParse(iconData) ?? Icons.error.codePoint,
                                                                              fontFamily: 'MaterialIcons',
                                                                            ),
                                                                            size:
                                                                                screenHeight * 0.06,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              screenWidth * 0.02,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              snapshot.data![index].kategori.nama,
                                                                              style: GoogleFonts.roboto(textStyle: textTheme.titleMedium, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              snapshot.data![index].transaksi.tanggal_transaksi.toString().substring(0, 10),
                                                                              style: GoogleFonts.roboto(textStyle: textTheme.titleSmall, color: Colors.grey),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .push(MaterialPageRoute(
                                                                                builder: (context) => TransaksiScreen(
                                                                                      transaksiWithKategori: snapshot.data![index],
                                                                                    )))
                                                                            .then((value) {});
                                                                      },
                                                                      child: Container(
                                                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(115, 86, 72, 1)),
                                                                          child: Padding(
                                                                            padding:
                                                                                EdgeInsets.all(screenWidth * 0.02),
                                                                            child:
                                                                                Icon(size: screenWidth * 0.05, Icons.edit),
                                                                          )),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  'Detail :',
                                                                  style: GoogleFonts.roboto(
                                                                      textStyle:
                                                                          textTheme
                                                                              .titleSmall),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .transaksi
                                                                    .detail,
                                                                style: GoogleFonts.nunito(
                                                                    textStyle:
                                                                        textTheme
                                                                            .titleSmall),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          );
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child: ListTile(
                                            leading: (snapshot.data![index]
                                                        .kategori.tipe ==
                                                    2)
                                                ? Lottie.asset(
                                                    'lib/assets/lottie/pengeluaran.json',
                                                    height: screenHeight * 0.06,
                                                    width: screenWidth * 0.08)
                                                : Lottie.asset(
                                                    'lib/assets/lottie/pemasukan.json',
                                                    height: screenHeight * 0.06,
                                                    width: screenWidth * 0.08),
                                            title: Text(
                                                CurrencyFormat.convertToIdr(
                                                    snapshot.data![index]
                                                        .transaksi.nominal,
                                                    0)),
                                            subtitle: Text(
                                                snapshot
                                                    .data![index].kategori.nama,
                                                style: GoogleFonts.roboto(
                                                    textStyle:
                                                        textTheme.titleSmall)),
                                          ),
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
                StreamBuilder<List<TransaksiWithKategori>>(
                    stream: Provider.of<AppDb>(context, listen: false)
                        .getTransaksiDenganHariRepo(selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty && isItemBeingDragged) {
                            return DragTarget<int>(
                              builder: (context, candidateData, rejectedData) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      alignment: Alignment.bottomCenter,
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.02),
                                      child: Icon(
                                        Icons.delete,
                                        size: screenHeight * 0.05,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              },
                              onWillAccept: (data) => true,
                              onAccept: (data) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final dataTransaksi = snapshot.data!
                                        .firstWhere(
                                            (kat) => kat.transaksi.id == data);
                                    return AlertDialog(
                                      title: const Text('Konfirmasi Hapus'),
                                      content: Builder(
                                        builder: (BuildContext context) {
                                          return Text(
                                              'Anda yakin ingin menghapus ${dataTransaksi.kategori.nama} ?');
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isItemBeingDragged = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<AppDb>(context,
                                                    listen: false)
                                                .deleteTransaksiRepo(
                                                    dataTransaksi.transaksi.id);
                                            setState(() {
                                              isItemBeingDragged = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
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
        ));
  }
}
