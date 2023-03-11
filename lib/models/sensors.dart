class SensorData {
  double soilMoisture;
  double temperature;
  double humidity;
  double nitrogen;
  double phosphorus;
  double potassium;
  String userId;

  SensorData({
    required this.soilMoisture,
    required this.temperature,
    required this.humidity,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.userId,
  });
}
