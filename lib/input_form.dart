import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infodisplay/display_page.dart';

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _hobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Entry Form',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    if (!value.contains('@')) {
                      return 'Email must contain @';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                      labelText: 'Age', prefixIcon: Icon(Icons.calendar_today)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: TextFormField(
                  controller: _hobbyController,
                  decoration: InputDecoration(
                      labelText: 'Favourite Hobby',
                      prefixIcon: Icon(Icons.favorite)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your hobby';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: _saveData,
                child: Text(
                  'Save Data',
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewData()),
                  );
                },
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('View Data', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('users').add({
        'name': _nameController.text,
        'email': _emailController.text,
        'age': _ageController.text,
        'hobby': _hobbyController.text,
      });

      _nameController.clear();
      _emailController.clear();
      _ageController.clear();
      _hobbyController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }
}
