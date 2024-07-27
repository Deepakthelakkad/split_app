import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:split_app/login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();

  bool _obscurePassword = true;

  Splittreg()  {
    FirebaseFirestore.instance.collection("split expence").add({
      "Name": name.text,
      "Password": password.text,
      "Phone": phone.text,
    });
    print("successsssssssssssssssssssssssssssssssssssss");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key:formkey,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      child: Text(
                        'Registration',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter required details";
                              }
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter required details";
                                }
                              },
                              obscureText: _obscurePassword,

                              decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                                suffixIcon:IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                )
                          )),
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter required details";
                                }
                                if (value.length != 10) {
                                  return "Phone number must be 10 digits";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Phone",
                                  hintStyle: TextStyle(color: Colors.black))),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                Splittreg();
                              });
                            }
                          },
                          child: Container(
                            height: 51,
                            width: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade900,
                            ),
                            child: Center(
                              child: Text("SignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
