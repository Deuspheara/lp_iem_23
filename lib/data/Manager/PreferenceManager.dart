import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  //Liste spot favoris
  static const String _keyFavSpots = 'fav_spots';

  static Future<List<int>> getFavSpots() async {
    final SharedPreferences prefs = await _prefs;
    return prefs
            .getStringList(_keyFavSpots)
            ?.map((e) => int.parse(e))
            .toList() ??
        [];
  }

  static Future<void> addFavSpot(int id) async {
    final SharedPreferences prefs = await _prefs;
    final List<int> favSpots = await getFavSpots();
    favSpots.add(id);
    await prefs.setStringList(
        _keyFavSpots, favSpots.map((e) => e.toString()).toList());
  }

  static Future<void> removeFavSpot(int id) async {
    final SharedPreferences prefs = await _prefs;
    final List<int> favSpots = await getFavSpots();
    favSpots.remove(id);
    await prefs.setStringList(
        _keyFavSpots, favSpots.map((e) => e.toString()).toList());
  }

  static Future<bool> isFavSpot(int id) async {
    final List<int> favSpots = await getFavSpots();
    return favSpots.contains(id);
  }
}
