import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  var apiKey = '954631080b4a322c1f51c31455fb0725';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    double lat = location.latitude;
    double lon = location.longitude;

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}');

    var weatherReport = networkHelper.getData();

    Navigator.push(context,MaterialPageRoute(builder: (context){
      return LocationScreen(
          locationWeather:weatherReport
      );
    }));

  }
}
