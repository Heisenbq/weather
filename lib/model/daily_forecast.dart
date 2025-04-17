import 'package:flutter/material.dart';

import '../api_actions/weather_utils/weather_util.dart';

class DailyForecast {
  final String lowestTemperature;
  final String highestTemperature;
  final String day;
  final String iconCode;

  DailyForecast({
    required this.lowestTemperature,
    required this.highestTemperature,
    required this.day,
    required this.iconCode,
  });

  Widget getIcon({double size = 50}) {
    return WeatherUtil.getWeatherIcon(iconCode, size: size);
  }

}
