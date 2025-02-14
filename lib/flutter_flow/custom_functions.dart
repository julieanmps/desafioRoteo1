import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String returnProfileGreeting(DateTime timestamp) {
  // return "morning" if it is morning, "afternoon" if afternoon and "night" if it is night
  var hour = timestamp.hour;
  if (hour >= 0 && hour < 12) {
    return "Good morning,";
  } else if (hour >= 12 && hour < 17) {
    return "Good afternoon,";
  } else {
    return "Goodnight,";
  }
}

DocumentReference? getDocRefFromIDProdutos() {
  // id do produto
  return FirebaseFirestore.instance.collection('produtos').doc();
}

double? priceAmount(
  double? price,
  int? amount,
) {
  if (price != null && amount != null) {
    return price * amount.toDouble();
  }
  return null;
}

double? subsomatotal(List<double>? subtotal) {
  // soma valores  de documentos
  // soma os valores da lista
  if (subtotal != null) {
    return subtotal.reduce((value, element) => value + element);
  } else {
    return null;
  }
}

double? somatotal(
  double? frete,
  double? subtotal,
) {
  // soma duis argumento
  if (frete != null && subtotal != null) {
    return frete + subtotal;
  }
  return null;
}

String? idhash() {
  // retorna uma id hash
  final String id = DateTime.now().millisecondsSinceEpoch.toRadixString(16);
  return id;
}

double? convertStringToDouble(String? va1) {
  // converte uma string em um double
  if (va1 != null) {
    try {
      return double.parse(va1);
    } catch (e) {
      return null;
    }
  }
  return null;
}
