import 'dart:io';
import 'dart:ui';

import '../../widget/design/settingColor.dart';
import '../../widget/design/basicButtons.dart';
import '../../structure/structureInit.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//design setting for getImage_greedot
double paddingForButtons = 30; //다 상대적인 값으로 교체 예정
double canvasSize = 400;

class getImage_greedot extends StatefulWidget {
  const getImage_greedot({Key? key}) : super(key: key);
  @override
  State<getImage_greedot> createState() => _getImageState();
}

class _getImageState extends State<getImage_greedot> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColorMain_greedot,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30, width: double.infinity),
            _buildPhotoArea(),
            SizedBox(height: 20),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: canvasSize,
            height: canvasSize,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: canvasSize,
            height: canvasSize,
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      children: [
        EleButton_greedot(
            additionalFunc: () {
              getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
            },
            buttonText: "카메라"),
        SizedBox(width: paddingForButtons),
        EleButton_greedot(
            additionalFunc: () {
              getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
            },
            buttonText: "갤러리"),
        SizedBox(width: paddingForButtons),
        EleButton_greedot(
            additionalFunc: () {
              importedImage = _image;
            },
            buttonText: "업로드"),
      ],
    );
  }
}