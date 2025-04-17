import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api_actions/weather_utils/weather_util.dart';

class DailyForecast {
  final int lowestTemperature;
  final int highestTemperature;
  final String day;
  final String iconCode;

  DailyForecast({
    required this.lowestTemperature,
    required this.highestTemperature,
    required this.day,
    required this.iconCode,
  });




  factory DailyForecast.fromJson (List<Map<String, dynamic>> json) {
    final temps = json.map((f) => f['main']['temp']).toList();
    final icons = json
        .map((f) => f['weather']?[0]?['icon'] as String?)
        .where((icon) => icon != null)
        .cast<String>()
        .toList();

    final date = DateTime.parse(json.first['dt_txt']);
    return DailyForecast(
      lowestTemperature: temps.isNotEmpty ? temps.fold(double.infinity, (a,b) => min(a,b)).ceil() : 0,
      highestTemperature: temps.isNotEmpty ? temps.fold(double.negativeInfinity, (a,b) => max(a,b)).ceil() : 0,
      day: DateFormat('EEEE').format(date),
      iconCode: icons.isNotEmpty ? icons.elementAt((icons.length/2).ceil()) : "21d",
    );

  }

  Widget getIcon({double size = 50}) {
    return WeatherUtil.getWeatherIcon(iconCode, size: size);
  }

}





