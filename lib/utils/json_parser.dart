import 'package:financial_terms/models/finance_term.dart';
import 'package:flutter/foundation.dart';

/// Isolate function to parse financial terms json data
Future<List<FinanceTerm>?> parseFinancialTermsJsonData(dynamic data) async {
  try {
    final temp = List<FinanceTerm>.empty(growable: true);
    for (final json in data) {
      temp.add(FinanceTerm.fromJson(json));
    }

    if (temp.isNotEmpty) {
      return temp;
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print("[parseFinancialTermsJsonData] ---> ${e.toString()}");
    }
    return null;
  }
}
