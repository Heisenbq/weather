import 'package:flutter/material.dart';

import '../../model/hourly_forecast.dart';

class WeatherUtil {
  static Widget getWeatherIcon(String iconCode, {double size = 50}) {
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';
    return Image.network(
      iconUrl,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  static List<List<Map<String, dynamic>>> groupForecastsByDay(
      List<dynamic> forecasts,) {
    final groups = <List<Map<String, dynamic>>>[];
    List<Map<String, dynamic>> currentDay = [];

    for (final forecast in forecasts.cast<Map<String, dynamic>>()) {
      final date = forecast['dt_txt'].toString().split(' ')[0];

      if (currentDay.isEmpty ||
          currentDay.first['dt_txt'].toString().split(' ')[0] == date) {
        currentDay.add(forecast);
      } else {
        groups.add(currentDay);
        currentDay = [forecast];
      }
    }

    if (currentDay.isNotEmpty) {
      groups.add(currentDay);
    }

    return groups;
  }


  static List<HourlyForecast> interpolateForecasts(List<HourlyForecast> original) {
    final interpolated = <HourlyForecast>[];

    for (int i = 0; i < original.length - 1; i++) {
      final current = original[i];
      final next = original[i + 1];

      interpolated.add(current);

      // Извлекаем час из строки "HH:00"
      final currentHour = int.parse(current.time.split(':')[0]);
      final currentIcon = current.iconCode;
      final nextIcon = next.iconCode;

      for (int h = 1; h < 3; h++) {
        final hour = (currentHour + h) % 24;
        final progress = h / 3;

        final temp = (current.temperature + (next.temperature - current.temperature) * progress).round();

        interpolated.add(HourlyForecast(
            time: '${hour.toString().padLeft(2, '0')}:00', // Сохраняем формат "HH:00"
            temperature: temp,
            iconCode: h==1 ? currentIcon : nextIcon
        ));
      }
    }

    if (original.isNotEmpty) {
      interpolated.add(original.last);
    }

    return interpolated;
  }

}