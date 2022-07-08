import 'package:financial_terms/controllers/connectivity_controller.dart';
import 'package:financial_terms/handler/network/api_urls.dart';
import 'package:financial_terms/models/finance_term.dart';
import 'package:financial_terms/utils/json_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../handler/network/network_response.dart';
import '../handler/network/request_handler.dart';

class TermsController extends GetxController {
  NetworkResponse? _networkResponse;
  final _terms = List<FinanceTerm>.empty(growable: true).obs;

  NetworkResponse? get networkResponse => _networkResponse;

  List<FinanceTerm> get terms => _terms;

  final _fetchingTerms = NetworkRequestStatus.none.obs;

  bool get fetchingTerms =>
      _fetchingTerms.value == NetworkRequestStatus.requesting;

  bool get termsFetchedSuccess =>
      _networkResponse != null && _networkResponse!.isSuccess;

  @override
  void onReady() {
    super.onReady();
    fetchTerms();
  }

  /// Method to get financial terms from the server
  Future<void> fetchTerms() async {
    if (fetchingTerms) {
      return;
    }

    if (!Get.find<ConnectivityController>().hasInternet) {
      return;
    }

    _networkResponse = null;
    _fetchingTerms.value = NetworkRequestStatus.requesting;

    await Future.delayed(const Duration(milliseconds: 10000));

    final response = await RequestHandler.get(ApiUrls.terms);
    _networkResponse = response;

    if (termsFetchedSuccess) {
      if (_networkResponse!.hasData &&
          _networkResponse!.data! is List &&
          _networkResponse!.data!.isNotEmpty) {
        final list = await compute<dynamic, List<FinanceTerm>?>(
            parseFinancialTermsJsonData, _networkResponse!.data!);
        if (list != null) {
          _terms.value = list;
        }
      }
    }

    _fetchingTerms.value = NetworkRequestStatus.completed;
  }
}
