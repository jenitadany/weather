import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  String city = 'Tirunelveli';

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    try {
      final data = await _weatherService.fetchWeather(city);
      setState(() => weatherData = data);
    } catch (e) {
      setState(() => weatherData = null);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temp = weatherData?['main']?['temp'];
    final condition = weatherData?['weather']?[0]?['description'];
    final cityName = weatherData?['name'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Weather App')),
        body: Center(
          child: weatherData == null
              ? CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('City: $cityName', style: TextStyle(fontSize: 20)),
              Text('Temp: $temp°C', style: TextStyle(fontSize: 24)),
              Text('Condition: $condition', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
