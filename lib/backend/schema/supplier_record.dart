import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SupplierRecord extends FirestoreRecord {
  SupplierRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('supplier');

  static Stream<SupplierRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SupplierRecord.fromSnapshot(s));

  static Future<SupplierRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SupplierRecord.fromSnapshot(s));

  static SupplierRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SupplierRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SupplierRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SupplierRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SupplierRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SupplierRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSupplierRecordData({
  String? name,
  String? description,
  DocumentReference? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'user_id': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SupplierRecordDocumentEquality implements Equality<SupplierRecord> {
  const SupplierRecordDocumentEquality();

  @override
  bool equals(SupplierRecord? e1, SupplierRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(SupplierRecord? e) =>
      const ListEquality().hash([e?.name, e?.description, e?.userId]);

  @override
  bool isValidKey(Object? o) => o is SupplierRecord;
}
