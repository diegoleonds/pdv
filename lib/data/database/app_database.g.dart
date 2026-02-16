// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductEntityTable extends ProductEntity
    with TableInfo<$ProductEntityTable, Products> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceCentsMeta = const VerificationMeta(
    'priceCents',
  );
  @override
  late final GeneratedColumn<int> priceCents = GeneratedColumn<int>(
    'price_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, priceCents];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<Products> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_cents')) {
      context.handle(
        _priceCentsMeta,
        priceCents.isAcceptableOrUnknown(data['price_cents']!, _priceCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_priceCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Products map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Products(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_cents'],
      )!,
    );
  }

  @override
  $ProductEntityTable createAlias(String alias) {
    return $ProductEntityTable(attachedDatabase, alias);
  }
}

class Products extends DataClass implements Insertable<Products> {
  final int id;
  final String name;
  final int priceCents;
  const Products({
    required this.id,
    required this.name,
    required this.priceCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['price_cents'] = Variable<int>(priceCents);
    return map;
  }

  ProductEntityCompanion toCompanion(bool nullToAbsent) {
    return ProductEntityCompanion(
      id: Value(id),
      name: Value(name),
      priceCents: Value(priceCents),
    );
  }

  factory Products.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Products(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      priceCents: serializer.fromJson<int>(json['priceCents']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'priceCents': serializer.toJson<int>(priceCents),
    };
  }

  Products copyWith({int? id, String? name, int? priceCents}) => Products(
    id: id ?? this.id,
    name: name ?? this.name,
    priceCents: priceCents ?? this.priceCents,
  );
  Products copyWithCompanion(ProductEntityCompanion data) {
    return Products(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      priceCents: data.priceCents.present
          ? data.priceCents.value
          : this.priceCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Products(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceCents: $priceCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, priceCents);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Products &&
          other.id == this.id &&
          other.name == this.name &&
          other.priceCents == this.priceCents);
}

class ProductEntityCompanion extends UpdateCompanion<Products> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> priceCents;
  const ProductEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.priceCents = const Value.absent(),
  });
  ProductEntityCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int priceCents,
  }) : name = Value(name),
       priceCents = Value(priceCents);
  static Insertable<Products> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? priceCents,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (priceCents != null) 'price_cents': priceCents,
    });
  }

  ProductEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? priceCents,
  }) {
    return ProductEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      priceCents: priceCents ?? this.priceCents,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceCents.present) {
      map['price_cents'] = Variable<int>(priceCents.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceCents: $priceCents')
          ..write(')'))
        .toString();
  }
}

class $OrderEntityTable extends OrderEntity
    with TableInfo<$OrderEntityTable, Orders> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _totalCentsMeta = const VerificationMeta(
    'totalCents',
  );
  @override
  late final GeneratedColumn<int> totalCents = GeneratedColumn<int>(
    'total_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTotalCentsMeta = const VerificationMeta(
    'subTotalCents',
  );
  @override
  late final GeneratedColumn<int> subTotalCents = GeneratedColumn<int>(
    'sub_total_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountCentsMeta = const VerificationMeta(
    'discountCents',
  );
  @override
  late final GeneratedColumn<int> discountCents = GeneratedColumn<int>(
    'discount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceFeeCentsMeta = const VerificationMeta(
    'serviceFeeCents',
  );
  @override
  late final GeneratedColumn<int> serviceFeeCents = GeneratedColumn<int>(
    'service_fee_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<OrderStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<OrderStatus>($OrderEntityTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, int>
  paymentMethod = GeneratedColumn<int>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<PaymentMethod>($OrderEntityTable.$converterpaymentMethod);
  static const VerificationMeta _authCodeMeta = const VerificationMeta(
    'authCode',
  );
  @override
  late final GeneratedColumn<String> authCode = GeneratedColumn<String>(
    'auth_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idempotencyKey,
    totalCents,
    subTotalCents,
    discountCents,
    serviceFeeCents,
    status,
    paymentMethod,
    authCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<Orders> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('total_cents')) {
      context.handle(
        _totalCentsMeta,
        totalCents.isAcceptableOrUnknown(data['total_cents']!, _totalCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCentsMeta);
    }
    if (data.containsKey('sub_total_cents')) {
      context.handle(
        _subTotalCentsMeta,
        subTotalCents.isAcceptableOrUnknown(
          data['sub_total_cents']!,
          _subTotalCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subTotalCentsMeta);
    }
    if (data.containsKey('discount_cents')) {
      context.handle(
        _discountCentsMeta,
        discountCents.isAcceptableOrUnknown(
          data['discount_cents']!,
          _discountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountCentsMeta);
    }
    if (data.containsKey('service_fee_cents')) {
      context.handle(
        _serviceFeeCentsMeta,
        serviceFeeCents.isAcceptableOrUnknown(
          data['service_fee_cents']!,
          _serviceFeeCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceFeeCentsMeta);
    }
    if (data.containsKey('auth_code')) {
      context.handle(
        _authCodeMeta,
        authCode.isAcceptableOrUnknown(data['auth_code']!, _authCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_authCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Orders map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Orders(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      totalCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cents'],
      )!,
      subTotalCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_total_cents'],
      )!,
      discountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_cents'],
      )!,
      serviceFeeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}service_fee_cents'],
      )!,
      status: $OrderEntityTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      paymentMethod: $OrderEntityTable.$converterpaymentMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}payment_method'],
        )!,
      ),
      authCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_code'],
      )!,
    );
  }

  @override
  $OrderEntityTable createAlias(String alias) {
    return $OrderEntityTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OrderStatus, int, int> $converterstatus =
      const EnumIndexConverter<OrderStatus>(OrderStatus.values);
  static JsonTypeConverter2<PaymentMethod, int, int> $converterpaymentMethod =
      const EnumIndexConverter<PaymentMethod>(PaymentMethod.values);
}

