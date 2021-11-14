import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Serializable/Q2.dart' as request;
import '../../../constraints.dart';

class GMap extends StatefulWidget {

  @override
  _GMapState createState() => _GMapState();

}

class _GMapState extends State<GMap> {
  late GoogleMapController mapController;

  final Map<String, Marker> _markers = {};
  static const LatLng _center = const LatLng(55.751244, 37.618423);
  int _index = 0;
  List<LatLng> _coords = <LatLng>[];

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final people = await request.placeAmountPeople();
    setState(() {
      mapController = controller;
      _markers.clear();
      for(final place in people.places) {
        _coords.add(LatLng(place.x, place.y));
        final marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          position: LatLng(place.x, place.y),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: people.count.toString() + " infected",
          )
        );
        _markers[place.name] = marker;
      }
    });
  }

  Future<void> _moveToNext() async {
    if (_index == _coords.length)
      _index = 0;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: _coords[_index], zoom: 11.0)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place maps'),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0
            ),
            markers: _markers.values.toSet(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: _moveToNext,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: kPrimaryColor
                ),
                child: Icon(Icons.forward_outlined),
              ),
            ),
          )
        ],
      )
    );
  }
}