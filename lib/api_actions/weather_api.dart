import 'package:dio/dio.dart';

import '../model/current_weather.dart';

class WeatherApi {
  final Dio _dio = Dio();
  final String _apiKey = 'a0e508f45eed10d76be37cc08bfab391';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<CurrentWeather> fetchWeatherByCity(String cityName) async {
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
}