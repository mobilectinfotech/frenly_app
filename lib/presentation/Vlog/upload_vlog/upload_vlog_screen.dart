import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_textfield.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_textfield.dart';
import 'package:frenly_app/core/constants/textfield_validation.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Vlog/upload_vlog/upload_vlog_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadVlogScreen extends StatefulWidget {
  const UploadVlogScreen({super.key});

  @override
  State<UploadVlogScreen> createState() => _UploadVlogScreenState();
}

class _UploadVlogScreenState extends State<UploadVlogScreen> {
  UploadVlogController controller = Get.put(UploadVlogController());
  final _formKeyLogin = GlobalKey<FormState>();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'create_vlog'.tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.fSize),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.aw, right: 20.aw),
        child: Form(
          key: _formKeyLogin,
          child: ListView(
            children: [
              SizedBox(
                height: 20.ah,
              ),
              SizedBox(
                child: Stack(
                  children: [
                    controller.pikedVideo == null ?
                    Container(
                      height: 196.ah,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: Center(child:  Text("select_video".tr)),
                    ):InkWell(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Center(
                        child: _controller.value.isInitialized
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        )
                            : Container(),
                      ),
                    ),
                    Positioned(
                        right: 15.aw,
                        bottom: 15.ah,
                        child: InkWell(
                            onTap: () {
                              _showVideoPiker();
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

              SizedBox(
                height: 20.ah,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'title'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.fSize),
                ),
              ),
              SizedBox(
                height: 10.ah,
              ),
              CustomTextFormField(
                context: context,
                hintText: "enter_title".tr,
                controller: controller.titleController,
                validator: Validator.notEmpty,
              ),
              SizedBox(
                height: 10.ah,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Description'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.fSize),
                ),
              ),
              SizedBox(
                height: 10.ah,
              ),
              CustomTextFormField(
                context: context,
                hintText: "enterdescription".tr,
                controller: controller.desController,
                maxLines: 4,
                validator: Validator.notEmpty,
              ),
              SizedBox(
                height: 130.ah,
              ),
              Center(
                child: Obx(
                  ()=> CustomPrimaryBtn1(
                    title: 'Postt'.tr,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        if(controller.pikedVideo != null ){
                          controller.postVlog();
                        }else{
                          AppDialog.taostMessage("Video Not be Empty");
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

  Future<XFile?> imagePicker(
      {required ImageSource source, CropAspectRatio? cropAspectRatio}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pikedVideo = await _picker.pickVideo(source: source);
    controller.pikedVideo = _pikedVideo;
    _controller = VideoPlayerController.file(File("${_pikedVideo!.path}"))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    return _pikedVideo;
  }

  void _showVideoPiker() {
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
                      title:  Text('gallery'.tr),
                      onTap: () async {
                        await imagePicker(
                          source: ImageSource.gallery,
                        );
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title:  Text('camera'.tr),
                    onTap: () async {
                      await imagePicker(
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
