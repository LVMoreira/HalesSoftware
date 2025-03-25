import 'dart:async';
import 'package:latlong2/latlong.dart';

class GPSService {
  final StreamController<List<LatLng>> _controller = StreamController.broadcast();

  GPSService() {
    _simulateGPSData(); // Inicia a simulação
  }

  // Stream para ouvir as atualizações dos dados GPS
  Stream<List<LatLng>> get gpsStream => _controller.stream;

  void _simulateGPSData() {
    List<LatLng> locations = [
      LatLng(38.7169, -9.1399), // Lisboa
      LatLng(38.7071, -9.1355),
      LatLng(38.7100, -9.1400),
    ];
    
    int index = 0;
    Timer.periodic(Duration(seconds: 3), (timer) {
      // Atualiza a posição dos coletes ciclicamente
      index = (index + 1) % locations.length;
      _controller.add([locations[index]]);
    });
  }

  void dispose() {
    _controller.close();
  }
}