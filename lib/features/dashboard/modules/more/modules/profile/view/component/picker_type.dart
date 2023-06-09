// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
class PickerType {

  Future<XFile?> showPickerTypeDialog({bool isFolder = true}) async {
    int type = -1;
    XFile? result;
    await showModalBottomSheet(
        context: globalKey.currentContext!,
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: context.theme.primaryColor.withOpacity(0.1),
                        child: IconButton(
                          key: cameraIconButtonKey,
                          onPressed: () {
                            type = 0;
                            CustomNavigator.instance.pop();
                          },
                          icon: Icon(
                            Icons.photo_camera_rounded,
                            color: context.theme.primaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          tr("camera"),
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontFamily: 'Light',
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:  context.theme.primaryColor.withOpacity(0.1),
                        child: IconButton(
                          onPressed: () {
                            type = 1;
                            CustomNavigator.instance.pop();
                          },
                          icon: Icon(
                            Icons.photo,
                            color:  context.theme.primaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          tr("gallery"),
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontFamily: 'Light',
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  // if (isFolder)
                  //   Column(
                  //     children: <Widget>[
                  //       CircleAvatar(
                  //         radius: 30,
                  //         backgroundColor:  context.theme.primaryColor.withOpacity(
                  //             0.1),
                  //         child: IconButton(
                  //           onPressed: () {
                  //             type = 2;
                  //             CustomNavigator.instance.pop();
                  //           },
                  //           icon: Icon(
                  //             Icons.folder_sharp,
                  //             size: 25,
                  //             color:  context.theme.primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //           tr("folder"),
                  //           style: TextStyle(
                  //             color:  context.theme.primaryColor,
                  //             fontFamily: 'Light',
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                ],
              ),
            ),
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3));

    if (type != -1) {
      if (type == 2) {
        // result = XFile((await FilePicker.platform.pickFiles(
        //   type: FileType.custom,
        //   allowedExtensions: <String>['jpg', 'png', 'pdf'],
        // ))!
        //     .files
        //     .first
        //     .path!);

      } else {
        result = await ImagePicker().pickImage(
          source: type == 1 ? ImageSource.gallery : ImageSource.camera,
          maxHeight: 1000,
          maxWidth: 1000,
        );
      }
      if (result != null && (type == 1 || type == 0)) {
        result = XFile((await ImageCropper().cropImage(
          sourcePath: result.path,
          aspectRatioPresets: <CropAspectRatioPreset>[
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: <PlatformUiSettings>[
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: globalKey.currentContext!.theme.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: true,
                aspectRatioLockDimensionSwapEnabled: true)
          ],
        ))
        !.path);
      }
    }

    return result;
  }
}
