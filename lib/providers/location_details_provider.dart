import 'dart:developer';
import 'package:fictive_box_task/services/web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/string_utils.dart';

class LocationDetailsProvider with ChangeNotifier {
  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;
  Set<Marker> markers = {};
  bool loading = true;
  late Location source;
  late Location destination;

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polyline created by connecting two points
  Map<PolylineId, Polyline> polyLines = {};

  // Get current location
  Future<void> getCurrentLocation() async {
    final permission = await _geoLocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      await _geoLocatorPlatform.requestPermission();
    }
    final position = await _geoLocatorPlatform.getCurrentPosition();
    source = Location(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.timestamp());
    notifyListeners();
  }

  // Get location coordinates from user's address
  Future<void> getLocationCoordinates(String query) async {
    List<Location> locations = await locationFromAddress(query);
    destination = Location(
        latitude: locations[0].latitude,
        longitude: locations[0].longitude,
        timestamp: DateTime.timestamp());
    notifyListeners();
  }

//  Add markers to map
  addMarker() {
    markers.add(Marker(
      markerId: const MarkerId(StringUtils.markerId1),
      position: LatLng(source.latitude, source.longitude),
      infoWindow: const InfoWindow(
        title: StringUtils.markerTitle1,
      ),
    ));
    markers.add(Marker(
      markerId: const MarkerId(StringUtils.markerId2),
      position: LatLng(destination.latitude, destination.longitude),
      infoWindow: const InfoWindow(
        title: StringUtils.markerTitle2,
      ),
    ));
    notifyListeners();
  }

  // Create the poly lines for showing the route between two places
  createPolyline() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polyline
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      WebService.apiKey, // Google Maps API Key
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polyLines[id] = polyline;
    log("message: ${polyLines[id]}");
    notifyListeners();
  }

  updateLoadingStatus(bool newStatus) {
    loading = newStatus;
    notifyListeners();
  }
}
