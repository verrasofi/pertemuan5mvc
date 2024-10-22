import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PoliModel.dart';

class PoliController extends ChangeNotifier {
  final String apiUrl = 'https://670e194b073307b4ee4572fb.mockapi.io/poli';
  final List<Poli> _poliList = [];

  List<Poli> get poliList => _poliList;

  // Mengambil data dari MockAPI
  Future<void> fetchPoli() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        _poliList.clear();
        _poliList.addAll(data.map((json) => Poli(
              id: json['id'],
              namaPoli: json['namaPoli'],
              deskripsiPoli: json['deskripsiPoli'],
            )));
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Menambah data ke MockAPI
  Future<void> addPoli(String namaPoli, String deskripsiPoli) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'namaPoli': namaPoli,
          'deskripsiPoli': deskripsiPoli,
        }),
      );
      if (response.statusCode == 201) {
        final newPoli = Poli(
          id: jsonDecode(response.body)['id'],
          namaPoli: namaPoli,
          deskripsiPoli: deskripsiPoli,
        );
        _poliList.add(newPoli);
        notifyListeners();
      } else {
        throw Exception('Failed to add data');
      }
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  // Mengedit data di MockAPI
  Future<void> updatePoli(
      String id, String namaPoli, String deskripsiPoli) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'namaPoli': namaPoli,
          'deskripsiPoli': deskripsiPoli,
        }),
      );
      if (response.statusCode == 200) {
        final index = _poliList.indexWhere((poli) => poli.id == id);
        if (index != -1) {
          _poliList[index].namaPoli = namaPoli;
          _poliList[index].deskripsiPoli = deskripsiPoli;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  // Menghapus data dari MockAPI
  Future<void> deletePoli(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        _poliList.removeWhere((poli) => poli.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}
