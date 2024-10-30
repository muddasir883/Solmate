import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Coordinates for the specific location
  static const LatLng _storeLocation = LatLng(37.7749, -122.4194); // Example: San Francisco

  late GoogleMapController _mapController;

  // Initialize the Google Map controller
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Location"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Displaying Google Map centered on the store location
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _storeLocation,
              zoom: 15, // Adjust zoom level to focus on the location
            ),
            markers: {
              Marker(
                markerId: MarkerId("storeLocation"),
                position: _storeLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(title: "Our Store"),
              ),
            },
          ),
          // Adding a custom location icon at the center
          Center(
            child: Icon(
              Icons.location_on,
              color: Colors.redAccent,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
