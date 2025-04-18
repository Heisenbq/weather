import 'package:test_flutter_app/api_actions/weather_api.dart';
import 'package:test_flutter_app/model/hourly_forecast.dart';

class HourlyForecastRepository{
  Future<List<HourlyForecast>> getHourlyForecast(String cityName) async {
    return await WeatherApi.fetch48HourlyForecastByCity(cityName);
  }
}