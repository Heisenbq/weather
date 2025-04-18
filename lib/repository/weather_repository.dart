import '../api_actions/weather_api.dart';
import '../model/current_weather.dart';
import '../model/daily_forecast.dart';
import '../model/hourly_forecast.dart';

class WeatherRepository {
  Future<CurrentWeather> getCurrentWeather(String cityName) async {
    return await WeatherApi.fetchWeatherByCity(cityName);
  }

  Future<List<HourlyForecast>> getHourlyForecast(String cityName) async {
    return await WeatherApi.fetch48HourlyForecastByCity(cityName);
  }

  Future<List<DailyForecast>> getDailyForecast(String cityName) async {
    return await WeatherApi.fetchDailyForecast(cityName);
  }
}