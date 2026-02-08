
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PatientProvider with ChangeNotifier {
  bool _isLoading = false;
  List<dynamic> _patients = [];
  List<dynamic> _branches = [];
  String? _error;
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<dynamic> get branches => _branches;

  List<dynamic> get patients {
    if (_searchQuery.isEmpty) return _patients;

    return _patients.where((item) {
      final name = (item['name'] ?? '').toLowerCase();
      final treatments = (item['patientdetails_set'] as List? ?? [])
          .map((t) => t['treatment_name']?.toLowerCase() ?? '')
          .join(',');
      return name.contains(_searchQuery.toLowerCase()) ||
          treatments.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

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
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) throw Exception("No token found");

      final url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        _patients = data['patient'] ?? data['data'] ?? [];
        sortByDate(ascending: false);
      } else {
        _error = 'Failed to fetch patients (${res.statusCode})';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBranches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) throw Exception("No token found");

      final url = Uri.parse('https://flutter-amr.noviindus.in/api/BranchList');
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        _branches = data['branch'] ?? [];
      } else {
        _error = 'Failed to fetch branches (${res.statusCode})';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<bool> registerPatient(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) throw Exception("No token found");

      final url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientUpdate');
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      if (data['id'] != null && data['id'].toString().isNotEmpty) {
        final id = int.tryParse(data['id'].toString());
        data['id'] = id?.toString() ?? '';
      } else {
        data['id'] = '';
      }

      if (data['branch'] != null) {
        final branchId = int.tryParse(data['branch'].toString());
        data['branch'] = branchId?.toString() ?? '';
      }

      data['male'] = (data['male'] is List) ? (data['male'] as List).join(',') : '';
      data['female'] = (data['female'] is List) ? (data['female'] as List).join(',') : '';
      data['treatments'] = (data['treatments'] is List) ? (data['treatments'] as List).join(',') : '';

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      final res = await request.send();
      final responseBody = await res.stream.bytesToString();
      print('Register response: $responseBody');

      try {
        final resp = jsonDecode(responseBody);
        if (resp['status'] == true) {
          await fetchPatients();
          return true;
        } else {
          _error = resp['message'] ?? 'Server error. Check required fields.';
          return false;
        }
      } catch (_) {
        _error = 'Invalid server response. Check required fields.';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
