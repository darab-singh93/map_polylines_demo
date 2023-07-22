import 'dart:developer';

import 'package:fictive_box_task/models/user_details.dart';
import 'package:fictive_box_task/routes/route_path.dart';
import 'package:fictive_box_task/views/pages/show_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../services/http_service.dart';

class UserDetailsProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  bool loading = true;
  UserDetails? userDetails;

  // Get user details to provider
  Future<UserDetails?> getUserDetails() async {
    userDetails = null;
    // Statically passed body parameters
    Map<String, dynamic> params = {"pandit_id": "7", "booking_id": "921"};
    loading = true;
    Future.delayed(const Duration(milliseconds: 200), () async {
      userDetails = await _httpService.callUserDetails(params);
      loading = false;
      notifyListeners();
    });
    notifyListeners();
    return userDetails;
  }

  goToRouteScreen(BuildContext context, {required Location source, required Location destination}) {
    log("source: $source");
    log("destination: $destination");
    Navigator.pushNamed(
      context,
      RoutePath.showRoute,
      arguments: ShowRoute(
        source: source,
        destination: destination,
      ),
    );
  }
}
