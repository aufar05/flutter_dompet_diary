import 'dart:io';
import 'package:app_hemat/data/kategori.dart';
import 'package:app_hemat/data/transaksi.dart';
import 'package:app_hemat/data/transaksi_dan_kategori.dart';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  tables: [Kategori, Transaksi],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      // onCreate: (Migrator m) async {
      //   await m.createAll();
      // },
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          // Create a bunch of default values so the app doesn't look too empty
          // on the first start.
          await batch((a) {
            a.insertAll(kategori, [
              KategoriCompanion.insert(
                  nama: 'Makan',
                  tipe: 2,
                  iconDataString: '63364',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()),
              KategoriCompanion.insert(
                  nama: 'Transportasi',
                  tipe: 2,
                  iconDataString: '57824',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()),
              KategoriCompanion.insert(
                  nama: 'Jajan',
                  tipe: 2,
                  iconDataString: '984670',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()),
              KategoriCompanion.insert(
                  nama: 'Gajian',
                  tipe: 1,
                  iconDataString: '62677',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()),
              KategoriCompanion.insert(
                  nama: 'Freelance',
                  tipe: 1,
                  iconDataString: '63478',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now()),
            ]);
          });
        }
      },
    );
  }

  Future<void> migrateFromUnixTimestampsToText(Migrator m) async {
    for (final table in allTables) {
      final dateTimeColumns =
          table.$columns.where((c) => c.type == DriftSqlType.dateTime);

      if (dateTimeColumns.isNotEmpty) {
        // This table has dateTime columns which need to be migrated.
        await m.alterTable(TableMigration(
          table,
          columnTransformer: {
            for (final column in dateTimeColumns)
              // We assume that the column in the database is an int (unix
              // timestamp), use `fromUnixEpoch` to convert it to a date time.
              // Note that the resulting value in the database is in UTC.
              column: DateTimeExpressions.fromUnixEpoch(column.dartCast<int>()),
          },
        ));
      }
    }
  }

  Future<List<NKategori>> getAllKategoriRepo(int tipe) async {
    return await (select(kategori)..where((tbl) => tbl.tipe.equals(tipe)))
        .get();
  }

  Future<List<String>> getPengeluaranKategoriNamaRepo(int tipe) async {
    final queryResult =
        await (select(kategori)..where((tbl) => tbl.tipe.equals(tipe))).get();

    final kategoriNamaList =
        queryResult.map((kategori) => kategori.nama).toList();

    return kategoriNamaList;
  }

  Future updateKategoriRepo(int id, String nama, String iconDataString) async {
    return (update(kategori)..where((tbl) => tbl.id.equals(id))).write(
      KategoriCompanion(
        nama: Value(nama),
        iconDataString: Value(iconDataString),
      ),
    );
  }

  Future updateTranasksiRepo(
    int id,
    int nominal,
    int kategoriId,
    DateTime tanggalTransaksi,
    String detail,
  ) async {
    return (update(transaksi)..where((tbl) => tbl.id.equals(id))).write(
        TransaksiCompanion(
            kategori_id: Value(kategoriId),
            detail: Value(detail),
            nominal: Value(nominal),
            tanggal_transaksi: Value(tanggalTransaksi)));
  }

  Future updateTanpaGambarKategoriRepo(int id, String nama) async {
    return (update(kategori)..where((tbl) => tbl.id.equals(id))).write(
      KategoriCompanion(
        nama: Value(nama),
      ),
    );
  }

  Future deleteKategoriRepo(int id) async {
    return (delete(kategori)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future deleteTransaksiRepo(int id) async {
    return (delete(transaksi)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TransaksiWithKategori>> getTransaksiDenganHariRepo(
      DateTime date) {
    final query = (select(transaksi).join(
        [innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))])
      ..where(transaksi.tanggal_transaksi.equals(date)));

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransaksiWithKategori(
            row.readTable(transaksi), row.readTable(kategori));
      }).toList();
    });
  }

  Stream<List<TransaksiWithKategori>> getTransaksiDenganKategoriRepo() {
    final query = (select(transaksi).join(
        [innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))]));

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransaksiWithKategori(
            row.readTable(transaksi), row.readTable(kategori));
      }).toList();
    });
  }

  Stream<List<TransaksiWithKategori>> getTransaksiTerbaruRepo() {
    final query = (select(transaksi)
          ..orderBy(
            [
              (t) => OrderingTerm(
                  expression: t.tanggal_transaksi, mode: OrderingMode.desc)
            ],
          )
          ..limit(5))
        .join([
      innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransaksiWithKategori(
            row.readTable(transaksi), row.readTable(kategori));
      }).toList();
    });
  }

  Future<int> calculateTotalPemasukanRepo(DateTime date) async {
    final totalPemasukan = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(transaksi.tanggal_transaksi.equals(date) &
              kategori.tipe.equals(1)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();
    return totalPemasukan ?? 0;
  }

  Future<int> calculateTotalPengeluaranRepo(DateTime date) async {
    final totalPengeluaran = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(transaksi.tanggal_transaksi.equals(date) &
              kategori.tipe.equals(2)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();

    return totalPengeluaran ?? 0;
  }

  Future<int> calculateTotalPemasukanBulanRepo() async {
    final now = DateTime.now()
        .toLocal(); // Mengambil tanggal saat ini dalam zona waktu UTC
    final currentMonth = now.month;
    final currentYear = now.year;

    final firstDayOfMonth = DateTime.utc(currentYear, currentMonth, 1)
        .subtract(const Duration(days: 1));
    final lastDayOfMonth = DateTime.utc(currentYear, currentMonth + 1, 1)
        .subtract(const Duration(days: 1));

    final totalPemasukan = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(transaksi.tanggal_transaksi
                  .isBetweenValues(firstDayOfMonth, lastDayOfMonth) &
              kategori.tipe.equals(1)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();
    return totalPemasukan ?? 0;
  }

  Future<int> calculateTotalPengeluaranBulanRepo() async {
    final now = DateTime.now()
        .toLocal(); // Mengambil tanggal saat ini dalam zona waktu UTC
    final currentMonth = now.month;
    final currentYear = now.year;

    final firstDayOfMonth = DateTime.utc(currentYear, currentMonth, 1)
        .subtract(const Duration(days: 1));
    final lastDayOfMonth = DateTime.utc(currentYear, currentMonth + 1, 1)
        .subtract(const Duration(days: 1));

    final totalPengeluaran = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(transaksi.tanggal_transaksi
                  .isBetweenValues(firstDayOfMonth, lastDayOfMonth) &
              kategori.tipe.equals(2)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();
    return totalPengeluaran ?? 0;
  }

  Future<int> calculateTotalSaldoRepo() async {
    final totalPengeluaranResult = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(kategori.tipe.equals(2)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();

    final totalPengeluaran = totalPengeluaranResult ?? 0;

    final totalPemasukanResult = await (selectOnly(transaksi)
          ..addColumns([transaksi.nominal.sum()])
          ..join([
            innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id)),
          ])
          ..where(kategori.tipe.equals(1)))
        .map((row) => row.read(transaksi.nominal.sum()))
        .getSingleOrNull();

    final totalPemasukan = totalPemasukanResult ?? 0;

    final totalSaldo = totalPemasukan - totalPengeluaran;
    return totalSaldo;
  }

  Stream<Map<String, int>> calculateTotalNilaiBarChartPerMingguRepo(
      DateTime date, String nama, int tipe) {
    final DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    final DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final query = (select(
      transaksi,
    ).join([innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))])
      ..where(transaksi.tanggal_transaksi
              .isBiggerOrEqualValue(firstDayOfMonth) &
          transaksi.tanggal_transaksi.isSmallerOrEqualValue(lastDayOfMonth) &
          kategori.tipe.equals(tipe) &
          kategori.nama.equals(nama)));

    return query.watch().map((rows) {
      final Map<String, int> pemasukanPerMinggu = {};

      for (final row in rows) {
        final tanggalTransaksi = row.read(transaksi.tanggal_transaksi);
        final weekInMonth = ((tanggalTransaksi!.day - 1) ~/ 7) +
            1; // Menghitung minggu dalam bulan
        final yearMonthWeek = DateFormat('yyyyMM').format(tanggalTransaksi) +
            weekInMonth.toString();
        final nominal = row.read(transaksi.nominal);

        if (nominal != null) {
          pemasukanPerMinggu[yearMonthWeek] =
              (pemasukanPerMinggu[yearMonthWeek] ?? 0) + nominal;
        }
      }

      // Membagi pemasukan per minggu menjadi minggu-minggu yang diinginkan
      final Map<String, int> result = {};
      for (int week = 1; week <= 5; week++) {
        final yearMonthWeek =
            DateFormat('yyyyMM').format(date) + week.toString();
        result['Week $week'] = pemasukanPerMinggu[yearMonthWeek] ?? 0;
      }

      return result;
    });
  }

  Stream<Map<String, int>> calculateTotalNilaiBarChartPerHariRepo(
      DateTime date, String nama, int tipe) {
    final DateFormat indonesianDateFormat = DateFormat('EEEE', 'id_ID');

    final DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday));
    final DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));

    final query = (select(
      transaksi,
    ).join([innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))])
      ..where(transaksi.tanggal_transaksi.isBiggerOrEqualValue(firstDayOfWeek) &
          transaksi.tanggal_transaksi.isSmallerOrEqualValue(lastDayOfWeek) &
          kategori.tipe.equals(tipe) &
          kategori.nama.equals(nama)));

    return query.watch().map((rows) {
      final Map<String, int> pemasukanPerHari = {};

      for (int day = 1; day < 8; day++) {
        final currentDay = firstDayOfWeek.add(Duration(days: day));
        final dayName = indonesianDateFormat.format(currentDay);
        pemasukanPerHari[dayName] = 0;
      }

      for (final row in rows) {
        final nominal = row.read(transaksi.nominal);

        if (nominal != null) {
          final tanggalTransaksi = row.read(transaksi.tanggal_transaksi);
          final dayOfWeek = indonesianDateFormat.format(tanggalTransaksi!);

          pemasukanPerHari.update(dayOfWeek, (value) => value + nominal,
              ifAbsent: () => nominal);
        }
      }

      return pemasukanPerHari;
    });
  }

  Stream<Map<String, int>> calculateTotalNilaiPieChartPerBulanRepo(
      DateTime date, int tipe) {
    final DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    final DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final query = (select(
      transaksi,
    ).join([innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))])
      ..where(transaksi.tanggal_transaksi
              .isBiggerOrEqualValue(firstDayOfMonth) &
          transaksi.tanggal_transaksi.isSmallerOrEqualValue(lastDayOfMonth) &
          kategori.tipe.equals(tipe)));

    return query.watch().map((rows) {
      final Map<String, int> pemasukanPerKategori = {};

      for (final row in rows) {
        final namaKategori = row.read(kategori.nama);
        final nominal = row.read(transaksi.nominal);

        if (nominal != null && namaKategori != null) {
          pemasukanPerKategori[namaKategori] =
              (pemasukanPerKategori[namaKategori] ?? 0) + nominal;
        }
      }

      // Lakukan pengurutan berdasarkan nilai pemasukan dari terbesar ke terkecil
      final sortedEntries = pemasukanPerKategori.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final Map<String, int> sortedPemasukanPerKategori =
          Map.fromEntries(sortedEntries);

      return sortedPemasukanPerKategori;
    });
  }

  Future<List<TransaksiWithKategori>> searchTransaksi(String keyword) async {
    final query = (select(transaksi).join(
        [innerJoin(kategori, kategori.id.equalsExp(transaksi.kategori_id))])
      ..where(transaksi.detail.like('%$keyword%')));

    final rows = await query.get();

    return rows.map((row) {
      return TransaksiWithKategori(
          row.readTable(transaksi), row.readTable(kategori));
    }).toList();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
