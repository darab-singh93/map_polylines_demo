import 'dart:convert';

String basicAuthenticationHeader({required String username, required String password}) {
  return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
}