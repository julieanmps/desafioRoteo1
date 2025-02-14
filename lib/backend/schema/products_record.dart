import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductsRecord extends FirestoreRecord {
  ProductsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "availability" field.
  bool? _availability;
  bool get availability => _availability ?? false;
  bool hasAvailability() => _availability != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  bool hasId() => _id != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "userMail" field.
  String? _userMail;
  String get userMail => _userMail ?? '';
  bool hasUserMail() => _userMail != null;

  void _initializeFields() {
    _availability = snapshotData['availability'] as bool?;
    _category = snapshotData['category'] as String?;
    _description = snapshotData['description'] as String?;
    _id = castToType<int>(snapshotData['id']);
    _imageUrl = snapshotData['image_url'] as String?;
    _name = snapshotData['name'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _userId = snapshotData['userId'] as DocumentReference?;
    _userMail = snapshotData['userMail'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductsRecord.fromSnapshot(s));

  static Future<ProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductsRecord.fromSnapshot(s));

  static ProductsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductsRecordData({
  bool? availability,
  String? category,
  String? description,
  int? id,
  String? imageUrl,
  String? name,
  double? price,
  DocumentReference? userId,
  String? userMail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'availability': availability,
      'category': category,
      'description': description,
      'id': id,
      'image_url': imageUrl,
      'name': name,
      'price': price,
      'userId': userId,
      'userMail': userMail,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductsRecordDocumentEquality implements Equality<ProductsRecord> {
  const ProductsRecordDocumentEquality();

  @override
  bool equals(ProductsRecord? e1, ProductsRecord? e2) {
    return e1?.availability == e2?.availability &&
        e1?.category == e2?.category &&
        e1?.description == e2?.description &&
        e1?.id == e2?.id &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.name == e2?.name &&
        e1?.price == e2?.price &&
        e1?.userId == e2?.userId &&
        e1?.userMail == e2?.userMail;
  }

  @override
  int hash(ProductsRecord? e) => const ListEquality().hash([
        e?.availability,
        e?.category,
        e?.description,
        e?.id,
        e?.imageUrl,
        e?.name,
        e?.price,
        e?.userId,
        e?.userMail
      ]);

  @override
  bool isValidKey(Object? o) => o is ProductsRecord;
}
