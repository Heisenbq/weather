import 'package:flutter/material.dart';
import 'package:test_flutter_app/api_actions/weather_utils/weather_util.dart';

class HourlyForecast {
  final String time;
  final int temperature;
  final String iconCode; // Добавляем поле для кода иконки

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.iconCode,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.parse(json['dt_txt']);
    final time = '${dateTime.hour.toString().padLeft(2, '0')}:00';
    final temp = (json['main']['temp'] as num).ceil();
    final iconCode = json['weather'][0]['icon'];

    return HourlyForecast(
      time: time,
      temperature: temp,
      iconCode: iconCode,
    );
  }

  Widget getIcon({double size = 50}) {
    return WeatherUtil.getWeatherIcon(iconCode, size: size);
  }
}
