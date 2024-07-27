import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  List<bool> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: 800,
          decoration: BoxDecoration(
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('splitexpence').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final documents = snapshot.data?.docs ?? [];
                    if (_selectedItems.length != documents.length) {
                      _selectedItems = List<bool>.filled(documents.length, false);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return CheckboxListTile(
                          title: Text(doc['Name']),
                          value: _selectedItems[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedItems[index] = value!;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                InkWell(
                  onTap: () {
                    double amount = double.parse(_amountController.text);
                    List<bool> selectedItemsSnapshot = List.from(_selectedItems);

                    // Fetch the list of people again to get the count
                    FirebaseFirestore.instance.collection('splitexpence').get().then((querySnapshot) {
                      int selectedPersons = selectedItemsSnapshot.where((selected) => selected).length;
                      if (selectedPersons == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('No Selection'),
                              content: Text('Please select at least one person to split the amount.'),
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
                        double amountPerPerson = amount / selectedPersons;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Amount Per Person'),
                              content: Text('Each selected person should pay: Rs ${amountPerPerson.toStringAsFixed(2)}'),
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
                    });
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
