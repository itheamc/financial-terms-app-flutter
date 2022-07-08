import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///--------------------------------@mit------------------------------
/// Class to handle connectivity
class ConnectivityHandler {
  Connectivity? _connectivity;

  // private Constructor
  ConnectivityHandler._();

  // Static Function to initialize the Connectivity Handler
  factory ConnectivityHandler.initialize() {
    ConnectivityHandler handler = ConnectivityHandler._();
    handler._connectivity = Connectivity();
    return handler;
  }

  // Checking Internet Connectivity
  Future<bool> hasActiveConnection() async {
    try {
      ConnectivityResult result =
          await (_connectivity ?? Connectivity()).checkConnectivity();
      return result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.bluetooth;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return false;
    }
  }

  // Listening the connectivity change status
  Stream<ConnectivityResult> get onConnectivityChanged {
    return (_connectivity ?? Connectivity()).onConnectivityChanged;
  }
}
