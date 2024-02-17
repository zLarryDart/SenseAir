import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static const _apiKey = 'ddd6a0948b4e07e6a9fb8c452a1c499d';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>> obtenerPronosticoDelTiempo(
      String ciudad) async {
    final url = '$_baseUrl?q=$ciudad&appid=$_apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el pronóstico del tiempo');
    }
  }
}
