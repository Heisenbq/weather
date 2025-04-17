import 'package:test_flutter_app/model/hourly_forecast.dart';

class HourlyForecastRepository{
  Future<List<HourlyForecast>> getHourlyForecast() async {
    await Future.delayed(Duration(milliseconds:  5000));
    return [
      // HourlyForecast(time: 'Now', temperature: 31),
      // HourlyForecast(time: '12PM', temperature: 35),
      // HourlyForecast(time: '1PM', temperature: 31),
      // HourlyForecast(time: '2PM', temperature: 32),
      // HourlyForecast(time: '3PM', temperature: 23),
      // HourlyForecast(time: '4PM', temperature: 18),
      // HourlyForecast(time: '5PM', temperature: 36),
      // HourlyForecast(time: '6PM', temperature: 28),
      // HourlyForecast(time: '7PM', temperature: 28),
      // HourlyForecast(time: '8PM', temperature: 29),
      // HourlyForecast(time: '9PM', temperature: 30),
    ];
  }

  // Future<List<HourlyForecast>> getForecast() async {
  //   return [HourlyForecast(time: '123', temperature: '12313')];
  // }
}