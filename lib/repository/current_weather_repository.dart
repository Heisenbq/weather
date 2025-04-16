import 'package:test_flutter_app/model/current_weather.dart';
class CurrentWeatherRepository{
  Future<CurrentWeather> getCurrentWeather() async {
    await Future.delayed(Duration(milliseconds: 5000));
    return CurrentWeather(
        city: "Krasnodar", temperature: 31, description: "Mostly Sunny");
  }


}