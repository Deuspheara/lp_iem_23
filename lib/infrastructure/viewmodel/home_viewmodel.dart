import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/model/spot.dart';
import 'package:spots_discovery/ui/detail.dart';

import '../../data/model/spot_detail.dart';

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
    spots =
        response.data.map((json) => Spot.fromJson(json)).toList().cast<Spot>();

    notifyListeners();
  }

  void loadMore() {
    //TODO
    notifyListeners();
  }

  Spot getRandom() {
    final random = Random();
    final index = random.nextInt(spots.length);
    return spots[index];
  }

  void navigateToDetail(BuildContext context, Spot spot) async {
    final response = await _spotEndpoint.getSpot(spot.id);

    if (response == null) {
      print("No data");

      return;
    }
    print("comments: ${response.comments?.comments}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SpotDetailPage(spot: spot, spotDetail: response)));
  }

  void getSpotByName(String name) {
    spots = spots.where((spot) => spot.title!.contains(name)).toList();
    notifyListeners();
  }
}
