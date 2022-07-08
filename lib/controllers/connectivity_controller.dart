import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../handler/connectivity/connectivity_handler.dart';


///--------------------------------@mit------------------------------
/// Controller for connectivity
class ConnectivityController extends GetxController {
  final _hasInternet = true.obs;
  late ConnectivityHandler _handler;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool get hasInternet => _hasInternet.value;

  /// Initializing Late Init Var on Initialization
  @override
  void onInit() {
    _handler = ConnectivityHandler.initialize();
    _connectivitySubscription =
        _handler.onConnectivityChanged.listen(_updateInternetStatus);
    super.onInit();
  }

  @override
  void onReady() {
    _initHasInternet();
  }

  /// Init the _hasInternet
  Future<void> _initHasInternet() async {
    _hasInternet.value = await _handler.hasActiveConnection();
  }

  /// Function to update internet status
  void _updateInternetStatus(ConnectivityResult result) {
    if (_hasInternet.value != _getStatus(result)) {
      _hasInternet.value = _getStatus(result);
    }
  }

  /// Function to get internet status from the connectivity result
  bool _getStatus(ConnectivityResult result) {
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.bluetooth;
  }

  /// Cancelling the subscription on close
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}