import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Users Information',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final data = snapshot.data!.docs;
            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final user = data[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(
                      'Age: ${user['age']}, Hobby: ${user['hobby']} , Email: ${user['email']}'),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
