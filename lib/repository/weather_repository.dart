import '../api_actions/weather_api.dart';
import '../model/current_weather.dart';
import '../model/daily_forecast.dart';
import '../model/hourly_forecast.dart';

class WeatherRepository {

  final WeatherApi weatherApi;


  WeatherRepository(this.weatherApi);

  Future<CurrentWeather> getCurrentWeather(String cityName) async {
    return await weatherApi.fetchWeatherByCity(cityName);
  }

  Future<List<HourlyForecast>> getHourlyForecast(String cityName) async {
    return await weatherApi.fetch48HourlyForecastByCity(cityName);
  }

  Future<List<DailyForecast>> getDailyForecast(String cityName) async {
    return await weatherApi.fetchDailyForecastByCity(cityName);
  }

  Future<CurrentWeather> getCurrentWeatherByCoordinates(double lat,double lon) async {
    return await weatherApi.fetchWeatherByCoordinates(lat,lon);
  }


  Future<List<HourlyForecast>> getHourlyForecastByCoordinates(double lat,double lon) async {
    return await weatherApi.fetch48HourlyForecastByCoordinates(lat,lon);
  }

  Future<List<DailyForecast>> getDailyForecastByCoordinates(double lat,double lon) async {
    return await weatherApi.fetchDailyForecastByCoordinates(lat,lon);
  }

}