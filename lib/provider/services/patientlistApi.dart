import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PatientProvider with ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _patients = [];
  String? _error;

  String _searchQuery = '';

  bool get isLoading => _isLoading;

  // Filtered patients based on search query
  List<dynamic> get patients {
    List<dynamic> filtered = _patients;

    if (_searchQuery.isNotEmpty) {
      filtered = _patients.where((item) {
        final treatments = (item['patientdetails_set'] as List)
            .map((t) => t['treatment_name']?.toLowerCase() ?? '')
            .join(', ');
        return treatments.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  String? get error => _error;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Sort patients by date
  void sortByDate({bool ascending = true}) {
    _patients.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a['date_nd_time'] ?? '') ?? DateTime(1970);
      DateTime dateB = DateTime.tryParse(b['date_nd_time'] ?? '') ?? DateTime(1970);
      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    notifyListeners();
  }

  Future<void> fetchPatients() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _error = "No token found. Login first.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      var url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _patients = data['patient'] ?? [];

        // Sort by newest first by default
        sortByDate(ascending: false);
      } else {
        _error = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
