import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apiKey='a44cc36884b6e372d2dfa73db6e7a7a9';

class WeatherModel {


  Future <dynamic> getForecastFromSearchCity(String city)async{
    NetworkHelper networkHelper = NetworkHelper (
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');


    var weatherData = await networkHelper.getData ();
    return weatherData;

  }

  Future <dynamic> getWeatherFromSearchCity(String city)async{
    NetworkHelper networkHelper = NetworkHelper (
    'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');


    var weatherData = await networkHelper.getData ();
    return weatherData;

  }

  Future<dynamic> getWeatherLocation()async {
    Location location = Location ();
    await location.getLocationValue ( );
    NetworkHelper networkHelper = NetworkHelper (
        'https://api.openweathermap.org/data/2.5/weather?lat=${location
            .latitude}&lon=${location.longitute}&appid=$apiKey&units=metric' );
    var weatherData = await networkHelper.getData ();

    return weatherData;
  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
