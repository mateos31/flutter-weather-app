import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_01/service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('122fa9a62a298765bcd57969d2a29199');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default to suny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'somke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10,
              ),

              Column(children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.location_on),
                  color: Color.fromRGBO(120, 120, 120, 1),
                ),
                Text(
                  _weather?.cityName ?? "loading city...",
                  style: TextStyle(
                      color: Color.fromRGBO(120, 120, 120, 1),
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ]),

              //city name

              //animation
              Container(
                child:
                    Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                width: 200,
                height: 200,
              ),

              //weather condition
              Text(
                ("${_weather?.temperature.round()}°C") ?? " °C",
                style: TextStyle(
                    color: Color.fromRGBO(120, 120, 120, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
