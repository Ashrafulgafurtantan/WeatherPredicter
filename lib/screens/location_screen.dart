import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen(this.locationWeather);
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String city;
  var temperature;
  String weatherIcon;
  String detailIcon;
  int condition;

  @override
  void initState() {
    super.initState();
//    print('location_screen');
    updateUI(widget.locationWeather);
  }
  updateUI(dynamic weatherData){

   setState(() {
     if(weatherData==null){
       temperature=0;
       city='';
       weatherIcon='Error';
        return ;
     }
     /*double lat=weatherData['coord']['lat'];
     double lon=weatherData['coord']['lon'];*/
     temperature=weatherData['main']['temp'];
     city=weatherData['name'];
     condition=weatherData['weather'][0]['id'];
      weatherIcon=WeatherModel().getWeatherIcon(condition);
      detailIcon=WeatherModel().getMessage(temperature.toInt());

   //  print(temperature.toInt());
   });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()async {
                     var a=await  WeatherModel().getWeatherLocation();
                     updateUI(a);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {

                     var searchedCityName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();

                      }));
                     print(searchedCityName);
                     if(searchedCityName!=null){
                       var data=await WeatherModel().getWeatherFromSearchCity(searchedCityName);

                      // var data=await WeatherModel().getForecastFromSearchCity(searchedCityName);
                       updateUI(data);
                     }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toInt() }°',
                      style: kTempTextStyle,
                    ),
                    Text(weatherIcon,
                  //    '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text("$detailIcon in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* String lat=decode['coord']['lat'];
   String lon=decode['coord']['lon'];
   var temperature=decode['main']['temp'];
   var country=decode['name'];
   var id=decode['weather'][0]['id'];


   print(lat);
   print(lon);
   print(temperature);
   print(country);
   print(id);*/