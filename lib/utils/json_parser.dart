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

// Future<List<FinanceTerms>?> proceedFinancialTermsData(
//     List<FinanceTerm> terms) async {
//   try {
//     List<FinanceTerms> listOfFt = List.empty(growable: true);
//     final labels = <String>{};
//
//     for (final t in terms) {
//       if (t.title == null || t.title!.isEmpty) continue;
//       labels.add(t.title![0]);
//     }
//
//     for (final l in labels) {
//       final temp = List<FinanceTerm>.empty(growable: true);
//       for (final t in terms) {
//         if (t.title != null && t.title!.startsWith(l)) {
//           temp.add(t);
//         }
//       }
//       listOfFt.add(FinanceTerms(label: l, terms: temp));
//     }
//
//     return listOfFt;
//   } catch (e) {
//     if (kDebugMode) {
//       print("[proceedFinancialTermsData] ---> ${e.toString()}");
//     }
//     return null;
//   }
// }
