part of 'weather_bloc.dart';

abstract class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState{}

class WeatherLoadingError extends WeatherState{}

class WeatherLoaded extends WeatherState{
  final List<HourlyForecast> forecast;

  WeatherLoaded(this.forecast);
}
