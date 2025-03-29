import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/gps_service.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<Map<String, dynamic>> locations = [];
  bool isSidebarOpen = true;
  int? selectedLocationIndex; // Índice da localização selecionada

  @override
  void initState() {
    super.initState();
    fetchLocations();
    Future.delayed(Duration(seconds: 8), updateLocations);
  }

  Future<void> fetchLocations() async {
    List<Map<String, dynamic>> newLocations = await GpsService.fetchLocations();
    if (newLocations.isNotEmpty) {
      setState(() {
        locations = newLocations;
      });
    }
  }

  void updateLocations() {
    fetchLocations();
    Future.delayed(Duration(seconds: 8), updateLocations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa
          FlutterMap(
            options: MapOptions(
              center: locations.isNotEmpty ? locations[0]['coordinates'] : LatLng(38.7169, -9.1399),
              zoom: 12.0,
              onTap: (_, __) {
                setState(() => selectedLocationIndex = null); // Fecha o rótulo ao clicar fora
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: List.generate(locations.length, (index) {
                  final loc = locations[index];
                  final bool isSelected = index == selectedLocationIndex;
                  final Color markerColor = isSelected ? Colors.blue : (index % 2 == 0 ? Colors.red : Colors.green);

                  return Marker(
                    point: loc['coordinates'],
                    width: 50.0,
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLocationIndex = index;
                          if (!isSidebarOpen) isSidebarOpen = true; // Abre a sidebar automaticamente
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.location_pin, color: markerColor, size: 40.0),
                          if (isSelected)
                            Positioned(
                              top: -20,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  loc['name'],
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          // Sidebar minimizável
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isSidebarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Container(
              width: 250,
              color: Colors.white.withOpacity(0.9),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Localizações', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => setState(() => isSidebarOpen = false),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final loc = locations[index];
                        final bool isSelected = index == selectedLocationIndex;

                        return Container(
                          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                          child: ListTile(
                            title: Text(loc['name']),
                            subtitle: Text('${loc['coordinates'].latitude}, ${loc['coordinates'].longitude}'),
                            onTap: () {
                              setState(() {
                                selectedLocationIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botão para abrir a sidebar
          Positioned(
            left: isSidebarOpen ? 250 : 10,
            top: 20,
            child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.menu),
              onPressed: () => setState(() => isSidebarOpen = true),
            ),
          ),
        ],
      ),
    );
  }
}