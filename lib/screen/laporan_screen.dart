import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/grafik/bar_graphBulanan.dart';
import 'package:app_hemat/grafik/bar_graphMingguan.dart';
import 'package:app_hemat/screen/cariTransaksi_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanScreenData extends ChangeNotifier {
  String? itemDipilih = 'Mingguan';

  void updateItemDipilih(String newItem) {
    itemDipilih = newItem;
    notifyListeners();
  }
}

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  List<String>? kategoriListPengeluaran;
  bool isDataLoaded = false;
  List<String>? kategoriListPemasukan;
  List<String> items = ['Mingguan', 'Bulanan'];
  String? itemDipilih = 'Mingguan';

  Future<List<String>> getPengeluaranKategori(int tipe) async {
    return await Provider.of<AppDb>(context, listen: false)
        .getPengeluaranKategoriNamaRepo(tipe);
  }

  Future<void> fetchKategoriData() async {
    List<String> dataPengeluaran = await getPengeluaranKategori(2);
    List<String> dataPemasukan = await getPengeluaranKategori(1);

    setState(() {
      kategoriListPengeluaran = dataPengeluaran;
      kategoriListPemasukan = dataPemasukan;
      isDataLoaded = true;
    });
  }

  Future<String> getNamaPanggilan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String namaPanggilan = prefs.getString('nama_panggilan') ?? 'Jomblo';
    return namaPanggilan;
  }

  @override
  void initState() {
    fetchKategoriData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => LaporanScreenData(),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: screenHeight * 0.28,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                  left: screenWidth * 0.05, bottom: screenHeight * 0.02),
              title: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: getNamaPanggilan(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          String namaPanggilan = snapshot.data ?? 'Jomblo';
                          return Text(
                            'Halo, $namaPanggilan',
                            style: GoogleFonts.roboto(
                                textStyle: textTheme.headlineSmall),
                          );
                        }
                      },
                    ),
                    Text(
                      'Laporan Keuangan Anda',
                      style: GoogleFonts.nunito(textStyle: textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
              background: Padding(
                padding: EdgeInsets.all(screenWidth * 0.054),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: screenWidth * 0.15,
                          icon: const FaIcon(
                            FontAwesomeIcons.chartPie,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Memanggil widget MyPieChartBulanan
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyPieChartBulanan(
                                  tipe: 2,
                                  kategoriNama: '',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: screenWidth * 0.15,
                          icon: const FaIcon(
                            FontAwesomeIcons.chartPie,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            // Memanggil widget MyPieChartBulanan
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyPieChartBulanan(
                                  tipe: 1,
                                  kategoriNama: '',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.searchengin),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CariTransaksiScreen()));
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // Mengambil itemDipilih dari provider
                final itemDipilih =
                    Provider.of<LaporanScreenData>(context).itemDipilih;

                return Container(
                  height: screenHeight * 0.07,
                  color: Theme.of(context).colorScheme.background,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        child: Text(
                          'Laporan Keuangan',
                          style: GoogleFonts.roboto(
                              textStyle: textTheme.titleMedium),
                        ),
                      ),
                      DropdownButton<String?>(
                        value: itemDipilih,
                        items: items
                            .map((value) => DropdownMenuItem<String?>(
                                  value: value,
                                  child: Text(value.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // Memperbarui itemDipilih menggunakan provider
                          Provider.of<LaporanScreenData>(context, listen: false)
                              .updateItemDipilih(value!);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: isDataLoaded
                ? SizedBox(
                    height: screenHeight * 0.35,
                    child: PageView.builder(
                      itemCount: kategoriListPengeluaran!.length,
                      itemBuilder: (context, index) {
                        // Tampilkan elemen yang sesuai dalam PageView
                        return Padding(
                          padding: EdgeInsets.all(screenWidth * 0.1),
                          child: MyBarGraphMingguan(
                            tipe: 2,
                            kategoriNama: kategoriListPengeluaran![index],
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
          SliverToBoxAdapter(
            child: isDataLoaded
                ? SizedBox(
                    height: screenHeight * 0.35,
                    child: PageView.builder(
                      itemCount: kategoriListPemasukan!
                          .length, // Jumlah elemen dalam array
                      itemBuilder: (context, index) {
                        // Tampilkan elemen yang sesuai dalam PageView
                        return Padding(
                          padding: EdgeInsets.all(screenWidth * 0.1),
                          child: MyBarGraphMingguan(
                            tipe: 1,
                            kategoriNama: kategoriListPemasukan![index],
                          ),
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      )),
    );
  }
}
