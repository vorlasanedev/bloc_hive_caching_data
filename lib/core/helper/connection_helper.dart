import 'dart:io';

class InternetConnectionHelper {
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet is reachable
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
