import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';

class MapPage extends StatefulWidget {
  const MapPage(
      {Key? key,
      required this.patient,
      required this.position,
      required this.location})
      : super(key: key);
  final Personne patient;
  final Position position;
  final Location location;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show patient location',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          bounds: LatLngBounds(
            LatLng(widget.position.latitude, widget.position.longitude),
            LatLng(widget.location.latitude, widget.location.longitude),
          ),
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point:
                    LatLng(widget.position.latitude, widget.position.longitude),
                width: 50,
                height: 50,
                builder: (context) => Container(
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
              Marker(
                point:
                    LatLng(widget.location.latitude, widget.location.longitude),
                width: 50,
                height: 50,
                builder: (context) => Container(
                  child: const Icon(
                    Icons.location_history,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(
                points: [
                  LatLng(widget.position.latitude, widget.position.longitude),
                  LatLng(widget.location.latitude, widget.location.longitude),
                ],
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
