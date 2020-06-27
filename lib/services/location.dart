import 'dart:ffi';

import 'package:geolocator/geolocator.dart';


class Location{
  double longitute,latitude;

  Future<Void> getLocationValue()async{
    Position position;
    try{
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
    }catch(e){
      print(e.toString());
    }
    longitute=position.longitude;
    latitude=position.latitude;

  }

}