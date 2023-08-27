import 'package:flutter/material.dart';

class CleanText {
  late String cleanText;
  late BuildContext context;

  CleanText(String texto, BuildContext mcontext) {
    texto = texto.toUpperCase();
    texto = texto.replaceAll(RegExp(r'\s+'), '');
    this.context = mcontext;

    cleaningText(texto);
  }

  void cleaningText(String text) {
    text = text.toUpperCase();
    String pattern = r'([A-Za-z]{3}\d{4})';
    String txtResult = '';

    RegExp regexPattern = RegExp(pattern, multiLine: true, caseSensitive: true);
    Match? matcher = regexPattern.firstMatch(text);

    if (matcher != null) {
      txtResult = matcher.group(1)!;
    } else {
      text = text.replaceAll('O', '0');
      matcher = regexPattern.firstMatch(text);
      if (matcher != null) {
        txtResult = matcher.group(1)!;
      } else {
        txtResult = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('NO SE ENCONTRÓ EL PATRÓN')),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(text)),
        );
      }
    }

    this.cleanText = txtResult;
  }

  String getCleanText() {
    return cleanText;
  }
}
