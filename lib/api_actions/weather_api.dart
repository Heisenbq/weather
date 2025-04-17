import 'package:dio/dio.dart';
import 'package:test_flutter_app/api_actions/weather_utils/weather_util.dart';
import 'package:test_flutter_app/model/hourly_forecast.dart';

import '../model/current_weather.dart';

class WeatherApi {
  static final Dio _dio = Dio();
  static final String _apiKey = 'a0e508f45eed10d76be37cc08bfab391';
  static final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  static Future<CurrentWeather> fetchWeatherByCity(String cityName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric', // Для °C
        },
      );
      return CurrentWeather.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    }
  }

  static Future<List<HourlyForecast>> fetch48HourlyForecastByCity(String cityName) async {
    try{
      final response = await _dio.get(
        '$_baseUrl/forecast',
         queryParameters: {
           'q': cityName,
           'appid': _apiKey,
           'units': 'metric', // Для °C
         },
      );
      final forecast = (response.data['list'] as List)
          .map((json) => HourlyForecast.fromJson(json))
          .toList();
      return WeatherUtil.interpolateForecasts(forecast.sublist(0,17));
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }
}


