import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductssoldRecord extends FirestoreRecord {
  ProductssoldRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "hashRef" field.
  String? _hashRef;
  String get hashRef => _hashRef ?? '';
  bool hasHashRef() => _hashRef != null;

  // "buyer" field.
  String? _buyer;
  String get buyer => _buyer ?? '';
  bool hasBuyer() => _buyer != null;

  // "productsCart" field.
  List<DocumentReference>? _productsCart;
  List<DocumentReference> get productsCart => _productsCart ?? const [];
  bool hasProductsCart() => _productsCart != null;

  void _initializeFields() {
    _hashRef = snapshotData['hashRef'] as String?;
    _buyer = snapshotData['buyer'] as String?;
    _productsCart = getDataList(snapshotData['productsCart']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('productssold');

  static Stream<ProductssoldRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductssoldRecord.fromSnapshot(s));

  static Future<ProductssoldRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductssoldRecord.fromSnapshot(s));

  static ProductssoldRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductssoldRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductssoldRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductssoldRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductssoldRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductssoldRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductssoldRecordData({
  String? hashRef,
  String? buyer,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'hashRef': hashRef,
      'buyer': buyer,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductssoldRecordDocumentEquality
    implements Equality<ProductssoldRecord> {
  const ProductssoldRecordDocumentEquality();

  @override
  bool equals(ProductssoldRecord? e1, ProductssoldRecord? e2) {
    const listEquality = ListEquality();
    return e1?.hashRef == e2?.hashRef &&
        e1?.buyer == e2?.buyer &&
        listEquality.equals(e1?.productsCart, e2?.productsCart);
  }

  @override
  int hash(ProductssoldRecord? e) =>
      const ListEquality().hash([e?.hashRef, e?.buyer, e?.productsCart]);

  @override
  bool isValidKey(Object? o) => o is ProductssoldRecord;
}
