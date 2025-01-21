import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_textfield.dart';
import 'package:frenly_app/core/constants/my_textfield.dart';
import 'package:frenly_app/core/constants/textfield_validation.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/vlog_by_id_model.dart';
import 'edit_vlog_controller.dart';

class EditVlogScreen extends StatefulWidget {
  VlogByIdModel vlogByIdModel;
   EditVlogScreen({super.key,required this.vlogByIdModel});

  @override
  State<EditVlogScreen> createState() => _EditVlogScreenState();
}

class _EditVlogScreenState extends State<EditVlogScreen> {
  EditVlogController controller = Get.put(EditVlogController());
  final _formKeyLogin = GlobalKey<FormState>();
  late VideoPlayerController _controller;


  data(){
    controller.titleController.text ="${widget.vlogByIdModel.vlog?.title}";
    controller.desController.text ="${widget.vlogByIdModel.vlog?.description}";
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse("${widget.vlogByIdModel.vlog?.videoUrl}"))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    data();
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
          'edit_vlog'.tr,
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
                InkWell(
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
                      aspectRatio: 2,
                      child: VideoPlayer(_controller),
                    ),
                  )
                      : SizedBox(
                    width: double.infinity,
                    height: 170.ah,
                    child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 1,)),
                  ),
                ),
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
                            aspectRatio: 2,
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
                  'Title'.tr,
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
                    title: 'update_vlog'.tr,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        if(controller.pikedVideo != null ){
                          controller.editVlog(title: controller.titleController.text, des: controller.desController.text, id: "${widget.vlogByIdModel.vlog?.id}",videopath: controller.pikedVideo!.path!);
                        }else{
                          controller.editVlog(title: controller.titleController.text, des: controller.desController.text, id: "${widget.vlogByIdModel.vlog?.id}");
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
