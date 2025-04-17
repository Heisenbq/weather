import 'package:test_flutter_app/model/current_weather.dart';

import '../api_actions/weather_api.dart';
class CurrentWeatherRepository{


  Future<CurrentWeather> getCurrentWeather(String cityName) async {
    return await WeatherApi.fetchWeatherByCity(cityName);
  }


}