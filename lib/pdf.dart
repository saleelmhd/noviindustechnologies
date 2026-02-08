import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePdf() async {
  final pdf = pw.Document();

  // Load images from assets
  final patientImage = pw.MemoryImage(
    (await rootBundle.load('assets/patiantdetails.png')).buffer.asUint8List(),
  );

  final signatureImage = pw.MemoryImage(
    (await rootBundle.load('assets/sign.png')).buffer.asUint8List(),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  height: 60,
                  width: 60,
                  child: pw.Image(patientImage),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("KUMARAKOM",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Cheepunkal P.O, Kumarakom, Kerala -686563",
                        style: pw.TextStyle(fontSize: 8)),
                    pw.Text("e-mail: unknown@gmail.com",
                        style: pw.TextStyle(fontSize: 8)),
                    pw.Text("Mob +91 9876543210, +91 9785543210",
                        style: pw.TextStyle(fontSize: 8)),
                    pw.Text("GST No: 32AABCU9603R1ZW",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold)),
                  ],
                )
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Text("Patient Details",
                style: pw.TextStyle(fontSize: 10, color: PdfColors.green)),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Name",
                          style: pw.TextStyle(
                              fontSize: 7, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Address",
                          style: pw.TextStyle(
                              fontSize: 7, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Whatsapp Number",
                          style: pw.TextStyle(
                              fontSize: 7, fontWeight: pw.FontWeight.bold),
                        )
                      ],
                    ),
                    pw.SizedBox(
                      width: 12,
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Salih T",
                          style: pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Nadakkav,Kozhikode",
                          style: pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "+71787654321",
                          style: pw.TextStyle(
                            fontSize: 7,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  width: 12,
                ),
                pw.Row(
                  children: [
                    pw.Container(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Booked on",
                            style: pw.TextStyle(
                                fontSize: 7, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Treatement Date",
                            style: pw.TextStyle(
                                fontSize: 7, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Treatement Time",
                            style: pw.TextStyle(
                                fontSize: 7, fontWeight: pw.FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      width: 12,
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "31/01/2024  | 12:12 pm",
                          style: pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "21/02/2024",
                          style: pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "11:00am",
                          style: pw.TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 10),
              child: dottedDivider(
                height: 1,
                color: PdfColors.grey,
                dashWidth: 4,
                dashSpace: 2,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10, bottom: 10),
              child: pw.Table(
                columnWidths: const {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(2),
                },
                children: [
                  // Table Header
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

                  // Table Rows
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
                              // pw.Text("₹ ", style: const pw.TextStyle(fontSize: 9)),
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
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 10),
              child: dottedDivider(
                height: 1,
                color: PdfColors.grey,
                dashWidth: 4,
                dashSpace: 2,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Total Amount",
                      style: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Discount",
                      style: pw.TextStyle(
                        fontSize: 9,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Advance",
                      style: pw.TextStyle(
                        fontSize: 9,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Balance",
                      style: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(
                  width: 25,
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      " 9,620",
                      style: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      " 500",
                      style: pw.TextStyle(
                        fontSize: 9,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      " 1,200",
                      style: pw.TextStyle(
                        fontSize: 9,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      " 7,620",
                      style: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            pw.SizedBox(
              height: 25,
            ),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("Thank you for choosing us",
                      style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green)),
                  pw.SizedBox(height: 15),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text(
                            "Your well-being is our commitment, and we're honored",
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.normal),
                          ),
                          pw.Text(
                            "you've entrusted us with your health journey",
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.normal),
                          ),
                          pw.SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Image(signatureImage, height: 40),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // Print or share PDF
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

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

pw.Widget dottedDivider({
  double height = 1,
  PdfColor color = PdfColors.black,
  double dashWidth = 5,
  double dashSpace = 3,
}) {
  return pw.LayoutBuilder(builder: (context, constraints) {
    final boxWidth = constraints!.maxWidth;
    final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: List.generate(dashCount, (_) {
        return pw.Container(
          width: dashWidth,
          height: height,
          color: color,
        );
      }),
    );
  });
}
