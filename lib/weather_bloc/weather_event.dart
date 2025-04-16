part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class FetchHourlyForecast extends WeatherEvent{}

class FetchDailyForecast extends WeatherEvent{}

class FetchCurrentWeather extends WeatherEvent{}


