import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/data/transaksi_dan_kategori.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransaksiScreen extends StatefulWidget {
  final TransaksiWithKategori? transaksiWithKategori;
  const TransaksiScreen({Key? key, required this.transaksiWithKategori})
      : super(key: key);

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  bool isPengeluaran = true;
  late int tipe;
  List<NKategori>? kategoriList;
  NKategori? itemDipilih;
  TextEditingController nominalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future insert(
      int nominal, int kategoriId, DateTime date, String deskripsi) async {
    DateTime now = DateTime.now();
    // ignore: unused_local_variable
    final row = await Provider.of<AppDb>(context, listen: false)
        .into(Provider.of<AppDb>(context, listen: false).transaksi)
        .insertReturning(TransaksiCompanion.insert(
            detail: deskripsi,
            kategori_id: kategoriId,
            nominal: nominal,
            tanggal_transaksi: date,
            createdAt: now,
            updatedAt: now));
  }

  @override
  void initState() {
    if (widget.transaksiWithKategori != null) {
      updateTransaksiView(widget.transaksiWithKategori!);
    } else {
      tipe = 2;
    }
    super.initState();
    fetchKategoriData();
  }

  Future<List<NKategori>> getAllKategori(int tipe) async {
    return await Provider.of<AppDb>(context, listen: false)
        .getAllKategoriRepo(tipe);
  }

  Future<void> fetchKategoriData() async {
    List<NKategori> data = await getAllKategori(tipe);
    setState(() {
      kategoriList = data;

      if (itemDipilih == null && kategoriList!.isNotEmpty) {
        itemDipilih = kategoriList!.first;
      }
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future update(int transaksiId, int newNominal, int kategoriId,
      DateTime transaksiHari, String newDetail) async {
    return await Provider.of<AppDb>(context, listen: false).updateTranasksiRepo(
        transaksiId, newNominal, kategoriId, transaksiHari, newDetail);
  }

  void updateTransaksiView(TransaksiWithKategori transaksiWithKategori) {
    setState(() {
      nominalController.text =
          transaksiWithKategori.transaksi.nominal.toString();
      deskripsiController.text =
          transaksiWithKategori.transaksi.detail.toString();
      dateController.text = DateFormat("yyyy-MM-dd")
          .format(transaksiWithKategori.transaksi.tanggal_transaksi);
      tipe = transaksiWithKategori.kategori.tipe;
      (tipe == 2) ? isPengeluaran = true : isPengeluaran = false;
      itemDipilih = transaksiWithKategori.kategori;

      // Perbarui daftar kategori
      fetchKategoriData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: (widget.transaksiWithKategori == null)
            ? const Text('Tambah Transaksi')
            : const Text('Update Transaksi'),
      ),
      body: kategoriList == null
          ? const Center(child: CircularProgressIndicator())
          : kategoriList!.isEmpty
              ? const Center(child: Text('Data Belum ada'))
              : SingleChildScrollView(
                  child: SafeArea(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: LiteRollingSwitch(
                          value: isPengeluaran,
                          width: screenWidth * 0.39,
                          textOn: 'Pengeluaran',
                          textOff: 'Pemasukan',
                          textOffColor: Colors.white,
                          textOnColor: Colors.white,
                          colorOn: Colors.red,
                          colorOff: Colors.green,
                          iconOn: Icons.upload,
                          iconOff: Icons.download,
                          animationDuration: const Duration(milliseconds: 300),
                          onChanged: (bool value) {
                            setState(() {
                              isPengeluaran = value;
                              tipe = (isPengeluaran) ? 2 : 1;
                              itemDipilih = null;
                              fetchKategoriData();
                            });
                          },
                          onDoubleTap: () {},
                          onSwipe: () {},
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.01),
                        child: TextFormField(
                          controller: nominalController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.monetization_on_rounded),
                              labelText: "Masukan Nominal",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.01),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Kategori',
                            prefixIcon: const Icon(
                              Icons.category_outlined,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.008),
                          ),
                          child: DropdownButton<NKategori>(
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: (itemDipilih == null)
                                ? kategoriList!.first
                                : itemDipilih,
                            onChanged: (NKategori? value) {
                              setState(() {
                                itemDipilih = value;
                              });
                            },
                            items: kategoriList!.map((NKategori value) {
                              return DropdownMenuItem<NKategori>(
                                value: value,
                                child: Text(value.nama),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.01),
                        child: TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: const InputDecoration(
                            labelText: 'Pilih Tanggal',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.01),
                        child: TextFormField(
                          controller: deskripsiController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            labelText: 'Deskripsi',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (widget.transaksiWithKategori == null) {
                                insert(
                                  int.parse(nominalController.text),
                                  itemDipilih!.id,
                                  DateTime.parse(dateController.text),
                                  deskripsiController.text,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Data berhasil disimpan.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                update(
                                  widget.transaksiWithKategori!.transaksi.id,
                                  int.parse(nominalController.text),
                                  itemDipilih!.id,
                                  DateTime.parse(dateController.text),
                                  deskripsiController.text,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Data berhasil diupdate.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }

                              Navigator.pop(context, true);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal menyimpan atau mengupdate data: $e',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text('Simpan'),
                        ),
                      )
                    ],
                  )),
                ),
    );
  }
}
