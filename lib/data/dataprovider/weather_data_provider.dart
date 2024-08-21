import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skysense/core/secrets.dart';

class WeatherDataProvider {
  Future<String> getCurrentWeather(String lat, String lon) async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=035e8504dfad2e316b9193c609f37bab'));

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