class Orders extends DataClass implements Insertable<Orders> {
  final int id;
  final String idempotencyKey;
  final int totalCents;
  final int subTotalCents;
  final int discountCents;
  final int serviceFeeCents;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final String authCode;
  const Orders({
    required this.id,
    required this.idempotencyKey,
    required this.totalCents,
    required this.subTotalCents,
    required this.discountCents,
    required this.serviceFeeCents,
    required this.status,
    required this.paymentMethod,
    required this.authCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['total_cents'] = Variable<int>(totalCents);
    map['sub_total_cents'] = Variable<int>(subTotalCents);
    map['discount_cents'] = Variable<int>(discountCents);
    map['service_fee_cents'] = Variable<int>(serviceFeeCents);
    {
      map['status'] = Variable<int>(
        $OrderEntityTable.$converterstatus.toSql(status),
      );
    }
    {
      map['payment_method'] = Variable<int>(
        $OrderEntityTable.$converterpaymentMethod.toSql(paymentMethod),
      );
    }
    map['auth_code'] = Variable<String>(authCode);
    return map;
  }

  OrderEntityCompanion toCompanion(bool nullToAbsent) {
    return OrderEntityCompanion(
      id: Value(id),
      idempotencyKey: Value(idempotencyKey),
      totalCents: Value(totalCents),
      subTotalCents: Value(subTotalCents),
      discountCents: Value(discountCents),
      serviceFeeCents: Value(serviceFeeCents),
      status: Value(status),
      paymentMethod: Value(paymentMethod),
      authCode: Value(authCode),
    );
  }

  factory Orders.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Orders(
      id: serializer.fromJson<int>(json['id']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      totalCents: serializer.fromJson<int>(json['totalCents']),
      subTotalCents: serializer.fromJson<int>(json['subTotalCents']),
      discountCents: serializer.fromJson<int>(json['discountCents']),
      serviceFeeCents: serializer.fromJson<int>(json['serviceFeeCents']),
      status: $OrderEntityTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      paymentMethod: $OrderEntityTable.$converterpaymentMethod.fromJson(
        serializer.fromJson<int>(json['paymentMethod']),
      ),
      authCode: serializer.fromJson<String>(json['authCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'totalCents': serializer.toJson<int>(totalCents),
      'subTotalCents': serializer.toJson<int>(subTotalCents),
      'discountCents': serializer.toJson<int>(discountCents),
      'serviceFeeCents': serializer.toJson<int>(serviceFeeCents),
      'status': serializer.toJson<int>(
        $OrderEntityTable.$converterstatus.toJson(status),
      ),
      'paymentMethod': serializer.toJson<int>(
        $OrderEntityTable.$converterpaymentMethod.toJson(paymentMethod),
      ),
      'authCode': serializer.toJson<String>(authCode),
    };
  }

  Orders copyWith({
    int? id,
    String? idempotencyKey,
    int? totalCents,
    int? subTotalCents,
    int? discountCents,
    int? serviceFeeCents,
    OrderStatus? status,
    PaymentMethod? paymentMethod,
    String? authCode,
  }) => Orders(
    id: id ?? this.id,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    totalCents: totalCents ?? this.totalCents,
    subTotalCents: subTotalCents ?? this.subTotalCents,
    discountCents: discountCents ?? this.discountCents,
    serviceFeeCents: serviceFeeCents ?? this.serviceFeeCents,
    status: status ?? this.status,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    authCode: authCode ?? this.authCode,
  );
  Orders copyWithCompanion(OrderEntityCompanion data) {
    return Orders(
      id: data.id.present ? data.id.value : this.id,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      totalCents: data.totalCents.present
          ? data.totalCents.value
          : this.totalCents,
      subTotalCents: data.subTotalCents.present
          ? data.subTotalCents.value
          : this.subTotalCents,
      discountCents: data.discountCents.present
          ? data.discountCents.value
          : this.discountCents,
      serviceFeeCents: data.serviceFeeCents.present
          ? data.serviceFeeCents.value
          : this.serviceFeeCents,
      status: data.status.present ? data.status.value : this.status,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      authCode: data.authCode.present ? data.authCode.value : this.authCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Orders(')
          ..write('id: $id, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('totalCents: $totalCents, ')
          ..write('subTotalCents: $subTotalCents, ')
          ..write('discountCents: $discountCents, ')
          ..write('serviceFeeCents: $serviceFeeCents, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('authCode: $authCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idempotencyKey,
    totalCents,
    subTotalCents,
    discountCents,
    serviceFeeCents,
    status,
    paymentMethod,
    authCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orders &&
          other.id == this.id &&
          other.idempotencyKey == this.idempotencyKey &&
          other.totalCents == this.totalCents &&
          other.subTotalCents == this.subTotalCents &&
          other.discountCents == this.discountCents &&
          other.serviceFeeCents == this.serviceFeeCents &&
          other.status == this.status &&
          other.paymentMethod == this.paymentMethod &&
          other.authCode == this.authCode);
}

class OrderEntityCompanion extends UpdateCompanion<Orders> {
  final Value<int> id;
  final Value<String> idempotencyKey;
  final Value<int> totalCents;
  final Value<int> subTotalCents;
  final Value<int> discountCents;
  final Value<int> serviceFeeCents;
  final Value<OrderStatus> status;
  final Value<PaymentMethod> paymentMethod;
  final Value<String> authCode;
  const OrderEntityCompanion({
    this.id = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.totalCents = const Value.absent(),
    this.subTotalCents = const Value.absent(),
    this.discountCents = const Value.absent(),
    this.serviceFeeCents = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.authCode = const Value.absent(),
  });
  OrderEntityCompanion.insert({
    this.id = const Value.absent(),
    required String idempotencyKey,
    required int totalCents,
    required int subTotalCents,
    required int discountCents,
    required int serviceFeeCents,
    required OrderStatus status,
    required PaymentMethod paymentMethod,
    required String authCode,
  }) : idempotencyKey = Value(idempotencyKey),
       totalCents = Value(totalCents),
       subTotalCents = Value(subTotalCents),
       discountCents = Value(discountCents),
       serviceFeeCents = Value(serviceFeeCents),
       status = Value(status),
       paymentMethod = Value(paymentMethod),
       authCode = Value(authCode);
  static Insertable<Orders> custom({
    Expression<int>? id,
    Expression<String>? idempotencyKey,
    Expression<int>? totalCents,
    Expression<int>? subTotalCents,
    Expression<int>? discountCents,
    Expression<int>? serviceFeeCents,
    Expression<int>? status,
    Expression<int>? paymentMethod,
    Expression<String>? authCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (totalCents != null) 'total_cents': totalCents,
      if (subTotalCents != null) 'sub_total_cents': subTotalCents,
      if (discountCents != null) 'discount_cents': discountCents,
      if (serviceFeeCents != null) 'service_fee_cents': serviceFeeCents,
      if (status != null) 'status': status,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (authCode != null) 'auth_code': authCode,
    });
  }

  OrderEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? idempotencyKey,
    Value<int>? totalCents,
    Value<int>? subTotalCents,
    Value<int>? discountCents,
    Value<int>? serviceFeeCents,
    Value<OrderStatus>? status,
    Value<PaymentMethod>? paymentMethod,
    Value<String>? authCode,
  }) {
    return OrderEntityCompanion(
      id: id ?? this.id,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      totalCents: totalCents ?? this.totalCents,
      subTotalCents: subTotalCents ?? this.subTotalCents,
      discountCents: discountCents ?? this.discountCents,
      serviceFeeCents: serviceFeeCents ?? this.serviceFeeCents,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      authCode: authCode ?? this.authCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (totalCents.present) {
      map['total_cents'] = Variable<int>(totalCents.value);
    }
    if (subTotalCents.present) {
      map['sub_total_cents'] = Variable<int>(subTotalCents.value);
    }
    if (discountCents.present) {
      map['discount_cents'] = Variable<int>(discountCents.value);
    }
    if (serviceFeeCents.present) {
      map['service_fee_cents'] = Variable<int>(serviceFeeCents.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $OrderEntityTable.$converterstatus.toSql(status.value),
      );
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(
        $OrderEntityTable.$converterpaymentMethod.toSql(paymentMethod.value),
      );
    }
    if (authCode.present) {
      map['auth_code'] = Variable<String>(authCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderEntityCompanion(')
          ..write('id: $id, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('totalCents: $totalCents, ')
          ..write('subTotalCents: $subTotalCents, ')
          ..write('discountCents: $discountCents, ')
          ..write('serviceFeeCents: $serviceFeeCents, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('authCode: $authCode')
          ..write(')'))
        .toString();
  }
}

class $CartItemEntityTable extends CartItemEntity
    with TableInfo<$CartItemEntityTable, CartItems> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES order_entity (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_entity (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    productId,
    quantity,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_item_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItems> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItems map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItems(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
    );
  }

  @override
  $CartItemEntityTable createAlias(String alias) {
    return $CartItemEntityTable(attachedDatabase, alias);
  }
}

class CartItems extends DataClass implements Insertable<CartItems> {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final int subtotal;
  const CartItems({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['subtotal'] = Variable<int>(subtotal);
    return map;
  }

  CartItemEntityCompanion toCompanion(bool nullToAbsent) {
    return CartItemEntityCompanion(
      id: Value(id),
      orderId: Value(orderId),
      productId: Value(productId),
      quantity: Value(quantity),
      subtotal: Value(subtotal),
    );
  }

  factory CartItems.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItems(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'subtotal': serializer.toJson<int>(subtotal),
    };
  }

  CartItems copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    int? subtotal,
  }) => CartItems(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    subtotal: subtotal ?? this.subtotal,
  );
  CartItems copyWithCompanion(CartItemEntityCompanion data) {
    return CartItems(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItems(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, productId, quantity, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItems &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.subtotal == this.subtotal);
}

class CartItemEntityCompanion extends UpdateCompanion<CartItems> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<int> subtotal;
  const CartItemEntityCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  CartItemEntityCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int productId,
    required int quantity,
    required int subtotal,
  }) : orderId = Value(orderId),
       productId = Value(productId),
       quantity = Value(quantity),
       subtotal = Value(subtotal);
  static Insertable<CartItems> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<int>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  CartItemEntityCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<int>? productId,
    Value<int>? quantity,
    Value<int>? subtotal,
  }) {
    return CartItemEntityCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemEntityCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductEntityTable productEntity = $ProductEntityTable(this);
  late final $OrderEntityTable orderEntity = $OrderEntityTable(this);
  late final $CartItemEntityTable cartItemEntity = $CartItemEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productEntity,
    orderEntity,
    cartItemEntity,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'order_entity',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cart_item_entity', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProductEntityTableCreateCompanionBuilder =
    ProductEntityCompanion Function({
      Value<int> id,
      required String name,
      required int priceCents,
    });
typedef $$ProductEntityTableUpdateCompanionBuilder =
    ProductEntityCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> priceCents,
    });

final class $$ProductEntityTableReferences
    extends BaseReferences<_$AppDatabase, $ProductEntityTable, Products> {
  $$ProductEntityTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CartItemEntityTable, List<CartItems>>
  _cartItemEntityRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cartItemEntity,
    aliasName: $_aliasNameGenerator(
      db.productEntity.id,
      db.cartItemEntity.productId,
    ),
  );

  $$CartItemEntityTableProcessedTableManager get cartItemEntityRefs {
    final manager = $$CartItemEntityTableTableManager(
      $_db,
      $_db.cartItemEntity,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cartItemEntityRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ProductEntityTable> {
  $$ProductEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cartItemEntityRefs(
    Expression<bool> Function($$CartItemEntityTableFilterComposer f) f,
  ) {
    final $$CartItemEntityTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemEntity,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemEntityTableFilterComposer(
            $db: $db,
            $table: $db.cartItemEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductEntityTable> {
  $$ProductEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductEntityTable> {
  $$ProductEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => column,
  );

  Expression<T> cartItemEntityRefs<T extends Object>(
    Expression<T> Function($$CartItemEntityTableAnnotationComposer a) f,
  ) {
    final $$CartItemEntityTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemEntity,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemEntityTableAnnotationComposer(
            $db: $db,
            $table: $db.cartItemEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductEntityTable,
          Products,
          $$ProductEntityTableFilterComposer,
          $$ProductEntityTableOrderingComposer,
          $$ProductEntityTableAnnotationComposer,
          $$ProductEntityTableCreateCompanionBuilder,
          $$ProductEntityTableUpdateCompanionBuilder,
          (Products, $$ProductEntityTableReferences),
          Products,
          PrefetchHooks Function({bool cartItemEntityRefs})
        > {
  $$ProductEntityTableTableManager(_$AppDatabase db, $ProductEntityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceCents = const Value.absent(),
              }) => ProductEntityCompanion(
                id: id,
                name: name,
                priceCents: priceCents,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int priceCents,
              }) => ProductEntityCompanion.insert(
                id: id,
                name: name,
                priceCents: priceCents,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductEntityTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cartItemEntityRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cartItemEntityRefs) db.cartItemEntity,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cartItemEntityRefs)
                    await $_getPrefetchedData<
                      Products,
                      $ProductEntityTable,
                      CartItems
                    >(
                      currentTable: table,
                      referencedTable: $$ProductEntityTableReferences
                          ._cartItemEntityRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductEntityTableReferences(
                            db,
                            table,
                            p0,
                          ).cartItemEntityRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductEntityTable,
      Products,
      $$ProductEntityTableFilterComposer,
      $$ProductEntityTableOrderingComposer,
      $$ProductEntityTableAnnotationComposer,
      $$ProductEntityTableCreateCompanionBuilder,
      $$ProductEntityTableUpdateCompanionBuilder,
      (Products, $$ProductEntityTableReferences),
      Products,
      PrefetchHooks Function({bool cartItemEntityRefs})
    >;
typedef $$OrderEntityTableCreateCompanionBuilder =
    OrderEntityCompanion Function({
      Value<int> id,
      required String idempotencyKey,
      required int totalCents,
      required int subTotalCents,
      required int discountCents,
      required int serviceFeeCents,
      required OrderStatus status,
      required PaymentMethod paymentMethod,
      required String authCode,
    });
typedef $$OrderEntityTableUpdateCompanionBuilder =
    OrderEntityCompanion Function({
      Value<int> id,
      Value<String> idempotencyKey,
      Value<int> totalCents,
      Value<int> subTotalCents,
      Value<int> discountCents,
      Value<int> serviceFeeCents,
      Value<OrderStatus> status,
      Value<PaymentMethod> paymentMethod,
      Value<String> authCode,
    });

final class $$OrderEntityTableReferences
    extends BaseReferences<_$AppDatabase, $OrderEntityTable, Orders> {
  $$OrderEntityTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CartItemEntityTable, List<CartItems>>
  _cartItemEntityRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cartItemEntity,
    aliasName: $_aliasNameGenerator(
      db.orderEntity.id,
      db.cartItemEntity.orderId,
    ),
  );

  $$CartItemEntityTableProcessedTableManager get cartItemEntityRefs {
    final manager = $$CartItemEntityTableTableManager(
      $_db,
      $_db.cartItemEntity,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cartItemEntityRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrderEntityTableFilterComposer
    extends Composer<_$AppDatabase, $OrderEntityTable> {
  $$OrderEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subTotalCents => $composableBuilder(
    column: $table.subTotalCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountCents => $composableBuilder(
    column: $table.discountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serviceFeeCents => $composableBuilder(
    column: $table.serviceFeeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OrderStatus, OrderStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, int>
  get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get authCode => $composableBuilder(
    column: $table.authCode,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cartItemEntityRefs(
    Expression<bool> Function($$CartItemEntityTableFilterComposer f) f,
  ) {
    final $$CartItemEntityTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemEntity,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemEntityTableFilterComposer(
            $db: $db,
            $table: $db.cartItemEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrderEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderEntityTable> {
  $$OrderEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subTotalCents => $composableBuilder(
    column: $table.subTotalCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountCents => $composableBuilder(
    column: $table.discountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serviceFeeCents => $composableBuilder(
    column: $table.serviceFeeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authCode => $composableBuilder(
    column: $table.authCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderEntityTable> {
  $$OrderEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subTotalCents => $composableBuilder(
    column: $table.subTotalCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountCents => $composableBuilder(
    column: $table.discountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serviceFeeCents => $composableBuilder(
    column: $table.serviceFeeCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<OrderStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, int> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => column,
      );

  GeneratedColumn<String> get authCode =>
      $composableBuilder(column: $table.authCode, builder: (column) => column);

  Expression<T> cartItemEntityRefs<T extends Object>(
    Expression<T> Function($$CartItemEntityTableAnnotationComposer a) f,
  ) {
    final $$CartItemEntityTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemEntity,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemEntityTableAnnotationComposer(
            $db: $db,
            $table: $db.cartItemEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrderEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderEntityTable,
          Orders,
          $$OrderEntityTableFilterComposer,
          $$OrderEntityTableOrderingComposer,
          $$OrderEntityTableAnnotationComposer,
          $$OrderEntityTableCreateCompanionBuilder,
          $$OrderEntityTableUpdateCompanionBuilder,
          (Orders, $$OrderEntityTableReferences),
          Orders,
          PrefetchHooks Function({bool cartItemEntityRefs})
        > {
  $$OrderEntityTableTableManager(_$AppDatabase db, $OrderEntityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<int> totalCents = const Value.absent(),
                Value<int> subTotalCents = const Value.absent(),
                Value<int> discountCents = const Value.absent(),
                Value<int> serviceFeeCents = const Value.absent(),
                Value<OrderStatus> status = const Value.absent(),
                Value<PaymentMethod> paymentMethod = const Value.absent(),
                Value<String> authCode = const Value.absent(),
              }) => OrderEntityCompanion(
                id: id,
                idempotencyKey: idempotencyKey,
                totalCents: totalCents,
                subTotalCents: subTotalCents,
                discountCents: discountCents,
                serviceFeeCents: serviceFeeCents,
                status: status,
                paymentMethod: paymentMethod,
                authCode: authCode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String idempotencyKey,
                required int totalCents,
                required int subTotalCents,
                required int discountCents,
                required int serviceFeeCents,
                required OrderStatus status,
                required PaymentMethod paymentMethod,
                required String authCode,
              }) => OrderEntityCompanion.insert(
                id: id,
                idempotencyKey: idempotencyKey,
                totalCents: totalCents,
                subTotalCents: subTotalCents,
                discountCents: discountCents,
                serviceFeeCents: serviceFeeCents,
                status: status,
                paymentMethod: paymentMethod,
                authCode: authCode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderEntityTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cartItemEntityRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cartItemEntityRefs) db.cartItemEntity,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cartItemEntityRefs)
                    await $_getPrefetchedData<
                      Orders,
                      $OrderEntityTable,
                      CartItems
                    >(
                      currentTable: table,
                      referencedTable: $$OrderEntityTableReferences
                          ._cartItemEntityRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$OrderEntityTableReferences(
                            db,
                            table,
                            p0,
                          ).cartItemEntityRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.orderId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$OrderEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderEntityTable,
      Orders,
      $$OrderEntityTableFilterComposer,
      $$OrderEntityTableOrderingComposer,
      $$OrderEntityTableAnnotationComposer,
      $$OrderEntityTableCreateCompanionBuilder,
      $$OrderEntityTableUpdateCompanionBuilder,
      (Orders, $$OrderEntityTableReferences),
      Orders,
      PrefetchHooks Function({bool cartItemEntityRefs})
    >;
typedef $$CartItemEntityTableCreateCompanionBuilder =
    CartItemEntityCompanion Function({
      Value<int> id,
      required int orderId,
      required int productId,
      required int quantity,
      required int subtotal,
    });
typedef $$CartItemEntityTableUpdateCompanionBuilder =
    CartItemEntityCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<int> productId,
      Value<int> quantity,
      Value<int> subtotal,
    });

final class $$CartItemEntityTableReferences
    extends BaseReferences<_$AppDatabase, $CartItemEntityTable, CartItems> {
  $$CartItemEntityTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrderEntityTable _orderIdTable(_$AppDatabase db) =>
      db.orderEntity.createAlias(
        $_aliasNameGenerator(db.cartItemEntity.orderId, db.orderEntity.id),
      );

  $$OrderEntityTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrderEntityTableTableManager(
      $_db,
      $_db.orderEntity,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductEntityTable _productIdTable(_$AppDatabase db) =>
      db.productEntity.createAlias(
        $_aliasNameGenerator(db.cartItemEntity.productId, db.productEntity.id),
      );

  $$ProductEntityTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductEntityTableTableManager(
      $_db,
      $_db.productEntity,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CartItemEntityTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemEntityTable> {
  $$CartItemEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  $$OrderEntityTableFilterComposer get orderId {
    final $$OrderEntityTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orderEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderEntityTableFilterComposer(
            $db: $db,
            $table: $db.orderEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductEntityTableFilterComposer get productId {
    final $$ProductEntityTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductEntityTableFilterComposer(
            $db: $db,
            $table: $db.productEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemEntityTable> {
  $$CartItemEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrderEntityTableOrderingComposer get orderId {
    final $$OrderEntityTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orderEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderEntityTableOrderingComposer(
            $db: $db,
            $table: $db.orderEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductEntityTableOrderingComposer get productId {
    final $$ProductEntityTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductEntityTableOrderingComposer(
            $db: $db,
            $table: $db.productEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemEntityTable> {
  $$CartItemEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  $$OrderEntityTableAnnotationComposer get orderId {
    final $$OrderEntityTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orderEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderEntityTableAnnotationComposer(
            $db: $db,
            $table: $db.orderEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductEntityTableAnnotationComposer get productId {
    final $$ProductEntityTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productEntity,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductEntityTableAnnotationComposer(
            $db: $db,
            $table: $db.productEntity,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemEntityTable,
          CartItems,
          $$CartItemEntityTableFilterComposer,
          $$CartItemEntityTableOrderingComposer,
          $$CartItemEntityTableAnnotationComposer,
          $$CartItemEntityTableCreateCompanionBuilder,
          $$CartItemEntityTableUpdateCompanionBuilder,
          (CartItems, $$CartItemEntityTableReferences),
          CartItems,
          PrefetchHooks Function({bool orderId, bool productId})
        > {
  $$CartItemEntityTableTableManager(
    _$AppDatabase db,
    $CartItemEntityTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
              }) => CartItemEntityCompanion(
                id: id,
                orderId: orderId,
                productId: productId,
                quantity: quantity,
                subtotal: subtotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required int productId,
                required int quantity,
                required int subtotal,
              }) => CartItemEntityCompanion.insert(
                id: id,
                orderId: orderId,
                productId: productId,
                quantity: quantity,
                subtotal: subtotal,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CartItemEntityTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$CartItemEntityTableReferences
                                    ._orderIdTable(db),
                                referencedColumn:
                                    $$CartItemEntityTableReferences
                                        ._orderIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$CartItemEntityTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$CartItemEntityTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CartItemEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemEntityTable,
      CartItems,
      $$CartItemEntityTableFilterComposer,
      $$CartItemEntityTableOrderingComposer,
      $$CartItemEntityTableAnnotationComposer,
      $$CartItemEntityTableCreateCompanionBuilder,
      $$CartItemEntityTableUpdateCompanionBuilder,
      (CartItems, $$CartItemEntityTableReferences),
      CartItems,
      PrefetchHooks Function({bool orderId, bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductEntityTableTableManager get productEntity =>
      $$ProductEntityTableTableManager(_db, _db.productEntity);
  $$OrderEntityTableTableManager get orderEntity =>
      $$OrderEntityTableTableManager(_db, _db.orderEntity);
  $$CartItemEntityTableTableManager get cartItemEntity =>
      $$CartItemEntityTableTableManager(_db, _db.cartItemEntity);
}
