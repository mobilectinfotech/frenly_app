import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';import 'package:velocity_x/velocity_x.dart';
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

import '../../post/upload_post/upload_post_screen.dart';

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
                        ) : Container(),
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
                child: Text('title'.tr,
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

              SizedBox(height: 20.ah),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Description'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.fSize),
                ),
              ),

              SizedBox(height: 10.ah),
              CustomTextFormField(
                context: context,
                hintText: "enterdescription".tr,
                controller: controller.descriptionController,
                maxLines: 4,
                validator: Validator.notEmpty,
              ),

              SizedBox(height: 20.h),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Tag_Location'.tr,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 15.fSize))),

              SizedBox(height: 10.h),
              GooglePlacesAutoCompleteTextFormField(
                cursorColor:Colors.black,
                cursorHeight: 20.h,
                fetchCoordinates: true,
                autocorrect: true,
                decoration:InputDecoration(
                  hintText:'Tag_Location'.tr,
                  hintStyle:  TextStyle(
                      color: Colors.black.withOpacity(.40),
                      fontWeight: FontWeight.bold, fontSize: 12.fSize),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.aw),
                    child:Icon(Icons.location_on_outlined,size: 20.fSize),
                    //Image.asset(Assets.imagesGPS, fit: BoxFit.contain, height: 32.h, width: 32.aw),
                  ),
                  prefixIconConstraints: BoxConstraints(minHeight: 24.ah, minWidth: 24.aw),
                  suffixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.aw),
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.aw, vertical: 12.h,),
                  fillColor: Colors.white70,
                  filled: true,
                  border:OutlineInputBorder(
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
                ),

                //googleAPIKey: 'AIzaSyBft0B13N7l_6rzORlvwevfmFzQ4bbX-DE',
                googleAPIKey: 'AIzaSyBkRszzvipjTTFm7qII6QkK5hoWVbewtrE',
                textEditingController: controller.locationController,
                debounceTime: 100, // defaults to 600 ms
                scrollPhysics: BouncingScrollPhysics(),
                onSuggestionClicked: (prediction) async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  print('placeDetails: lat=${prediction.lat}, lng=${prediction.lng}');
                  if (prediction.lat != null && prediction.lng != null) {
                    controller.lat = prediction.lat!;
                    controller.lng = prediction.lng!;
                  } else {
                    // controller.lat = null;
                    // controller.lng = null;
                    //  Toasts.getErrorToast(text: "Successfully fetch the coordinates for this location");
                  }
                  controller.lat = prediction.lat ?? "";
                  controller.lng = prediction.lng ?? "";
                  controller.locationController.text = prediction.description ?? "";
                  controller.locationController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                  if (prediction.placeId != null) {
                    await fetchCoordinates(prediction.placeId!, controller);
                  } else {
                    //  Toasts.getErrorToast(text: "Unable to fetch coordinates for this location");
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  controller.lat = null;
                  controller.lng = null;
                },
              ),


              // SizedBox(height: 20.ah),
              // Obx(() {
              //   if (controller.uploadProgress.value > 0 &&
              //       controller.uploadProgress.value < 1) {
              //     return Column(
              //       children: [
              //         Text("Uploading ${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%",
              //        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 15.fSize),
              //         ),
              //         SizedBox(height: 10),
              //         LinearProgressIndicator(
              //           value: controller.uploadProgress.value,
              //           minHeight: 6,
              //         ),
              //         SizedBox(height: 20),
              //       ],
              //     );
              //   } else {
              //     return SizedBox.shrink();
              //   }
              // }),
              //

              SizedBox(height: 130.ah),
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

              SizedBox(height: 40.ah),

            ],
          ),
        ),
      ),

      /// FULL SCREEN UPLOAD OVERLAY 👇
     /* Obx(() {
        if (controller.isUploading.value == true) {
          return Container(
            color: Colors.black.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    value: controller.uploadProgress.value,
                    strokeWidth: 6,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 20),
                  Text("Uploading ${ (controller.uploadProgress.value * 100).toStringAsFixed(0) }%",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      }),*/
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


Future<void> fetchCoordinates(String placeId, UploadVlogController controller) async {
  // const apiKey = 'AIzaSyBft0B13N7l_6rzORlvwevfmFzQ4bbX-DE';
  const apiKey = 'AIzaSyBkRszzvipjTTFm7qII6QkK5hoWVbewtrE';
  final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';

  try {
    final dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      final location = data['result']['geometry']['location'];
      controller.lat = location['lat'].toString();
      controller.lng = location['lng'].toString();
      print('Fetched coordinates: lat=${controller.lat}, lng=${controller.lng}');
    } else {
      // Toasts.getErrorToast(text: "Failed to fetch coordinates");
    }
  } catch (e) {
    // Toasts.getErrorToast(text: "Error fetching coordinates: $e");
  }
}
