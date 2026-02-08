import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:noviindustechnologies/patientlist.dart';
import 'package:noviindustechnologies/provider/services/loginApi.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

 final TextEditingController _usernameController =
      TextEditingController(text: "test_user");
  final TextEditingController _passwordController =
      TextEditingController(text: "12345678");

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: ClipRRect(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 2),
                    child: Image.asset(
                      'assets/login_img.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 90,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Login Or Register To Book",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Your Appointments",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    validator: (v) => v!.isEmpty ? 'Enter username' : null,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(fontSize: 13),
                      filled: true,
                      fillColor: const Color.fromARGB(
                          197, 230, 241, 241), // light grey background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // removes the outline
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (v) => v!.isEmpty ? 'Enter password' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(fontSize: 13),
                      filled: true,
                      fillColor: const Color.fromARGB(197, 230, 241, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                    authProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text.trim();
                        String password = _passwordController.text.trim();

                        bool success =
                            await authProvider.login(username, password);

                        if (success) { 
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Patientlist()));
                        } else { 
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login failed!'),
                            ),
                          );
                        }
                      },
                     
                       style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Login'),
                    ),
                 
                  
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: Text(
                    'By creating or logging into an account you are agreeing',
                    style: TextStyle(fontSize: 12),
                  )),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'with our ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Term and conditions',
                        style: TextStyle(fontSize: 12, color: Colors.indigo),
                      ),
                      Text(
                        ' and',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        ' Privacy Policy',
                        style: TextStyle(fontSize: 12, color: Colors.indigo),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
