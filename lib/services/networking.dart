import 'package:climate_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

Future<dynamic> getweatherDatabyCityName(var cityname) async {

    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=b606066e5cee77331740663fc70506c1&units=metric"));

    if (response.statusCode == 200) {
      var jsondata = response.body;

      var decodejsondData = json.decode(jsondata);

      return decodejsondData;
    } else {
      // print(response.statusCode);
    }
  }


  Future<dynamic> getweatherData() async {
    Location currentlocation = Location();

    await currentlocation.getCurrentLocation();

    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${currentlocation.latitude}&lon=${currentlocation.longitude}&appid=b606066e5cee77331740663fc70506c1&units=metric"));

    if (response.statusCode == 200) {
      var jsondata = response.body;

      var decodejsondData = json.decode(jsondata);

      return decodejsondData;
    } else {
      // print(response.statusCode);
    }
  }
}
