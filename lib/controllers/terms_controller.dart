import 'package:financial_terms/controllers/connectivity_controller.dart';
import 'package:financial_terms/database/a_database.dart';
import 'package:financial_terms/handler/network/api_urls.dart';
import 'package:financial_terms/models/finance_term.dart';
import 'package:financial_terms/utils/extension_functions.dart';
import 'package:financial_terms/utils/json_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../handler/network/network_response.dart';
import '../handler/network/request_handler.dart';

class TermsController extends GetxController {
  NetworkResponse? _networkResponse;
  ADatabase? aDatabase;
  final _terms = List<FinanceTerm>.empty(growable: true).obs;
  final _filteredTerms = List<FinanceTerm>.empty(growable: true).obs;

  NetworkResponse? get networkResponse => _networkResponse;

  List<FinanceTerm> get terms => _terms;

  List<FinanceTerm> get filteredTerms => _filteredTerms;

  final _fetchingTerms = NetworkRequestStatus.none.obs;

  bool get fetchingTerms =>
      _fetchingTerms.value == NetworkRequestStatus.requesting;

  bool get termsFetchedSuccess =>
      _networkResponse != null && _networkResponse!.isSuccess;

  /// Fetching terms on ready
  @override
  void onReady() async {
    super.onReady();
    aDatabase = await ADatabase.init();
    fetchTerms();
  }

  /// Getter for labeled finance terms list
  List<FinanceTerms> get labeledTerms {
    List<FinanceTerms> listOfFt = List.empty(growable: true);
    final labels = <String>{};

    for (final t in filteredTerms) {
      if (t.title == null || t.title!.isEmpty) continue;
      labels.add(t.title![0]);
    }

    for (final l in labels) {
      final temp = List<FinanceTerm>.empty(growable: true);
      for (final t in filteredTerms) {
        if (t.title != null && t.title!.startsWith(l)) {
          temp.add(t);
        }
      }
      listOfFt.add(FinanceTerms(label: l, terms: temp));
    }

    return listOfFt;
  }

  /// Method to get index by id
  int indexById(int id) {
    return _terms.indexWhere((element) => element.id == id);
  }

  /// Method to get FinanceTerm by id
  FinanceTerm termById(int id) {
    return _terms.firstWhere(
      (element) => element.id == id,
      orElse: () => FinanceTerm(id: 0, title: "", body: ""),
    );
  }

  /// Method to get financial terms from the server
  Future<void> fetchTerms() async {
    if (fetchingTerms) {
      return;
    }

    _networkResponse = null;
    _fetchingTerms.value = NetworkRequestStatus.requesting;

    final localTerms = await aDatabase?.terms();

    if (localTerms != null && localTerms.isNotEmpty) {
      final list = await compute<dynamic, List<FinanceTerm>?>(
          parseFinancialTermsJsonData, localTerms);
      if (list != null) {
        list.toSort<String, FinanceTerm>((e) => e.title ?? "", true);
        _terms.value = list;
        _filteredTerms.value = list;
      }
    } else {
      if (!Get.find<ConnectivityController>().hasInternet) {
        _fetchingTerms.value = NetworkRequestStatus.completed;
        return;
      }

      final response = await RequestHandler.get(ApiUrls.terms);
      _networkResponse = response;

      if (termsFetchedSuccess) {
        if (_networkResponse!.hasData &&
            _networkResponse!.data! is List &&
            _networkResponse!.data!.isNotEmpty) {
          final list = await compute<dynamic, List<FinanceTerm>?>(
              parseFinancialTermsJsonData, _networkResponse!.data!);
          if (list != null) {
            list.toSort<String, FinanceTerm>((e) => e.title ?? "", true);
            _terms.value = list;
            _filteredTerms.value = list;
          }
        }
      }
    }

    _fetchingTerms.value = NetworkRequestStatus.completed;

    /// Adding to the database
    if (localTerms == null || localTerms.isEmpty) {
      for (final t in _terms) {
        await aDatabase?.insertTerm(t);
      }
    }
  }

  /// Filter the financial terms
  void filterTerms(String s) {
    if (s.trim().isNotEmpty) {
      _filteredTerms.value = terms
          .where((e) => e.title!.toLowerCase().contains(s.trim().toLowerCase()))
          .toList();
    } else {
      _filteredTerms.value = _terms;
    }
  }

  @override
  void onClose() async {
    await aDatabase?.close();
    super.onClose();
  }
}
