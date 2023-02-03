import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/model/spot.dart';

class HomeViewModel extends ChangeNotifier {
  final SpotEndpoint _spotEndpoint;
  HomeViewModel(this._spotEndpoint) {
    _init();
  }

  List<Spot> spots = <Spot>[];

  Future<void> _init() async {
    // Opening json file
    // var jsonString = await rootBundle.loadString("assets/json/spots.json");
    // // Decoding json
    // var json = jsonDecode(jsonString);
    // // Mapping data
    // spots = List<Map<String, dynamic>>.from(json["data"])
    //     .map((json) => Spot.fromJson(json))
    //     .toList();
    // notifyListeners();

    var response = await _spotEndpoint.getSpots();

    //parse spots get in ResponseDto
    final spots = response.data.map((json) => Spot.fromJson(json)).toList();

    for (var spot in spots) {
      print(spot.title);
    }
    notifyListeners();
  }

  void loadMore() {
    spots.addAll(spots);
    notifyListeners();
  }

  Spot getRandom() {
    final random = Random();
    final index = random.nextInt(spots.length);
    return spots[index];

    return Spot(id: 0);
  }

  void navigateToDetail(BuildContext context) {
    Navigator.of(context).pushNamed("/detail");
  }

  void getSpotByName(String name) {
    spots = spots.where((spot) => spot.title!.contains(name)).toList();
    notifyListeners();
  }
}
