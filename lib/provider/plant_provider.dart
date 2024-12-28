import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/plant.dart';

class PlantProvider with ChangeNotifier {
  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  // Fungsi untuk mengambil data tanaman dari API
  Future<void> fetchPlants() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/plants'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _plants = data.map((item) => Plant.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load plants');
    }
  }

  // Fungsi untuk menambah tanaman
  Future<void> addPlant(Plant plant) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/plants'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': plant.name,
        'description': plant.description,
        'image_url': plant.imageUrl,
      }),
    );
    if (response.statusCode == 201) {
      final newPlant = Plant.fromJson(json.decode(response.body));
      _plants.add(newPlant);
      notifyListeners();
    } else {
      throw Exception('Failed to add plant');
    }
  }

  // Fungsi untuk memperbarui tanaman
  Future<void> updatePlant(
      String id, String name, String description, String imageUrl) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/plants/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'description': description,
        'image_url': imageUrl,
      }),
    );
    if (response.statusCode == 200) {
      final updatedPlant = Plant.fromJson(json.decode(response.body));
      final index = _plants.indexWhere((plant) => plant.id == id);
      if (index != -1) {
        _plants[index] = updatedPlant;
        notifyListeners();
      }
    } else {
      throw Exception('Failed to update plant');
    }
  }

  // Fungsi untuk menghapus tanaman
  Future<void> deletePlant(String id) async {
    final response =
        await http.delete(Uri.parse('http://127.0.0.1:8000/api/plants/$id'));
    if (response.statusCode == 200) {
      _plants.removeWhere((plant) => plant.id == id);
      notifyListeners();
    } else {
      throw Exception('Failed to delete plant');
    }
  }
}
