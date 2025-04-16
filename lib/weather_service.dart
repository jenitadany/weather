import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '0f3d2e8f2558c996936a3818fb2813d6';


  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q='+city+'&appid='+apiKey
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
