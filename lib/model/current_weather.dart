class CurrentWeather {
  final String city;
  final int temperature;
  final String description;

  CurrentWeather({
    required this.city,
    required this.temperature,
    required this.description,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      city: json['name'],
      temperature: (json['main']['temp'] as num).ceil(),
      description: json['weather'][0]['description'],
    );
  }
}