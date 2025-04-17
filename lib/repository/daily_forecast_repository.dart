import 'package:test_flutter_app/api_actions/weather_api.dart';
import 'package:test_flutter_app/model/daily_forecast.dart';

class DailyForecastRepository {
  Future<List<DailyForecast>> getDailyForecast(String cityName) async {
    return await WeatherApi.fetchDailyForecast(cityName);
}
}