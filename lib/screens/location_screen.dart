import 'package:climate_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/constants/const.dart';
import 'package:climate_app/services/weather.dart';
import 'package:climate_app/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key, this.decodedData});

  dynamic decodedData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? temperature;
  String? weathericon;
  String? weathermsg;

  @override
  void initState() {
    super.initState();
    updateui(widget.decodedData);
  }

  void updateui(dynamic data) {
    try {
      setState(() {
        temperature = data["main"]["temp"].toInt().toString();
        weathericon = weather.getWeatherIcon(data["weather"][0]["id"]);
        weathermsg = weather.getMessage(data["main"]["temp"].toInt());
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      NetworkHelper networkHelper = NetworkHelper();
                      dynamic newdata = await networkHelper.getweatherData();
                      updateui(newdata);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityname = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));
                      var data = await NetworkHelper()
                          .getweatherDatabyCityName(cityname);
                      updateui(data);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon.toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  weathermsg.toString(),
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
