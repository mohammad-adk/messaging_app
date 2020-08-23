import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) imagePickerFN;

  UserImagePicker(this.imagePickerFN);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final _picker = ImagePicker();

  void _pickImage()async{
    final pickedImageFile = await _picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 150 , maxWidth: 150);

    setState(() {
      _image = File(pickedImageFile.path);
    });
    widget.imagePickerFN(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: _image != null ? FileImage(_image) :null,
          radius: 40,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('add image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
