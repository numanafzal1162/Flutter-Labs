import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "WEATHER APP",
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'ubuntu',
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.search,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          body: const WeatherAppHomePage(),
        ),
      ),
    ),
  );
}

class WeatherAppHomePage extends StatefulWidget {
  const WeatherAppHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherAppHomePage> createState() => _WeatherAppHomePageState();
}

class _WeatherAppHomePageState extends State<WeatherAppHomePage> {
  double longitude = 0.0;
  double latitude = 0.0;
  double temprature = 0.0;
  double feelLike = 0.0;
  String cityName = 'city';
  String weatherDiscription = 'not clear';
  double windSpeed = 0.0;
  double humidity = 0.0;
  double tempmax = 0.0;
  double pressure = 0.0;

  @override
  // fetching location when widget is loading in memory or when app is loading
  void initState() {
    fetchLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Image(
          image: AssetImage("asset/images/w3.jpg"),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 100),
              Center(
                child: Text(
                  cityName.toString(),
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'avenir'),
                ),
              ),
              SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherDiscription.toString(),
                    style: const TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'avenir'),
                  ),
                  SizedBox(width: 20),
                  Container(
                    child: Image(image: AssetImage('asset/images/sunny.png')),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Text(
                temprature.toStringAsFixed(0) + "°",
                style: const TextStyle(
                    fontSize: 55,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'avenir'),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              WeatherCard(
                  'Feels Like', 'asset/images/weather.png', feelLike, '°'),
              WeatherCard(
                  'Wind Speed', 'asset/images/wind.png', windSpeed, ' km/h'),
              WeatherCard(
                  'Humidity', 'asset/images/humidity.png', humidity, ' %'),
              WeatherCard('Air Pressure', 'asset/images/pressure.png', pressure,
                  ' mah'),
              WeatherCard(
                  'Temperature', 'asset/images/thermometer.png', tempmax, '°'),
            ],
          ),
        ),
      ]),
    );
  }

// method
  void fetchLocation() async {
    bool permission = false;

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      LocationPermission reqPermission = await Geolocator.requestPermission();
      if (reqPermission == LocationPermission.whileInUse ||
          reqPermission == LocationPermission.always) {
        permission = true;
      }
    } else {
      permission = true;
    }
    if (permission) {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = currentLoc.latitude;
      longitude = currentLoc.longitude;
      // print(currentLoc.latitude);
      // print(currentLoc.longitude);

      fetchWeather();
    } else {
      print("Location Permission Denied");
    }
  }

  void fetchWeather() async {
    const String API_KEY = "171a92ff4471ee334556218d1f729c5e";
    String urlString =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$API_KEY";
    var url = Uri.parse(urlString);
    http.Response response = await http.get(url);
    print(response.body);
    var responseBody = response.body;
    var parsedResponse = json.decode(responseBody);

    print(parsedResponse['coord']['lon']);
    print(parsedResponse['coord']['lat']);

    // print(parsedResponse['main']['temp']);
    // print(parsedResponse['main']['feels_like']);
    // print(parsedResponse['name']);
    print(parsedResponse['weather'][0]['main']);
    print(parsedResponse['weather'][0]['description']);
    // print(parsedResponse['wind']['speed']);
    // print(parsedResponse['main']['humidity']);
    // print(parsedResponse['main']['temp_max']);
    // print(parsedResponse['main']['pressure']);
    setState(() {
      longitude = parsedResponse['coord']['lon'] - 273.15;
      temprature = parsedResponse['main']['temp'] - 273.15;
      feelLike = parsedResponse['main']['feels_like'] - 273.15;
      cityName = parsedResponse['name'];
      weatherDiscription = parsedResponse['weather'][0]['main'];
      windSpeed = parsedResponse['wind']['speed'];
      humidity = parsedResponse['main']['humidity'];
      tempmax = parsedResponse['main']['temp_max'] - 273.15;
      pressure = parsedResponse['main']['pressure'];
    });
  }
}

class WeatherCard extends StatelessWidget {
  @override
  final String WeatherText;
  final String WeatherImage;
  final String UnitValue;
  final double value;

  WeatherCard(this.WeatherText, this.WeatherImage, this.value, this.UnitValue);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 330),
      height: 200,
      width: 250,
      child: Center(
        child: Column(children: [
          SizedBox(height: 10),
          Text(
            WeatherText,
            style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'avenir'),
          ),
          SizedBox(height: 10),
          Container(
            child: Image(image: AssetImage(WeatherImage)),
          ),
          SizedBox(height: 10),
          WeatherUnits(UnitValue, value)
        ]),
      ),
    );
  }
}

class WeatherUnits extends StatelessWidget {
  @override
  final double value;
  final String UnitText;
  WeatherUnits(this.UnitText, this.value);
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          value.toStringAsFixed(0) + UnitText,
          style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'avenir'),
        ),
      ]),
    );
  }
}
