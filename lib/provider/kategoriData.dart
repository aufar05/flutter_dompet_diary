import 'package:flutter/foundation.dart';
import 'package:app_hemat/data/database.dart';

class CategoryData extends ChangeNotifier {
  bool _isPengeluaran = true;
  int _tipe = 2;
  List<NKategori> _kategoriList = [];

  bool get isPengeluaran => _isPengeluaran;
  int get tipe => _tipe;
  List<NKategori> get kategoriList => _kategoriList;

  void setIsPengeluaran(bool value) {
    _isPengeluaran = value;
    _tipe = value ? 2 : 1;
    notifyListeners();
  }

  void setKategoriList(List<NKategori> newList) {
    _kategoriList = newList;
    notifyListeners();
  }

  void removeKategori(int index) {
    _kategoriList.removeAt(index);
    notifyListeners();
  }
}
