class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final String name;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.name,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final temp = map['main']?['temp'] ?? 0.0;
    final sky = (map['weather'] != null && map['weather'].isNotEmpty)
        ? map['weather'][0]['main'] ?? 'Unknown'
        : 'Unknown';
    final pressure = map['main']?['pressure'] ?? 0;
    final windSpeed = map['wind']?['speed'] ?? 0.0;
    final humidity = map['main']?['humidity'] ?? 0;
    final name = map['name'] ?? 'Unknown';

    print(
        'Temp: $temp, Sky: $sky, Pressure: $pressure, Wind Speed: $windSpeed, Humidity: $humidity, Name: $name');

    return WeatherModel(
      currentTemp: temp,
      currentSky: sky,
      currentPressure: pressure,
      currentWindSpeed: windSpeed,
      currentHumidity: humidity,
      name: name,
    );
  }
}
