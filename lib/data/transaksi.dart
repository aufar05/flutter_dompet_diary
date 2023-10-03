// ignore_for_file: non_constant_identifier_names

import 'package:drift/drift.dart';

class Transaksi extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get detail => text().withLength(max: 128)();
  IntColumn get kategori_id => integer()();
  IntColumn get nominal => integer()();
  DateTimeColumn get tanggal_transaksi => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
