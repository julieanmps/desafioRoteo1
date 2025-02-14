import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CardsRecord extends FirestoreRecord {
  CardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "card_number" field.
  String? _cardNumber;
  String get cardNumber => _cardNumber ?? '';
  bool hasCardNumber() => _cardNumber != null;

  // "card_holder" field.
  String? _cardHolder;
  String get cardHolder => _cardHolder ?? '';
  bool hasCardHolder() => _cardHolder != null;

  // "expiration_date" field.
  String? _expirationDate;
  String get expirationDate => _expirationDate ?? '';
  bool hasExpirationDate() => _expirationDate != null;

  // "cvv" field.
  String? _cvv;
  String get cvv => _cvv ?? '';
  bool hasCvv() => _cvv != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "userid" field.
  DocumentReference? _userid;
  DocumentReference? get userid => _userid;
  bool hasUserid() => _userid != null;

  void _initializeFields() {
    _cardNumber = snapshotData['card_number'] as String?;
    _cardHolder = snapshotData['card_holder'] as String?;
    _expirationDate = snapshotData['expiration_date'] as String?;
    _cvv = snapshotData['cvv'] as String?;
    _type = snapshotData['type'] as String?;
    _userid = snapshotData['userid'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cards');

  static Stream<CardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CardsRecord.fromSnapshot(s));

  static Future<CardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CardsRecord.fromSnapshot(s));

  static CardsRecord fromSnapshot(DocumentSnapshot snapshot) => CardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCardsRecordData({
  String? cardNumber,
  String? cardHolder,
  String? expirationDate,
  String? cvv,
  String? type,
  DocumentReference? userid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expiration_date': expirationDate,
      'cvv': cvv,
      'type': type,
      'userid': userid,
    }.withoutNulls,
  );

  return firestoreData;
}

class CardsRecordDocumentEquality implements Equality<CardsRecord> {
  const CardsRecordDocumentEquality();

  @override
  bool equals(CardsRecord? e1, CardsRecord? e2) {
    return e1?.cardNumber == e2?.cardNumber &&
        e1?.cardHolder == e2?.cardHolder &&
        e1?.expirationDate == e2?.expirationDate &&
        e1?.cvv == e2?.cvv &&
        e1?.type == e2?.type &&
        e1?.userid == e2?.userid;
  }

  @override
  int hash(CardsRecord? e) => const ListEquality().hash([
        e?.cardNumber,
        e?.cardHolder,
        e?.expirationDate,
        e?.cvv,
        e?.type,
        e?.userid
      ]);

  @override
  bool isValidKey(Object? o) => o is CardsRecord;
}
