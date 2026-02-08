import 'package:flutter/material.dart';
import 'package:noviindustechnologies/provider/services/patientlistApi.dart';
import 'package:noviindustechnologies/register.dart';
import 'package:provider/provider.dart';

class Patientlist extends StatefulWidget {
  const Patientlist({super.key});

  @override
  State<Patientlist> createState() => _PatientlistState();
}

class _PatientlistState extends State<Patientlist> {
  String _sortOrder = 'Newest'; // Default sort order
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PatientProvider>(context, listen: false).fetchPatients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: const Icon(
                    Icons.notification_important_outlined,
                    size: 28,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: -1,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Search by treatment',
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      Provider.of<PatientProvider>(context, listen: false)
                          .setSearchQuery(value);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final query = _searchController.text.trim();

                    
                    final provider =
                        Provider.of<PatientProvider>(context, listen: false);
                    provider.setSearchQuery(query);

                    
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  child: Text("Search"),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sort by : ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: .0),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
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
                                ascending:
                                    _sortOrder == 'Oldest' ? true : false);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                        color: const Color.fromARGB(255, 220, 231, 240),
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
                              Text("Treatments: $treatments",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.green)),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 13,
                                        color: Colors.red,
                                      ),
                                      Text("  $dateOnly",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        color: Colors.red,
                                        size: 14,
                                      ),
                                      Text("  $userName",
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text("Branch: $branchName",
                              //         style:
                              //             const TextStyle(color: Colors.grey)),

                              //   ],
                              // ),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking details',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  )
                                ],
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientRegisterScreen(),
                    ),
                  );
             
                  
                  print("Register button pressed");
                },
                child: const Text(
                  "Register Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
