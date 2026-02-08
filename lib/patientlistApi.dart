// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class PatientProvider with ChangeNotifier {
//   bool _isLoading = false;
//   List<dynamic> _patients = [];
//   String? _error;
//   String _searchQuery = '';

//   // Getters
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   /// Filtered patients (search by treatment name)
//   List<dynamic> get patients {
//     if (_searchQuery.isEmpty) return _patients;

//     return _patients.where((item) {
//       final treatments = (item['patientdetails_set'] as List? ?? [])
//           .map((t) => t['treatment_name']?.toLowerCase() ?? '')
//           .join(', ');
//       return treatments.contains(_searchQuery.toLowerCase());
//     }).toList();
//   }

//   /// Set search query
//   void setSearchQuery(String query) {
//     _searchQuery = query;
//     notifyListeners();
//   }

//   /// Sort patients by date
//   void sortByDate({bool ascending = true}) {
//     _patients.sort((a, b) {
//       DateTime dateA =
//           DateTime.tryParse(a['date_nd_time'] ?? '') ?? DateTime(1970);
//       DateTime dateB =
//           DateTime.tryParse(b['date_nd_time'] ?? '') ?? DateTime(1970);
//       return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
//     });
//     notifyListeners();
//   }

//   /// Fetch patient list
//   Future<void> fetchPatients() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token');

//       if (token == null) {
//         _error = "No token found. Please login.";
//         return;
//       }

//       final url =
//           Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');

//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _patients = data['patient'] ?? [];

//         // Default: newest first
//         sortByDate(ascending: false);
//       } else {
//         _error = 'Failed to load patients (${response.statusCode})';
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Add / Update patient
//   Future<bool> addPatient(Map<String, dynamic> payload) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token');

//       if (token == null) {
//         _error = "No token found. Please login.";
//         return false;
//       }

//       final url =
//           Uri.parse('https://flutter-amr.noviindus.in/api/PatientUpdate');

//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(payload),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['status'] == true) {
//           // Refresh list after successful add
//           await fetchPatients();
//           return true;
//         } else {
//           _error = data['message'] ?? 'Failed to save patient';
//           return false;
//         }
//       } else {
//         _error = 'Server error (${response.statusCode})';
//         return false;
//       }
//     } catch (e) {
//       _error = e.toString();
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Clear error manually
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
// }
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

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<dynamic> get branches => _branches;

  /// Filtered patients (search by name or treatment)
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

  /// Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Sort patients by date
  void sortByDate({bool ascending = true}) {
    _patients.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a['date_nd_time'] ?? '') ?? DateTime(1970);
      DateTime dateB = DateTime.tryParse(b['date_nd_time'] ?? '') ?? DateTime(1970);
      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    notifyListeners();
  }

  /// Fetch patient list from API
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

  /// Fetch branches list
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

  /// Register / Update patient
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

      // Ensure id is numeric or empty string
      if (data['id'] != null && data['id'].toString().isNotEmpty) {
        final id = int.tryParse(data['id'].toString());
        data['id'] = id?.toString() ?? '';
      } else {
        data['id'] = '';
      }

      // Ensure branch is numeric
      if (data['branch'] != null) {
        final branchId = int.tryParse(data['branch'].toString());
        data['branch'] = branchId?.toString() ?? '';
      }

      // Convert lists to comma-separated strings
      data['male'] = (data['male'] is List) ? (data['male'] as List).join(',') : '';
      data['female'] = (data['female'] is List) ? (data['female'] as List).join(',') : '';
      data['treatments'] = (data['treatments'] is List) ? (data['treatments'] as List).join(',') : '';

      // Add all fields to request
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

  /// Clear error manually
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
