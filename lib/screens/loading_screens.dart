import 'package:climate_app/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getRealWeatherData();
  }

  void getRealWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper();

    dynamic decodedjsondata = await networkHelper.getweatherData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  decodedData: decodedjsondata,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: const Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 300.0,
        ),
      ),
    );
  }
}
