import 'package:flutter/material.dart';
import 'package:noviindustechnologies/Table.dart';

class Patientdetails extends StatefulWidget {
  const Patientdetails({super.key});

  @override
  State<Patientdetails> createState() => _PatientdetailsState();
}

class _PatientdetailsState extends State<Patientdetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/patiantdetails.png",
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "KUMARAKOM",
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Cheepunkal P.O, Kumarakom,Kerala -686563",
                          style: TextStyle(fontSize: 8),
                        ),
                        Text(
                          "e-mail:unknown@gmail.com",
                          style: TextStyle(fontSize: 8),
                        ),
                        Text(
                          "Mob +91 9876543210,+91 9785543210",
                          style: TextStyle(fontSize: 8),
                        ),
                        Text(
                          "GST No: 32AABCU9603R1ZW",
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(),
              ),
              Row(
                children: [
                  Text(
                    "Patiant Details",
                    style: TextStyle(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 18, 107, 21)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Whatsapp Number",
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salih T",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                          Text(
                            "Nadakkav,Kozhikode",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                          Text(
                            "+71787654321",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Whatsapp Number",
                              style: TextStyle(
                                  fontSize: 7, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salih T",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                          Text(
                            "Nadakkav,Kozhikode",
                            style: TextStyle(
                              fontSize: 7,
                            ),
                          ),
                          Text(
                            "+91987654321",
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              DottedDivider(
                color: Colors.black,
                dashWidth: 4,
                dashSpace: 2,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TreatmentTable(),
              ),
              DottedDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Total Amount",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      Text(
                        "Advance",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      Text(
                        "Total Amount",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "₹ 9,620",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹ 500",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      Text(
                        "₹ 1,200",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      Text(
                        "₹ 7,620",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Thank you for choosing us",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "Your well-being is our commitment, and we're honored",
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "you've entrusted us with your health journey",
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w200),
                      ), SizedBox(
                height: 25,
              ),
                      Image.asset('assets/sign.png')
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DottedDivider({
    this.height = 1,
    this.color = Colors.black,
    this.dashWidth = 5,
    this.dashSpace = 3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
