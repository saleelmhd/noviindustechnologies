import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class TreatmentTablePdf {
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
  ];

  pw.Widget build() {
    return 
    pw.Table(
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(
          color: PdfColors.grey300,
          width: 0.5,
        ),
      ),
      columnWidths: const {
        0: pw.FlexColumnWidth(3),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(2),
        3: pw.FlexColumnWidth(2),
        4: pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Treatment',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                    fontSize: 10),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Price',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                    fontSize: 10),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Male',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                    fontSize: 10),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Female',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                    fontSize: 10),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Total',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                    fontSize: 10),
              ),
            ),
          ],
        ),

        ...data.map((row) {
          return pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(row['treatment'].toString(),
                    style: const pw.TextStyle(fontSize: 9)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Row(
                  children: [
                    pw.Text("₹ ", style: const pw.TextStyle(fontSize: 9)),
                    pw.Text(row['price'].toString(),
                        style: const pw.TextStyle(fontSize: 9)),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(row['male'].toString(),
                    style: const pw.TextStyle(fontSize: 9)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(row['female'].toString(),
                    style: const pw.TextStyle(fontSize: 9)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(row['total'].toString(),
                    style: const pw.TextStyle(fontSize: 9)),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
