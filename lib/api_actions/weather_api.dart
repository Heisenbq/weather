import 'package:dio/dio.dart';
import 'package:test_flutter_app/api_actions/weather_utils/weather_util.dart';
import 'package:test_flutter_app/model/hourly_forecast.dart';

import '../model/current_weather.dart';
import '../model/daily_forecast.dart';

class WeatherApi {
  WeatherApi._();
  static final WeatherApi _instance = WeatherApi._();
  factory WeatherApi() => _instance;

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
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<CurrentWeather> fetchWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric', // Для °C
        },
      );
      return CurrentWeather.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<List<HourlyForecast>> fetch48HourlyForecastByCity(
    String cityName,
  ) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric', // Для °C
        },
      );
      final forecast =
          (response.data['list'] as List)
              .map((json) => HourlyForecast.fromJson(json))
              .toList();
      return WeatherUtil.interpolateForecasts(forecast.sublist(0, 17));
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<List<HourlyForecast>> fetch48HourlyForecastByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric', // Для °C
        },
      );
      final forecast =
          (response.data['list'] as List)
              .map((json) => HourlyForecast.fromJson(json))
              .toList();
      return WeatherUtil.interpolateForecasts(forecast.sublist(0, 17));
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<List<DailyForecast>> fetchDailyForecastByCity(String cityName) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric',
          'cnt': 40,
        },
      );

      final dailyGroups = WeatherUtil.groupForecastsByDay(
        response.data['list'],
      );

      final forecastDays =
          dailyGroups.map((json) => DailyForecast.fromJson(json)).toList();

      return forecastDays;
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }

  Future<List<DailyForecast>> fetchDailyForecastByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
          'cnt': 40,
        },
      );

      final dailyGroups = WeatherUtil.groupForecastsByDay(
        response.data['list'],
      );

      final forecastDays =
      dailyGroups.map((json) => DailyForecast.fromJson(json)).toList();

      return forecastDays;
    } on DioException catch (e) {
      throw Exception('Ошибка: ${e.response?.data['message'] ?? e.message}');
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }
}
