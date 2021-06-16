import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    Location location = Location();
    await location.getCurrentLocation();
    double lat = location.latitude;
    double lon = location.longitude;
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=954631080b4a322c1f51c31455fb0725');

    if(response.statusCode == 200){
      String data = response.body;
      print(data);
      print('\n\n');

      var decodeData = jsonDecode(data);
      double longitude = decodeData['coord']['lon'];
      String weatherDesc = decodeData['weather'][0]['description'];
      double temp = decodeData['main']['temp'];
      int pressure = decodeData['main']['pressure'];
      int humidity = decodeData['main']['humidity'];
      String country = decodeData['sys']['country'];
      String timeZone = decodeData['name'];


      print(longitude);
      print(weatherDesc);
      print(temp);
      print(pressure);
      print(humidity);
      print(country);
      print(timeZone);

    }else{
      print(response.statusCode);
    }

  }


  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
