import 'dart:developer';
import 'package:fictive_box_task/services/web_service.dart';
import 'package:fictive_box_task/utils/http_log.dart';
import 'package:http/http.dart' as http;
import '../models/user_details.dart';
import '../utils/basic_auth.dart';

class HttpService {
  final http.Client? httpClient;

  HttpService({this.httpClient});

//  Call user details
  Future<UserDetails?> callUserDetails(Map<String, dynamic> params) async {
    try {
      final response = await http.post(
        Uri.parse(
          WebService.userDetails,
        ),
        headers: {
          "authorization": basicAuthenticationHeader(
              username: WebService.username, password: WebService.password),
        },
        body: params,
      );
      HttpLog.displayResponse(res: response, requestType: "POST");
      return userDetailsFromJson(response.body);
    } catch (e) {
      log("Exception: $e", name: "callProfileDetails");
      return null;
    }
  }
}
