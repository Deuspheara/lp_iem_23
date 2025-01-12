import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spots_discovery/data/Manager/PreferenceManager.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/model/spot.dart';
import 'package:spots_discovery/ui/detail.dart';
import 'package:spots_discovery/ui/favorite.dart';

class HomeViewModel extends ChangeNotifier {
  final SpotEndpoint _spotEndpoint;
  HomeViewModel(this._spotEndpoint) {
    _init();
  }

  List<Spot> spots = <Spot>[];
  final favorites = <int, bool>{};

  Future<void> _init() async {
    var response = await _spotEndpoint.getSpots();

    //Shared Preference
    await SharedPreferenceManager.getFavSpots().then((value) {
      favorites
          .addAll(value.asMap().map((key, value) => MapEntry(value, true)));
    });

    //parse spots get in ResponseDto
    spots =
        response.data.map((json) => Spot.fromJson(json)).toList().cast<Spot>();

    notifyListeners();
  }

  void loadMore() {
    spots.addAll(spots);
    notifyListeners();
  }

  void toggleFavorite(Spot spot) async {
    await SharedPreferenceManager.updateFavSpot(spot.id);
    favorites[spot.id] = await SharedPreferenceManager.isFavSpot(spot.id);

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
    print("comments: ${response.comments?.length}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SpotDetailPage(spot: spot, spotDetail: response)));
  }

  void navigateToFavorite(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FavoriteView()));
  }

  void getSpotByName(String name) {
    spots = spots.where((spot) => spot.title!.contains(name)).toList();
    notifyListeners();
  }
}
