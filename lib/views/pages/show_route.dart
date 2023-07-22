import 'dart:async';
import 'package:fictive_box_task/providers/location_details_provider.dart';
import 'package:fictive_box_task/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShowRoute extends StatefulWidget {
  final Location source;
  final Location destination;

  const ShowRoute({Key? key, required this.source, required this.destination})
      : super(key: key);

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  appBar() {
    return AppBar(
      title: const Text(StringUtils.direction),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ref = Provider.of<LocationDetailsProvider>(context, listen: false);
      ref.addMarker();
      ref.createPolyline();
      ref.updateLoadingStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var ref = Provider.of<LocationDetailsProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar(),
      body: ref.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              markers: Set<Marker>.from(ref.markers),
              polylines: Set<Polyline>.of(ref.polyLines.values),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.source.latitude, widget.source.longitude),
                zoom: 14.4746,
              ),
              // onMapCreated: onMapCreated,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
