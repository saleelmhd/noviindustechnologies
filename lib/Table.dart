import 'package:flutter/material.dart';

class TreatmentTable extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'treatment': 'Couple Combo',
      'price': 2000,
      'male': 1,
      'female': 1,
      'total': 2000,
    },
    {
      'treatment': 'Couple Combo',
      'price': 3000,
      'male': 1,
      'female': 2,
      'total': 500,
    },
    {
      'treatment': 'Single Session',
      'price': 1200,
      'male': 1,
      'female': 0,
      'total': 1000,
    },
    // Add more rows as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          color: Colors.grey.shade300, // optional light line between rows
          width: 0.5,
        ),
        // No vertical borders
      ),
      children: [
        // Table Header
        TableRow(
         
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Treatment',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green,fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Price',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green,fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Male',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green,fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Female',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green,fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Total',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green,fontSize: 10),
              ),
            ),
          ],
        ),

        // Table Rows
        ...data.map((row) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row['treatment'].toString(),style: TextStyle(fontSize:  9),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [Text("₹ ",style: TextStyle(fontSize:  9),),
                    Text(row['price'].toString(),style: TextStyle(fontSize:  9),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row['male'].toString(),style: TextStyle(fontSize:  9),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row['female'].toString(),style: TextStyle(fontSize:  9),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(row['total'].toString(),style: TextStyle(fontSize:  9),),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
