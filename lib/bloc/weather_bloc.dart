import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'package:skysense/models/weather_model.dart';
import 'package:skysense/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(
    weatherRepository,
  )   : _weatherRepository = weatherRepository,
        super(WeatherInitial()) {
    on<onWeatherFetched>(_onWeatherFetched);
  }

  _onWeatherFetched(onWeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          throw 'Location Not Available';
        }
      }
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final weather = await _weatherRepository.getCurrentWeather(
          position.latitude.toString(), position.longitude.toString());
      print(weather.name);
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(
        WeatherFailure(error: e.toString()),
      );
    }
  }
}
