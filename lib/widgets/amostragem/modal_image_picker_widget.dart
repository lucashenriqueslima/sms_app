import 'package:flutter/material.dart';

class ModalImagePickerWidget extends StatefulWidget {
  final dynamic takePictureByCamera;
  final dynamic takePictureByGallery;

  ModalImagePickerWidget({
    Key? key,
    required this.takePictureByCamera,
    required this.takePictureByGallery,
  }) : super(key: key);

  @override
  _ModalImagePickerWidgetState createState() => _ModalImagePickerWidgetState();
}

class _ModalImagePickerWidgetState extends State<ModalImagePickerWidget> {
  void takePictureByCameraSelect() {
    widget.takePictureByCamera();
  }

  void takePictureByGallerySelect() {
    widget.takePictureByGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: takePictureByCameraSelect,
              icon: Icon(Icons.camera_alt),
              label: Text("Tirar Foto"),
            ),
            //
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: takePictureByGallerySelect,
              icon: Icon(Icons.camera),
              label: Text("Escolher na Galeria"),
            ),
          ],
        ),
      ),
    );
  }
}
