import 'package:ambulance/screens/loginpage.dart';
import 'package:ambulance/widget/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/text.dart';

class RigesteerPage extends StatefulWidget {
  const RigesteerPage({super.key});

  @override
  State<RigesteerPage> createState() => _RigesteerPageState();
}

class _RigesteerPageState extends State<RigesteerPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool _obsecureText = true;
  LoginR() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users.add({
      'email': email.text,
      'password': password.text,
      'username': username.text,
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await credential.user!.updateProfile(displayName: username.text);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogInPage(),
          ));
    } on FirebaseAuthException catch (e) {
      print(
        e.toString(),
      );
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey,
              content: Text(
                e.message.toString(),
                style: GoogleFonts.rubik(color: Color.fromARGB(255, 8, 8, 8)),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 124, 174, 240),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 252, 252, 252),
              border: Border.all(
                  width: 3, color: Color.fromARGB(255, 102, 168, 255)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Consumer(
                builder: (context, value1, child) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextFile.T_Account_Create,
                        style: GoogleFonts.urbanist(
                            color: Colors.black,
                            letterSpacing: .7,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        TextFile.T_SingnUp,
                        style: GoogleFonts.urbanist(
                            color: Colors.black,
                            letterSpacing: .7,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        // email text field------------------------------
                        controller: username,
                        obscureText: false,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        // email text field------------------------------
                        controller: email,
                        obscureText: false,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                                onPressed: () {
                                  LoginR();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 124, 174, 240),
                                ),
                                child: const Text(
                                  TextFile.SignUP_button,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInPage()));
                          },
                          child: Text(
                            TextFile.T_already,
                            style: GoogleFonts.aBeeZee(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
