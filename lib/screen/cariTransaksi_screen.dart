import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/data/transaksi_dan_kategori.dart';
import 'package:app_hemat/utils/formatRupiah.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CariTransaksiScreen extends StatefulWidget {
  const CariTransaksiScreen({Key? key}) : super(key: key);

  @override
  State<CariTransaksiScreen> createState() => _CariTransaksiScreenState();
}

class _CariTransaksiScreenState extends State<CariTransaksiScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TransaksiWithKategori> _searchResults = [];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isNotEmpty) {
          _performSearch(_searchController.text);
        } else {
          _searchResults = [];
        }
      });
    });
  }

  void _performSearch(String keyword) async {
    if (keyword.isNotEmpty) {
      final results = await Provider.of<AppDb>(context, listen: false)
          .searchTransaksi(keyword);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pencarian Transaksi'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.08),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Cari transaksi...',
                ),
              ),
            ),
            SizedBox(
                height: screenHeight *
                    0.05), // Jarak antara TextField dan hasil pencarian
            if (_searchController.text.isEmpty)
              Center(
                child: Text(
                  'Masukkan kata kunci untuk memulai pencarian',
                  style: GoogleFonts.nunito(textStyle: textTheme.titleSmall),
                ),
              )
            else if (_searchResults.isEmpty)
              Center(
                child: Text(
                  'Tidak ada hasil yang ditemukan.',
                  style: GoogleFonts.nunito(textStyle: textTheme.titleSmall),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final transaksi = _searchResults[index];
                    return Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: (transaksi.kategori.tipe == 2)
                              ? Lottie.asset(
                                  'lib/assets/lottie/pengeluaran.json',
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.08)
                              : Lottie.asset('lib/assets/lottie/pemasukan.json',
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.08),
                          title: Text(CurrencyFormat.convertToIdr(
                              transaksi.transaksi.nominal, 0)),
                          subtitle: Row(
                            children: [
                              Text(transaksi.kategori.nama,
                                  style: GoogleFonts.roboto(
                                      textStyle: textTheme.titleSmall)),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Text(
                                transaksi.transaksi.tanggal_transaksi
                                    .toString()
                                    .substring(0, 10),
                                style: GoogleFonts.roboto(
                                    textStyle: textTheme.titleSmall,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
