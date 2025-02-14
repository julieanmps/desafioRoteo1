// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<double> subsomaTotal(
  double? price,
  double? amount,
) async {
  // soma esses valores

  if (price == null || amount == null) {
    throw Exception("Price and amount cannot be null");
  }

  double total = price * amount;
  return total;
}
