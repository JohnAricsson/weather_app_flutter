class WeatherModel {
  final String locationName;
  final double tempC;
  final String conditionText;
  final String icon;
  final DateTime date;
  final double maxTempC;
  final double minTempC;
  final String sunrise;
  final String sunset;

  WeatherModel({
    required this.locationName,
    required this.tempC,
    required this.conditionText,
    required this.icon,
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final forecastDay = json['forecast']['forecastday'][0];

    return WeatherModel(
      locationName: json['location']['name'],
      tempC: (json['current']['temp_c'] as num).toDouble(),
      conditionText: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
      date: DateTime.fromMillisecondsSinceEpoch(
        json['location']['localtime_epoch'] * 1000,
      ),
      maxTempC: (forecastDay['day']['maxtemp_c'] as num).toDouble(),
      minTempC: (forecastDay['day']['mintemp_c'] as num).toDouble(),
      sunrise: forecastDay['astro']['sunrise'],
      sunset: forecastDay['astro']['sunset'],
    );
  }
}
