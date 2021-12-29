import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropperPage extends StatefulWidget {
  const ImageCropperPage({Key? key}) : super(key: key);

  @override
  State<ImageCropperPage> createState() => _ImageCropperPageState();
}

class _ImageCropperPageState extends State<ImageCropperPage> {
  ImagePicker imagePicker = ImagePicker();
  File? dosya;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker & Image Cropper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  pickPhoto();
                },
                child: const Text('Pick Photo')),
            dosya == null ? Container() : Image.file(dosya!),
          ],
        ),
      ),
    );
  }

  Future<void> pickPhoto() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);
    dosya = File(photo!.path);
    var cropImage = await ImageCropper.cropImage(
      sourcePath: dosya!.path,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      //cropStyle: CropStyle.circle,
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: const AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarTitle: 'Kırpma İşlemi',
        toolbarColor: Colors.blue,
        cropGridStrokeWidth: 2,
      ),
      iosUiSettings: const IOSUiSettings(rectX: 1,rectY: 1)
    );
    setState(() {
      dosya = File(cropImage!.path);
    });
    print(await dosya!.length()/1024/1024);
  }
}
