import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_app/widgets/amostragem/modal_image_picker_widget.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInputWidget extends StatefulWidget {
  ImageInputWidget({Key? key, required this.onSelectImage, this.storedImage});
  final Function onSelectImage;
  File? storedImage = null;

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  void openModalImagePicker(pickerCamera, pickerGallery) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalImagePickerWidget(
          takePictureByCamera: pickerCamera,
          takePictureByGallery: pickerGallery,
        );
      },
    );
  }

  takePictureByCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }
    Navigator.of(context).pop();
    setState(() {
      widget.storedImage = File(image.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(widget.storedImage!.path);
    final savedImage = await widget.storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  takePictureByGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    Navigator.of(context).pop();
    setState(() {
      widget.storedImage = File(image.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(widget.storedImage!.path);
    final savedImage = await widget.storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: widget.storedImage != null
                ? Image.file(
                    widget.storedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Text('Nenhuma Imagem'),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.center,
            child: TextButton.icon(
              onPressed: () {
                openModalImagePicker(takePictureByCamera, takePictureByGallery);
              },
              icon: Icon(Icons.camera),
              label: Text("Adicionar Imagem"),
            ),
          ),
        )
      ],
    );
  }
}
