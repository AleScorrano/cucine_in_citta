import 'dart:convert';

import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:hive/hive.dart';

class CuisineExplorerLocalDatasource {
  CuisineExplorerLocalDatasource(this._box);

  final Box _box;

  static const _recentCitiesKey = 'recent_cities';

  List<CityModel> getRecentCities() {
    final raw = _box.get(_recentCitiesKey, defaultValue: <dynamic>[]);

    return (raw as List)
        .map((item) => CityModel.fromJson(jsonDecode(jsonEncode(item))))
        .toList();
  }

  Future<void> saveRecentCities(List<CityModel> cities) async {
    await _box.put(_recentCitiesKey, cities.map((e) => e.toJson()).toList());
  }

  Future<void> saveRecentCity(CityModel city) async {
    final cities = getRecentCities();

    final alreadyExists = cities.any((storedCity) => storedCity.id == city.id);

    if (alreadyExists) {
      return;
    }

    await saveRecentCities([city, ...cities]);
  }

  Future<void> deleteCity(CityModel city) async {
    final cities = getRecentCities();

    final updatedCities = cities
        .where((storedCity) => storedCity.id != city.id)
        .toList();

    await saveRecentCities(updatedCities);
  }

  Future<void> clearRecentCities() async {
    await _box.delete(_recentCitiesKey);
  }
}
