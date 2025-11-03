import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_textfield.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/post/upload_post/upload_post_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Widgets/custom_appbar.dart';

class PostPostScreen extends StatefulWidget {
  const PostPostScreen({super.key});

  @override
  State<PostPostScreen> createState() => _PostPostScreenState();
}

class _PostPostScreenState extends State<PostPostScreen> {
  UploadPostController controller = Get.put(UploadPostController());
  final _formKeyLogin = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: 'Photopost'.tr),
      body: Padding(
        padding: EdgeInsets.only(left: 20.aw, right: 20.aw),
        child: Form(
          key: _formKeyLogin,
          child: ListView(
            children: [
              SizedBox(
                height: 20.ah,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    _showImagePiker();
                  },
                  child: SizedBox(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.20),
                            borderRadius: BorderRadius.circular(20.adaptSize),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CustomImageView(
                            radius: BorderRadius.circular(20.adaptSize),
                            height: 330.aw,
                            width: 330.aw,
                            imagePath: controller.coverPhoto?.path ?? "assets/icons/Frame 1171278712.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            right: 15.aw,
                            bottom: 15.ah,
                            child: InkWell(
                                onTap: () {
                                  _showImagePiker();
                                },
                                child: Image.asset(
                                  'assets/image/edit.png',
                                  height: 38.adaptSize,
                                  width: 38.adaptSize,
                                  fit: BoxFit.fill,
                                ))),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.ah),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Caption'.tr,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 15.fSize))),

              SizedBox(height:20.ah),
              DetectableTextFieldWidget(detectableTextEditingController:controller.detectableCaptionTextEditingController),

              SizedBox(height: 60.ah),
              Center(
                child: Obx(
                  () => CustomPrimaryBtn1(
                    title: 'Postt'.tr,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        if (controller.coverPhoto != null && controller.detectableCaptionTextEditingController.text.isNotEmpty) {
                          controller.postPost();
                        }

                        else {
                          if(controller.coverPhoto == null){
                            AppDialog.taostMessage("_photo_can_not_be_empty".tr);
                          }else
                          if(controller.detectableCaptionTextEditingController.text.isEmpty == true){
                            AppDialog.taostMessage("_caption_can_not_be_empty".tr);
                          }
                        }
                      }

                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Demo_deshboardPage()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditBlog_Screen()));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40.ah,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<CroppedFile?> imagePicker(
      {required ImageSource source, CropAspectRatio? cropAspectRatio}) async {
    final ImagePicker _picker = ImagePicker();
    CroppedFile? _croppedFile;
    final XFile? pickedFile = await _picker.pickImage(source: source);
    _croppedFile = await ImageCropper().cropImage(
      compressQuality: 50,
      sourcePath: pickedFile!.path,
      aspectRatio:
      cropAspectRatio ?? const CropAspectRatio(ratioX: 200, ratioY: 200),
      maxWidth: 600,
      maxHeight: 600,
    );
    if (_croppedFile != null) {
      setState(() {});
    }
    return _croppedFile;
  }

  void _showImagePiker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('gallery'.tr),
                      onTap: () async {
                        controller.coverPhoto = await imagePicker(
                          source: ImageSource.gallery,
                        );
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: Text('camera'.tr),
                    onTap: () async {
                      controller.coverPhoto = await imagePicker(
                        source: ImageSource.camera,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}


class DetectableTextFieldWidget extends StatefulWidget {
   final DetectableTextEditingController detectableTextEditingController ;
   final int ? maxLines ;
   final String ? hintText ;
   const  DetectableTextFieldWidget({super.key,required this.detectableTextEditingController, this.maxLines,this.hintText});

  @override
  State<DetectableTextFieldWidget> createState() => _DetectableTextFieldWidgetState();
}

class _DetectableTextFieldWidgetState extends State<DetectableTextFieldWidget> {


  @override
  void initState() {
    super.initState();
    widget.detectableTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DetectableTextField(
          decoration: decoration,
          controller: widget.detectableTextEditingController,
          maxLines:widget.maxLines ?? 3,
        ),
      ],
    );
  }

  InputDecoration get decoration => InputDecoration(
      errorStyle: TextStyle(
        color: Color(0xffff0121),
      ),
      // hintText: widget.hintText ?? "Write caption and hashtags".tr,
      hintText: widget.hintText ?? "_write_caption_and_hashtags".tr,
      hintStyle: TextStyle(
          color: Colors.black.withOpacity(.40),
          fontWeight: FontWeight.bold,
          fontSize: 12.fSize),
      isDense: true,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 12.v,
      ),
      fillColor: Colors.white70,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: const BorderSide(
          color: Color(0xffff0121),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: const BorderSide(
          color: Color(0xffff0121),
          width: 1,
        ),
      ));
}


