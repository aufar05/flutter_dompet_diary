import 'package:drift/drift.dart';

@DataClassName('NKategori')
class Kategori extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text().withLength(max: 20)();
  IntColumn get tipe => integer()();
  TextColumn get iconDataString => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
