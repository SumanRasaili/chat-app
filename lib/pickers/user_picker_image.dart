
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
   
  void pickImage ()async{
   final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:_pickedImage != null ?  FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Pick an Image')),
      ],
    );
  }
}
