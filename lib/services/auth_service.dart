import 'package:get/get.dart';

class AuthService extends GetxService {
  String? userId;
  String? token;

  // Save credentials after login
  void saveCredentials(String id, String tkn) {
    userId = id;
    token = tkn;
  }

  // Clear credentials on logout (optional for this test, but good practice)
  void clearCredentials() {
    userId = null;
    token = null;
  }
}