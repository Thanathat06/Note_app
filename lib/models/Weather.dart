class Weather {
  final String cityName;
  final double tempurature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.tempurature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      tempurature: json["main"]["temp"].toDouble(),
      mainCondition: json["weather"][0]["main"],
    );
  }
}
