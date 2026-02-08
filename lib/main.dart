import 'package:flutter/material.dart';
import 'package:noviindustechnologies/loginpage.dart';
import 'package:noviindustechnologies/patientdetails.dart';
import 'package:noviindustechnologies/patientlist.dart';
import 'package:noviindustechnologies/patientlistApi.dart';
import 'package:noviindustechnologies/provider/provider.dart';
import 'package:noviindustechnologies/provider/services/loginApi.dart';
import 'package:noviindustechnologies/register.dart';

import 'package:provider/provider.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
  // should print 'hello'

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PatientRegisterScreen(),
      ),
    );
  }
}
