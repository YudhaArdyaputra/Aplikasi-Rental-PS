import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Garage PS',
          style: TextStyle(fontSize: 22),
          ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(-8.122399475419593, 115.09058757527929),
        initialZoom: 18.5,
        interactionOptions:
          InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLAyer,
        const MarkerLayer(markers: [
          Marker(point: LatLng(-8.122334225772395, 115.0906469748351),
          child: Icon(
            Icons.location_pin, 
            size: 50, 
            color: Colors.red,)
          )
        ]),
      ], 
      );
  }
}

TileLayer get openStreetMapTileLAyer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.example.app',
);