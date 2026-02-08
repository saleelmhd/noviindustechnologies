import 'package:flutter/material.dart';
import 'package:noviindustechnologies/provider/services/patientlistApi.dart';
import 'package:provider/provider.dart';

class Patientlist extends StatefulWidget {
  const Patientlist({super.key});

  @override
  State<Patientlist> createState() => _PatientlistState();
}

class _PatientlistState extends State<Patientlist> {
  String _sortOrder = 'Newest'; // Default sort order

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PatientProvider>(context, listen: false).fetchPatients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings'), centerTitle: true),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by treatment',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                Provider.of<PatientProvider>(context, listen: false)
                    .setSearchQuery(value);
              },
            ),
          ),

          // Dropdown for sorting
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text('Sort by: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _sortOrder,
                  items: ['Newest', 'Oldest']
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _sortOrder = value;
                        final provider = Provider.of<PatientProvider>(
                            context,
                            listen: false);
                        provider.sortByDate(
                            ascending: _sortOrder == 'Oldest' ? true : false);
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          // Patient List
          Expanded(
            child: Consumer<PatientProvider>(
              builder: (context, patientProvider, _) {
                if (patientProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (patientProvider.error != null) {
                  return Center(child: Text(patientProvider.error!));
                }

                if (patientProvider.patients.isEmpty) {
                  return const Center(child: Text('No patients found'));
                }

                return RefreshIndicator(
                  onRefresh: () => patientProvider.fetchPatients(),
                  child: ListView.builder(
                    itemCount: patientProvider.patients.length,
                    itemBuilder: (context, index) {
                      final item = patientProvider.patients[index];

                      final name = item['name'] ?? '';
                      final dateTimeStr = item['date_nd_time'] ?? '';
                      final dateOnly = dateTimeStr.isNotEmpty
                          ? dateTimeStr.substring(0, 10)
                          : '';
                      final treatments = (item['patientdetails_set'] as List)
                          .map((t) => t['treatment_name'] ?? '')
                          .join(', ');
                      final branchName = item['branch']?['name'] ?? '';
                      final userName = item['user'] ?? '';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${index + 1}. $name",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text("Date: $dateOnly",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 6),
                              Text("Treatments: $treatments",
                                  style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Branch: $branchName",
                                      style: const TextStyle(color: Colors.grey)),
                                  Text("User: $userName",
                                      style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                              const Divider(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'View Booking details',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Bottom ElevatedButton
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,foregroundColor: Colors.white),
                onPressed: () {
                  // Handle registration action
                  print("Register button pressed");
                  // Navigator.push(...) if you want to go to a new page
                },
                child: const Text("Register Now"),
              ),
            ),
          ),SizedBox(height: 25,)
        ],
      ),
    );
  }
}
