import 'package:app_hemat/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
// ignore: unused_import
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PkategoriScreen extends StatefulWidget {
  const PkategoriScreen({super.key});

  @override
  State<PkategoriScreen> createState() => _PkategoriScreenState();
}

class _PkategoriScreenState extends State<PkategoriScreen> {
  bool isPengeluaran = true;
  int tipe = 2;

  String? iconDataString;

  bool isItemBeingDragged = false;

  TextEditingController kNamaController = TextEditingController();

  Future insert(String nama, int tipe, String iconDataString) async {
    DateTime now = DateTime.now();
    await Provider.of<AppDb>(context, listen: false)
        .into(Provider.of<AppDb>(context, listen: false).kategori)
        .insert(
          KategoriCompanion.insert(
            iconDataString: iconDataString,
            nama: nama,
            tipe: tipe,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future update(int kategoriId, String newNama, String newIconDataSring) async {
    return await Provider.of<AppDb>(context, listen: false)
        .updateKategoriRepo(kategoriId, newNama, newIconDataSring);
  }

  Future updateTanpaGambar(
    int kategoriId,
    String newNama,
  ) async {
    return await Provider.of<AppDb>(context, listen: false)
        .updateTanpaGambarKategoriRepo(kategoriId, newNama);
  }

  void _pickIcon() async {
    IconData? selectedIcon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material],
        iconColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white);

    if (selectedIcon != null) {
      setState(() {
        iconDataString = selectedIcon.codePoint.toString();
      });
    }
  }

  Future<List<NKategori>> getAllKategori(int tipe) async {
    return await Provider.of<AppDb>(context, listen: false)
        .getAllKategoriRepo(tipe);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void openDialog(NKategori? kategori) {
      if (kategori != null) {
        kNamaController.text = kategori.nama;
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        (isPengeluaran)
                            ? 'Tambah Pengeluaran'
                            : 'Tambah Pemasukan',
                        style: GoogleFonts.roboto(
                            textStyle: textTheme.titleSmall,
                            color: (isPengeluaran) ? Colors.red : Colors.green),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextFormField(
                        controller: kNamaController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: (isPengeluaran)
                                ? "Nama Pengeluaran"
                                : "Nama Pemasukan"),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: _pickIcon,
                        child: const Text('Pilih Icon'),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (kategori == null) {
                            iconDataString ??= '984405';

                            insert(kNamaController.text, isPengeluaran ? 2 : 1,
                                iconDataString!);
                          } else {
                            if (iconDataString != null) {
                              update(kategori.id, kNamaController.text,
                                  iconDataString!);
                            } else {
                              // Jika gambar tidak dipilih, lakukan pembaruan tanpa mengubah gambar.
                              updateTanpaGambar(
                                  kategori.id, kNamaController.text);
                            }
                          }

                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {});
                          kNamaController.clear();
                        },
                        child: const Text('Simpan'),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Kategori')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isPengeluaran,
                  onChanged: (bool value) {
                    setState(() {
                      isPengeluaran = value;
                      tipe = value ? 2 : 1;
                    });
                  },
                  inactiveTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.green,
                  activeColor: Colors.red,
                ),
                IconButton(
                    onPressed: () {
                      openDialog(null);
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ))
              ],
            ),
          ),
          FutureBuilder<List<NKategori>>(
              future: getAllKategori(tipe),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: screenHeight * 0.5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final kategori = snapshot.data![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04),
                            child: LongPressDraggable<int>(
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
                              data: kategori.id,
                              feedback: Opacity(
                                opacity: 0.7,
                                child: Material(
                                  child: SizedBox(
                                    height: screenHeight * 0.1,
                                    width: screenWidth,
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: (isPengeluaran)
                                            ? Lottie.asset(
                                                'lib/assets/lottie/pengeluaran.json',
                                                height: screenHeight * 0.06,
                                                width: screenWidth * 0.08)
                                            : Lottie.asset(
                                                'lib/assets/lottie/pemasukan.json',
                                                height: screenHeight * 0.06,
                                                width: screenWidth * 0.08),
                                        title: Text(snapshot.data![index].nama),
                                        trailing: IconButton(
                                            onPressed: () {
                                              openDialog(snapshot.data![index]);
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              childWhenDragging: Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: (isPengeluaran)
                                      ? Lottie.asset(
                                          'lib/assets/lottie/pengeluaran.json',
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.08)
                                      : Lottie.asset(
                                          'lib/assets/lottie/pemasukan.json',
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.08),
                                  title: Text(snapshot.data![index].nama),
                                  trailing: IconButton(
                                      onPressed: () {
                                        openDialog(snapshot.data![index]);
                                      },
                                      icon: const Icon(Icons.edit)),
                                ),
                              ),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: (isPengeluaran)
                                      ? Lottie.asset(
                                          'lib/assets/lottie/pengeluaran.json',
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.08)
                                      : Lottie.asset(
                                          'lib/assets/lottie/pemasukan.json',
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.08),
                                  title: Text(snapshot.data![index].nama),
                                  trailing: IconButton(
                                      onPressed: () {
                                        openDialog(snapshot.data![index]);
                                      },
                                      icon: const Icon(Icons.edit)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    // ignore: dead_code
                    if (snapshot.data!.isNotEmpty) {
                    } else {
                      return const Center(
                        child: Text('Data kosong'),
                      );
                    }
                  } else {
                    return const Center(child: Text('Data kosong'));
                  }
                }
              }),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          FutureBuilder<List<NKategori>>(
              future: getAllKategori(tipe),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (isItemBeingDragged && snapshot.hasData) {
                    return DragTarget<int>(
                      builder: (context, candidateData, rejectedData) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.bottomCenter,
                              padding:
                                  EdgeInsets.only(bottom: screenWidth * 0.02),
                              child: Icon(
                                Icons.delete,
                                size: screenHeight * 0.06,
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
                            final kategori = snapshot.data!
                                .firstWhere((kat) => kat.id == data);
                            return AlertDialog(
                              title: const Text('Konfirmasi Hapus'),
                              content: Builder(
                                builder: (BuildContext context) {
                                  return Text(
                                      'Anda yakin ingin menghapus ${kategori.nama} ?');
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
                                    Provider.of<AppDb>(context, listen: false)
                                        .deleteKategoriRepo(kategori.id);
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
                    // ignore: dead_code
                    if (snapshot.data!.isNotEmpty) {
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                }
              }),
        ],
      ),
    ));
  }
}
