import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'gps_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GPSService gpsService = GPSService();
  List<LatLng> currentLocations = [];

  @override
  void initState() {
    super.initState();
    gpsService.gpsStream.listen((newLocations) {
      setState(() {
        currentLocations = newLocations;
      });
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Tracker'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(38.7169, -9.1399),
              zoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: currentLocations.map((location) {
                  return Marker(
                    width: 40.0,
                    height: 40.0,
                    point: location,
                    child: Icon(Icons.location_on, color: Colors.red, size: 40),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.my_location, color: Colors.white),
              onPressed: () {
                setState(() {
                  // Voltar à localização inicial
                  currentLocations = [LatLng(38.7169, -9.1399)];
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gpsService.dispose();
    super.dispose();
  }
}