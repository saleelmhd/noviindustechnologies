import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patientlistApi.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController exeController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController advanceController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String selectedBranchId = "";
  String maleTreatments = "";
  String femaleTreatments = "";
  String treatments = "";

  @override
  void initState() {
    super.initState();
    Provider.of<PatientProvider>(context, listen: false).fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Patient")),
      body: Consumer<PatientProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.branches.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (v) => v!.isEmpty ? "Enter name" : null,
                  ),
                  TextFormField(
                    controller: exeController,
                    decoration: const InputDecoration(labelText: "Executive"),
                  ),
                  TextFormField(
                    controller: paymentController,
                    decoration: const InputDecoration(labelText: "Payment"),
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: "Phone"),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: "Address"),
                  ),
                  TextFormField(
                    controller: totalController,
                    decoration: const InputDecoration(labelText: "Total Amount"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: discountController,
                    decoration: const InputDecoration(labelText: "Discount Amount"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: advanceController,
                    decoration: const InputDecoration(labelText: "Advance Amount"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: balanceController,
                    decoration: const InputDecoration(labelText: "Balance Amount"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        labelText: "Date & Time (DD/MM/YYYY-HH:MM AM/PM)"),
                  ),

                  const SizedBox(height: 10),

                  // Branch dropdown
                  DropdownButtonFormField<String>(
                    value: selectedBranchId.isEmpty ? null : selectedBranchId,
                    hint: const Text("Select Branch"),
                    items: provider.branches.map((branch) {
                      return DropdownMenuItem(
                        value: branch['id'].toString(),
                        child: Text(branch['name'] ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBranchId = value ?? "";
                      });
                    },
                    validator: (v) => v == null || v.isEmpty ? "Select branch" : null,
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Male Treatments (comma-separated IDs)"),
                    onChanged: (v) => maleTreatments = v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Female Treatments (comma-separated IDs)"),
                    onChanged: (v) => femaleTreatments = v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "All Treatments (comma-separated IDs)"),
                    onChanged: (v) => treatments = v,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      Map<String, dynamic> data = {
                        "name": nameController.text,
                        "excecutive": exeController.text,
                        "payment": paymentController.text,
                        "phone": phoneController.text,
                        "address": addressController.text,
                        "total_amount": totalController.text,
                        "discount_amount": discountController.text,
                        "advance_amount": advanceController.text,
                        "balance_amount": balanceController.text,
                        "date_nd_time": dateController.text,
                        "id": 0, // New patient, number type
                        "male": maleTreatments,
                        "female": femaleTreatments,
                        "branch": selectedBranchId,
                        "treatments": treatments,
                      };

                      bool success = await provider.registerPatient(data);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Patient registered successfully")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.error ?? "Error")));
                      }
                    },
                    child: const Text("Register Patient"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
