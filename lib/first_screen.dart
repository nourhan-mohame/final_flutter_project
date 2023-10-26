import 'package:flutter/material.dart';
import 'contact_model.dart';
import 'second_screen.dart';

class First_Screen extends StatefulWidget {
  const First_Screen({Key? key}) : super(key: key);

  @override
  State<First_Screen> createState() => _First_ScreenState();
}

class _First_ScreenState extends State<First_Screen> {
  List<Contact> contacts = [];

  void onSaveContact(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  void onEditContact(int index) {
    Contact? contact = contacts[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          onSaveContact: (editedContact) {
            setState(() {
              contacts.removeAt(index);
              contacts.insert(index, editedContact);
            });
            Navigator.pop(context); // Return to the first screen
          },
          contact: contact,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact App",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white70,
      ),
      body: Stack(
        children: [
          // Main content of the screen
          Column(),
          // Floating action button positioned at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        onSaveContact: onSaveContact,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          Center(
            child: contacts.isEmpty
                ? Text(
                    "No contacts yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.blueAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].firstName[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].firstName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              contacts[index].phone,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  onEditContact(index); // Call the onEditContact() method
                },
                child: Icon(Icons.edit),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
