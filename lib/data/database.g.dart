// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $KategoriTable extends Kategori
    with TableInfo<$KategoriTable, NKategori> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KategoriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
      'nama', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<int> tipe = GeneratedColumn<int>(
      'tipe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconDataStringMeta =
      const VerificationMeta('iconDataString');
  @override
  late final GeneratedColumn<String> iconDataString = GeneratedColumn<String>(
      'icon_data_string', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nama, tipe, iconDataString, createdAt, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? 'kategori';
  @override
  String get actualTableName => 'kategori';
  @override
  VerificationContext validateIntegrity(Insertable<NKategori> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
          _namaMeta, nama.isAcceptableOrUnknown(data['nama']!, _namaMeta));
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('tipe')) {
      context.handle(
          _tipeMeta, tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta));
    } else if (isInserting) {
      context.missing(_tipeMeta);
    }
    if (data.containsKey('icon_data_string')) {
      context.handle(
          _iconDataStringMeta,
          iconDataString.isAcceptableOrUnknown(
              data['icon_data_string']!, _iconDataStringMeta));
    } else if (isInserting) {
      context.missing(_iconDataStringMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NKategori map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NKategori(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nama: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama'])!,
      tipe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipe'])!,
      iconDataString: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}icon_data_string'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $KategoriTable createAlias(String alias) {
    return $KategoriTable(attachedDatabase, alias);
  }
}

