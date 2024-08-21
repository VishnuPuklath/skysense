import 'dart:convert';

import 'package:skysense/data/dataprovider/weather_data_provider.dart';
import 'package:skysense/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather(String lat, String lon) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(lat, lon);
      final data = jsonDecode(weatherData);

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
