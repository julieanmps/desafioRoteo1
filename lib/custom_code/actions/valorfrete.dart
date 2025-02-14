// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<double> valorfrete(String? frete) async {
  print("Texto recebido: $frete"); // Imprime o texto recebido

  // Verificar se o texto é nulo ou não contém "R\$"
  if (frete == null || !frete.contains("R\$")) {
    print("Texto inválido ou não contém 'R\$'");
    return 0.0;
  }

  // Encontrar a posição do caractere "R\$"
  int index = frete.indexOf("R\$");

  // Extrair os números após o caractere "R\$"
  String valorString = frete.substring(index + 2).trim();
  print("Valor extraído: $valorString");

  // Remover quaisquer espaços e substituir vírgulas por pontos
  valorString = valorString.replaceAll(' ', '').replaceAll(',', '.');
  print(
      "Valor após remoção de espaços e substituição de vírgulas: $valorString");

  try {
    // Converter a string para double
    double valor = double.parse(valorString);
    print("Valor convertido: $valor");
    return valor;
  } catch (e) {
    print("Erro ao converter valor: $e");
    return 0.0;
  }
}
