class HourlyForecast {
  final String time;
  final int temperature;


  HourlyForecast({required this.time, required this.temperature});


  // factory HourlyForecast.fromJson(Map<String, dynamic> json) {
  //   return HourlyForecast(
  //     time: DateTime.parse(json['dt_txt']).hour.toInt(),
  //     temperature: json['main']['temp'] - 273.15, // Конвертация в °C
  //   );
  // }

}
