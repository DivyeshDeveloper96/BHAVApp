import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtilis {
  static Future<bool> isInternetConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;
    // Try pinging a real internet resource (Google DNS)
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
