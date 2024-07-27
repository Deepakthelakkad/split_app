import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  List<Map<String, dynamic>> people = [
    {"name": "Alice", "isSelected": false},
    {"name": "Bob", "isSelected": false},
    {"name": "Charlie", "isSelected": false},
    // Add more people here or fetch from the `splitexpence` collection
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/tech.jpeg")),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(30, 179, 241, 0.792156862745098),
                Color.fromRGBO(246, 247, 248, 1.0),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(
                  child: Text(
                    "Expense Splitting APP",
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Enter your Amount",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: people.map((person) {
                      return CheckboxListTile(
                        title: Text(person['name']),
                        value: person['isSelected'],
                        onChanged: (bool? value) {
                          setState(() {
                            person['isSelected'] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                InkWell(
                  onTap: () {
                    double amount = double.parse(_amountController.text);
                    int selectedPersonsCount = people
                        .where((person) => person['isSelected'] == true)
                        .length;

                    if (selectedPersonsCount > 0) {
                      double amountPerPerson = amount / selectedPersonsCount;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Amount Per Person'),
                            content: Text(
                                'Each person should pay: Rs ${amountPerPerson.toStringAsFixed(2)}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('No Person Selected'),
                            content: Text('Please select at least one person.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade900,
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.merriweather(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
