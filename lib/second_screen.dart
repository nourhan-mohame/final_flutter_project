import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'contact_model.dart';

class SecondScreen extends StatefulWidget {
  final Function(Contact) onSaveContact;
  final Contact? contact;

  SecondScreen({Key? key, required this.onSaveContact, this.contact})
      : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  XFile? returnImage;
  Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      firstNameController.text = widget.contact!.firstName;
      phoneController.text = widget.contact!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact List",
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                selectedImage != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(selectedImage!),
                      )
                    : const CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                      ),
                Positioned(
                  bottom: -0,
                  left: 140,
                  child: IconButton(
                    onPressed: () {
                      showImagePickerOption(context);
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: firstNameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Family Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Company",
                    prefixIcon: Icon(Icons.business_sharp),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Date",
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    String firstName = firstNameController.text.trim();
                    String phone = phoneController.text.trim();
                    firstNameController.clear();
                    phoneController.clear();
                    if (firstName.isNotEmpty && phone.isNotEmpty) {
                      Contact newContact =
                          Contact(firstName: firstName, phone: phone);
                      widget.onSaveContact(newContact);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImageFromGallery() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage == null) return;
    setState(() {
      returnImage = selectedImage;
      selectedImage = File(selectedImage!.path).readAsBytesSync() as XFile?;
    });
    Navigator.of(context).pop();
  }

  void _pickImageFromCamera() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImage == null) return;
    setState(() {
      returnImage = selectedImage;
      selectedImage = File(selectedImage!.path).readAsBytesSync() as XFile?;
    });
    Navigator.of(context).pop();
  }
}
