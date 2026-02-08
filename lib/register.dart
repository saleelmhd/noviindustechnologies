import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:noviindustechnologies/addtreatementpopup.dart';
import 'package:noviindustechnologies/pdf.dart';
import 'package:provider/provider.dart';
import 'provider/services/patientlistApi.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappnumberclr = TextEditingController();
  final TextEditingController addressclr = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  final TextEditingController branchclr = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController advanceController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();

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
      appBar: AppBar(
        title: Text("Register"),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your full name",
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "Enter name" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Whatsapp Number",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: whatsappnumberclr,
                    decoration: InputDecoration(
                      hintText: "Enter your whatsapp number",
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter number" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: addressclr,
                    decoration: InputDecoration(
                      hintText: "Enter your full address",
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter address" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: locationcontroller,
                    decoration: InputDecoration(
                      hintText: "Choose your location",
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter location" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Branch",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: branchclr,
                    decoration: InputDecoration(
                      hintText: "Select the branch",
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter branch" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Treatments",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 203, 219, 247),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1. Couple Combo Package ..',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Male '),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text('Female '),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.edit_outlined,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(MediaQuery.of(context).size.width, 40),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AddTreatmentDialog(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        const Text("  Add Treatments"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: totalController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter total amount " : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Discount Amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: discountController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter discount amount" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Advance Amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: advanceController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter advance amount" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Balance Amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: balanceController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "enter balance amount" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Treatment Date",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select treatment date",
                      hintStyle: const TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 227, 230),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.indigo,
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                    validator: (v) => v!.isEmpty ? "Select date" : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Treatment Time",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: hourController.text.isEmpty
                              ? null
                              : hourController.text,
                          decoration: InputDecoration(
                            hintText: "HH",
                            filled: true,
                            fillColor: const Color.fromARGB(255, 223, 227, 230),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: List.generate(24,
                                  (index) => index.toString().padLeft(2, '0'))
                              .map((h) => DropdownMenuItem(
                                    value: h,
                                    child: Text(h),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            hourController.text = value ?? '';
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: minuteController.text.isEmpty
                              ? null
                              : minuteController.text,
                          decoration: InputDecoration(
                            hintText: "MM",
                            filled: true,
                            fillColor: const Color.fromARGB(255, 223, 227, 230),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: List.generate(60,
                                  (index) => index.toString().padLeft(2, '0'))
                              .map((m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            minuteController.text = value ?? '';
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 40),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                     
                      if (!_formKey.currentState!.validate()) return;

                      Map<String, dynamic> data = {
                        "name": nameController.text,
                        "phone": whatsappnumberclr.text,
                        "address": addressclr.text,
                        "total_amount": totalController.text,
                        "discount_amount": discountController.text,
                        "advance_amount": advanceController.text,
                        "balance_amount": balanceController.text,
                        "date_nd_time": dateController.text,
                        "id": 0,
                        "male": maleTreatments,
                        "female": femaleTreatments,
                        "branch": selectedBranchId,
                        "treatments": treatments,
                      };
 generatePdf();
                      bool success = await provider.registerPatient(data);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Patient registered successfully")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.error ?? "Error")));
                      }
                    },
                    child: const Text("Save"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
