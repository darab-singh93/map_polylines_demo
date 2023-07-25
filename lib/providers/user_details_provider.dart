import 'dart:developer';

import 'package:fictive_box_task/models/user_details.dart';
import 'package:fictive_box_task/providers/location_details_provider.dart';
import 'package:fictive_box_task/routes/route_path.dart';
import 'package:fictive_box_task/views/pages/show_route.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../services/http_service.dart';

class UserDetailsProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  bool loading = true;
  UserDetails? userDetails;

  // Get user details to provider
  Future<UserDetails?> getUserDetails(BuildContext context) async {
    userDetails = null;
    // Statically passed body parameters
    Map<String, dynamic> params = {"pandit_id": "7", "booking_id": "921"};
    loading = true;
    Future.delayed(const Duration(milliseconds: 200), () async {
      final locationRef =
          Provider.of<LocationDetailsProvider>(context, listen: false);
      // Get Current location
      await locationRef.getCurrentLocation();
      userDetails = await _httpService.callUserDetails(params);
      if (userDetails != null) {
        //  Get location coordinates
        await locationRef.getLocationCoordinates(
            userDetails!.response.viewDetailData.first.address);
      }
      loading = false;
      notifyListeners();
    });
    notifyListeners();
    return userDetails;
  }

  goToRouteScreen(BuildContext context,
      {required Location source, required Location destination}) {
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
