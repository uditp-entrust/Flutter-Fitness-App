import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapLocation extends StatelessWidget {
  final double lat;
  final double long;
  final void Function(GoogleMapController) onMapCreated;
  final void Function(LatLng) onMapTap;

  GoogleMapLocation({this.lat, this.long, this.onMapCreated, this.onMapTap});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            lat,
            long,
          ),
          zoom: 16,
        ),
        onMapCreated: onMapCreated,
        onTap: onMapTap,
        markers: {
          Marker(
            markerId: MarkerId('m1'),
            draggable: true,
            position: LatLng(
              lat,
              long,
            ),
          ),
        });
  }
}
