import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpLog {
  HttpLog.displayResponse({payload, http.Response? res, String? requestType}) {
    if (!kDebugMode) return;
    if (payload != null) log("Body Parameters:- $payload", name: "Http Log");
    if (requestType == null) return;
    log("requestType:- $requestType", name: "Http Log");
    if (res == null) return;
    log("headers: ${res.headers}", name: "Http Log");
    logWrapped("API URL: ${res.request!.url.toString()}");
    log("statusCode: ${res.statusCode}", name: "Http Log");
    logWrapped(
      "response: ${res.body}",
    );
  }

  // Used to log response when response length is large
  void logWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach(
        (match) => log("${match.group(0)}", name: "Http Log"));
  }
}
