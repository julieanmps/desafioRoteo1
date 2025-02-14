import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShoppingCartRecord extends FirestoreRecord {
  ShoppingCartRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "product" field.
  DocumentReference? _product;
  DocumentReference? get product => _product;
  bool hasProduct() => _product != null;

  // "userid" field.
  DocumentReference? _userid;
  DocumentReference? get userid => _userid;
  bool hasUserid() => _userid != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "subtotal" field.
  double? _subtotal;
  double get subtotal => _subtotal ?? 0.0;
  bool hasSubtotal() => _subtotal != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "hash" field.
  String? _hash;
  String get hash => _hash ?? '';
  bool hasHash() => _hash != null;

  void _initializeFields() {
    _product = snapshotData['product'] as DocumentReference?;
    _userid = snapshotData['userid'] as DocumentReference?;
    _price = castToType<double>(snapshotData['price']);
    _subtotal = castToType<double>(snapshotData['subtotal']);
    _amount = castToType<int>(snapshotData['amount']);
    _hash = snapshotData['hash'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shopping_cart');

  static Stream<ShoppingCartRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ShoppingCartRecord.fromSnapshot(s));

  static Future<ShoppingCartRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ShoppingCartRecord.fromSnapshot(s));

  static ShoppingCartRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ShoppingCartRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ShoppingCartRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ShoppingCartRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ShoppingCartRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ShoppingCartRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createShoppingCartRecordData({
  DocumentReference? product,
  DocumentReference? userid,
  double? price,
  double? subtotal,
  int? amount,
  String? hash,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'product': product,
      'userid': userid,
      'price': price,
      'subtotal': subtotal,
      'amount': amount,
      'hash': hash,
    }.withoutNulls,
  );

  return firestoreData;
}

class ShoppingCartRecordDocumentEquality
    implements Equality<ShoppingCartRecord> {
  const ShoppingCartRecordDocumentEquality();

  @override
  bool equals(ShoppingCartRecord? e1, ShoppingCartRecord? e2) {
    return e1?.product == e2?.product &&
        e1?.userid == e2?.userid &&
        e1?.price == e2?.price &&
        e1?.subtotal == e2?.subtotal &&
        e1?.amount == e2?.amount &&
        e1?.hash == e2?.hash;
  }

  @override
  int hash(ShoppingCartRecord? e) => const ListEquality()
      .hash([e?.product, e?.userid, e?.price, e?.subtotal, e?.amount, e?.hash]);

  @override
  bool isValidKey(Object? o) => o is ShoppingCartRecord;
}
