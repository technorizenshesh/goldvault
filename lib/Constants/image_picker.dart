import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File?>  pickImage(bool isGallery) async {
  final ImagePicker picker = ImagePicker();
  File? image;
  String? _imageFile;
  try {
    print('about to pick image');
    XFile? pickedFile;
    if (isGallery) {
      pickedFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    } else {
      pickedFile =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    }
    print('the error is $pickedFile');
    int length = await pickedFile!.length();
    File? croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.rectangle,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: length > 100000
            ? length > 200000
            ? length > 300000
            ? length > 400000
            ? 5
            : 10
            : 20
            : 30
            : 50,
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
        ],
        androidUiSettings: AndroidUiSettings(
            activeControlsWidgetColor: Colors.grey,
            toolbarTitle: 'Adjust your Post',
            toolbarColor: Colors.grey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    _imageFile = croppedFile!.path;
    image = File(croppedFile.path);
    print(croppedFile);
    print(image);

    return image;
  } catch (e) {
    print("Image picker error $e");
  }
}