class NKategori extends DataClass implements Insertable<NKategori> {
  final int id;
  final String nama;
  final int tipe;
  final String iconDataString;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const NKategori(
      {required this.id,
      required this.nama,
      required this.tipe,
      required this.iconDataString,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['tipe'] = Variable<int>(tipe);
    map['icon_data_string'] = Variable<String>(iconDataString);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  KategoriCompanion toCompanion(bool nullToAbsent) {
    return KategoriCompanion(
      id: Value(id),
      nama: Value(nama),
      tipe: Value(tipe),
      iconDataString: Value(iconDataString),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory NKategori.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NKategori(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      tipe: serializer.fromJson<int>(json['tipe']),
      iconDataString: serializer.fromJson<String>(json['iconDataString']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'tipe': serializer.toJson<int>(tipe),
      'iconDataString': serializer.toJson<String>(iconDataString),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  NKategori copyWith(
          {int? id,
          String? nama,
          int? tipe,
          String? iconDataString,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      NKategori(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        tipe: tipe ?? this.tipe,
        iconDataString: iconDataString ?? this.iconDataString,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('NKategori(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('tipe: $tipe, ')
          ..write('iconDataString: $iconDataString, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nama, tipe, iconDataString, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NKategori &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.tipe == this.tipe &&
          other.iconDataString == this.iconDataString &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class KategoriCompanion extends UpdateCompanion<NKategori> {
  final Value<int> id;
  final Value<String> nama;
  final Value<int> tipe;
  final Value<String> iconDataString;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const KategoriCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.tipe = const Value.absent(),
    this.iconDataString = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  KategoriCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required int tipe,
    required String iconDataString,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
  })  : nama = Value(nama),
        tipe = Value(tipe),
        iconDataString = Value(iconDataString),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<NKategori> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<int>? tipe,
    Expression<String>? iconDataString,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (tipe != null) 'tipe': tipe,
      if (iconDataString != null) 'icon_data_string': iconDataString,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  KategoriCompanion copyWith(
      {Value<int>? id,
      Value<String>? nama,
      Value<int>? tipe,
      Value<String>? iconDataString,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return KategoriCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      tipe: tipe ?? this.tipe,
      iconDataString: iconDataString ?? this.iconDataString,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<int>(tipe.value);
    }
    if (iconDataString.present) {
      map['icon_data_string'] = Variable<String>(iconDataString.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KategoriCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('tipe: $tipe, ')
          ..write('iconDataString: $iconDataString, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $TransaksiTable extends Transaksi
    with TableInfo<$TransaksiTable, TransaksiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaksiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _kategori_idMeta =
      const VerificationMeta('kategori_id');
  @override
  late final GeneratedColumn<int> kategori_id = GeneratedColumn<int>(
      'kategori_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nominalMeta =
      const VerificationMeta('nominal');
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
      'nominal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tanggal_transaksiMeta =
      const VerificationMeta('tanggal_transaksi');
  @override
  late final GeneratedColumn<DateTime> tanggal_transaksi =
      GeneratedColumn<DateTime>('tanggal_transaksi', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        detail,
        kategori_id,
        nominal,
        tanggal_transaksi,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? 'transaksi';
  @override
  String get actualTableName => 'transaksi';
  @override
  VerificationContext validateIntegrity(Insertable<TransaksiData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    if (data.containsKey('kategori_id')) {
      context.handle(
          _kategori_idMeta,
          kategori_id.isAcceptableOrUnknown(
              data['kategori_id']!, _kategori_idMeta));
    } else if (isInserting) {
      context.missing(_kategori_idMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(_nominalMeta,
          nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta));
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('tanggal_transaksi')) {
      context.handle(
          _tanggal_transaksiMeta,
          tanggal_transaksi.isAcceptableOrUnknown(
              data['tanggal_transaksi']!, _tanggal_transaksiMeta));
    } else if (isInserting) {
      context.missing(_tanggal_transaksiMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransaksiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransaksiData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      detail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail'])!,
      kategori_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kategori_id'])!,
      nominal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nominal'])!,
      tanggal_transaksi: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}tanggal_transaksi'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TransaksiTable createAlias(String alias) {
    return $TransaksiTable(attachedDatabase, alias);
  }
}

class TransaksiData extends DataClass implements Insertable<TransaksiData> {
  final int id;
  final String detail;
  final int kategori_id;
  final int nominal;
  final DateTime tanggal_transaksi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TransaksiData(
      {required this.id,
      required this.detail,
      required this.kategori_id,
      required this.nominal,
      required this.tanggal_transaksi,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['detail'] = Variable<String>(detail);
    map['kategori_id'] = Variable<int>(kategori_id);
    map['nominal'] = Variable<int>(nominal);
    map['tanggal_transaksi'] = Variable<DateTime>(tanggal_transaksi);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TransaksiCompanion toCompanion(bool nullToAbsent) {
    return TransaksiCompanion(
      id: Value(id),
      detail: Value(detail),
      kategori_id: Value(kategori_id),
      nominal: Value(nominal),
      tanggal_transaksi: Value(tanggal_transaksi),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TransaksiData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransaksiData(
      id: serializer.fromJson<int>(json['id']),
      detail: serializer.fromJson<String>(json['detail']),
      kategori_id: serializer.fromJson<int>(json['kategori_id']),
      nominal: serializer.fromJson<int>(json['nominal']),
      tanggal_transaksi:
          serializer.fromJson<DateTime>(json['tanggal_transaksi']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'detail': serializer.toJson<String>(detail),
      'kategori_id': serializer.toJson<int>(kategori_id),
      'nominal': serializer.toJson<int>(nominal),
      'tanggal_transaksi': serializer.toJson<DateTime>(tanggal_transaksi),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TransaksiData copyWith(
          {int? id,
          String? detail,
          int? kategori_id,
          int? nominal,
          DateTime? tanggal_transaksi,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TransaksiData(
        id: id ?? this.id,
        detail: detail ?? this.detail,
        kategori_id: kategori_id ?? this.kategori_id,
        nominal: nominal ?? this.nominal,
        tanggal_transaksi: tanggal_transaksi ?? this.tanggal_transaksi,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('TransaksiData(')
          ..write('id: $id, ')
          ..write('detail: $detail, ')
          ..write('kategori_id: $kategori_id, ')
          ..write('nominal: $nominal, ')
          ..write('tanggal_transaksi: $tanggal_transaksi, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, detail, kategori_id, nominal,
      tanggal_transaksi, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransaksiData &&
          other.id == this.id &&
          other.detail == this.detail &&
          other.kategori_id == this.kategori_id &&
          other.nominal == this.nominal &&
          other.tanggal_transaksi == this.tanggal_transaksi &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TransaksiCompanion extends UpdateCompanion<TransaksiData> {
  final Value<int> id;
  final Value<String> detail;
  final Value<int> kategori_id;
  final Value<int> nominal;
  final Value<DateTime> tanggal_transaksi;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const TransaksiCompanion({
    this.id = const Value.absent(),
    this.detail = const Value.absent(),
    this.kategori_id = const Value.absent(),
    this.nominal = const Value.absent(),
    this.tanggal_transaksi = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  TransaksiCompanion.insert({
    this.id = const Value.absent(),
    required String detail,
    required int kategori_id,
    required int nominal,
    required DateTime tanggal_transaksi,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
  })  : detail = Value(detail),
        kategori_id = Value(kategori_id),
        nominal = Value(nominal),
        tanggal_transaksi = Value(tanggal_transaksi),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TransaksiData> custom({
    Expression<int>? id,
    Expression<String>? detail,
    Expression<int>? kategori_id,
    Expression<int>? nominal,
    Expression<DateTime>? tanggal_transaksi,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detail != null) 'detail': detail,
      if (kategori_id != null) 'kategori_id': kategori_id,
      if (nominal != null) 'nominal': nominal,
      if (tanggal_transaksi != null) 'tanggal_transaksi': tanggal_transaksi,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  TransaksiCompanion copyWith(
      {Value<int>? id,
      Value<String>? detail,
      Value<int>? kategori_id,
      Value<int>? nominal,
      Value<DateTime>? tanggal_transaksi,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return TransaksiCompanion(
      id: id ?? this.id,
      detail: detail ?? this.detail,
      kategori_id: kategori_id ?? this.kategori_id,
      nominal: nominal ?? this.nominal,
      tanggal_transaksi: tanggal_transaksi ?? this.tanggal_transaksi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (kategori_id.present) {
      map['kategori_id'] = Variable<int>(kategori_id.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (tanggal_transaksi.present) {
      map['tanggal_transaksi'] = Variable<DateTime>(tanggal_transaksi.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaksiCompanion(')
          ..write('id: $id, ')
          ..write('detail: $detail, ')
          ..write('kategori_id: $kategori_id, ')
          ..write('nominal: $nominal, ')
          ..write('tanggal_transaksi: $tanggal_transaksi, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $KategoriTable kategori = $KategoriTable(this);
  late final $TransaksiTable transaksi = $TransaksiTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [kategori, transaksi];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
