part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {}

final class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState{}

class CurrentWeatherLoadingError extends CurrentWeatherState{
  final String message;

  CurrentWeatherLoadingError(this.message);
}

class CurrentWeatherLoaded extends CurrentWeatherState{
  final CurrentWeather currentWeather;

  CurrentWeatherLoaded(this.currentWeather);
}
