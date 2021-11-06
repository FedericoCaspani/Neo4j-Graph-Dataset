import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './Locations.dart' as locations;

import '../../../constraints.dart';

class GMap extends StatefulWidget {

  @override
  _GMapState createState() => _GMapState();

}

class _GMapState extends State<GMap> {
  late GoogleMapController mapController;

  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(45.521563, -122.677433);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for(final place in googleOffices.places) {
        final marker = Marker(
          markerId: MarkerId(place.name),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
          )
        );
        _markers[place.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place maps'),
        backgroundColor: kPrimaryColor,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}