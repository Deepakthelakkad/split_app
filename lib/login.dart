import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_app/registration.dart';
import 'package:split_app/second_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  var phone = TextEditingController();
  var password = TextEditingController();
  bool _obscurePassword = true;
  String id = "";

  splitLogin() async {
    final user = await FirebaseFirestore.instance
        .collection('splitexpence')
        .where('Phone', isEqualTo: phone.text)
        .where('Password', isEqualTo: password.text)
        .get();
    print("get data/////////////////////////////////////////");
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;

      // SharedPreferences data = await SharedPreferences.getInstance();
      // data.setString('id', id);

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return SecondPage();
        },
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "phone number and password error",
        style: TextStyle(color: Colors.red),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 293,
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(.3),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          controller: phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter required details";
                            }
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(color: Colors.black),
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter required details";
                            }
                          },
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(color: Colors.black),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            splitLogin();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Container(
                            height: 50,
                            width: 266,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.cyan.shade200),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              color: Colors.blue,
                              fontSize: 16),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //
                      //   },
                      //   child: Text(
                      //     'Forgot password',
                      //     style: TextStyle(
                      //         decoration: TextDecoration.underline,
                      //         decorationColor: Colors.green,
                      //         color: Colors.green,
                      //         fontSize: 16),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
