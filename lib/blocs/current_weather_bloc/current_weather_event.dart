part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {}

class FetchCurrentWeather extends CurrentWeatherEvent{
  final String city;

  FetchCurrentWeather(this.city);
}
