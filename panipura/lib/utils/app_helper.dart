import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import '../core/hooks/hook.dart';

class AppHelper {
  static Future<CroppedFile?> cropImage(File? imageFile) async {
    var croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        // aspectRatioPresets: Platform.isAndroid
        //     ? [
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio16x9
        //       ]
        //     : [
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio5x3,
        //         CropAspectRatioPreset.ratio5x4,
        //         CropAspectRatioPreset.ratio7x5,
        //         CropAspectRatioPreset.ratio16x9
        //       ],
        uiSettings: [
          AndroidUiSettings(
              toolbarColor:const Color(0xFF2564AF),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
              ),
              IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
                CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPresetCustom(),
              ],
          ),
        ]);
        

    return croppedFile;
  }

  // static Future<File> compress({
  //   required File image,
  //   int quality = 100,
  //   int percentage = 30,
  // }) async {
  //   var path = await FlutterNativeImage.compressImage(image.absolute.path,
  //       quality: quality, percentage: percentage);
  //   return path;
  // }
  static Future<File?> compress({
    
    required File image,
    int quality = 80,
    int percentage = 30,
  }) async {
    File? imageval;
    final imagepath=image.absolute.path;
    final lastIndex = imagepath.lastIndexOf(RegExp(r'.jp'));
  final splitted = imagepath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${imagepath.substring(lastIndex)}";
    var pathval = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,outPath,     
        quality: quality,
       // rotate: 
         );
         if(pathval !=null){
           imageval = File(pathval.path.toString());
         }
         
    return imageval;
  }
}
