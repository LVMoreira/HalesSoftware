import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GpsService {
  static Future<List<Map<String, dynamic>>> fetchLocations() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/location'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double lat1 = data['latitude'];
        double lon1 = data['longitude'];

        // Segunda localização simulada (por exemplo, um ponto próximo)
        double lat2 = lat1 + 0.015;
        double lon2 = lon1 + 0.015;

        return [
          {'name': 'Localização 1', 'coordinates': LatLng(lat1, lon1)},
          {'name': 'Localização 2', 'coordinates': LatLng(lat2, lon2)},
        ];
      }
    } catch (e) {
      print("Erro ao buscar localizações: $e");
    }

    return [];
  }
}
