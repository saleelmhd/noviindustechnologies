import 'package:flutter/material.dart';

class AddTreatmentDialog extends StatefulWidget {
  @override
  _AddTreatmentDialogState createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  String? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  List<String> treatments = [
    "Couple Combo Package",
    "Single Package",
    "Premium Package"
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Choose Treatment",
        style: TextStyle(fontSize: 16),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown
            DropdownButtonFormField<String>(
              value: selectedTreatment,
              decoration: InputDecoration(
                hintText: "Choose treatment",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: treatments
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTreatment = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Male counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 230, 230)
                        .withOpacity(0.8), // light white
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black87),
                  ),
                  child: Text(
                    "male    ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          if (maleCount > 0) maleCount--;
                        });
                      },
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.8), // light white background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        "$maleCount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          maleCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Female counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 230, 230)
                        .withOpacity(0.8), // light white
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black87),
                  ),
                  child: Text(
                    "Female",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            if (femaleCount > 0) femaleCount--;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.8), // light white background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        "$femaleCount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          femaleCount++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width, // full width
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (selectedTreatment != null) {
                  print(
                      "Treatment: $selectedTreatment, Male: $maleCount, Female: $femaleCount");
                  Navigator.pop(context); // close dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a treatment")),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
