import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  static const weather_api = "cd93a7c4c520590b6550c1366c0f182f";
  final WeatherFactory _wf = WeatherFactory(weather_api);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Dhaka").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _location(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _datetime(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _icon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _temp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _extra(),
        ],
      ),
    );
  }

  Widget _location() {
    return Text(_weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.normal,
        ));
  }

  Widget _datetime() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _icon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _temp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extra(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ) ),
          Text("          Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ) ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("    Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ) ),
            Text("          Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ) ),
          ],
        )
      ],
    );
  }
}
