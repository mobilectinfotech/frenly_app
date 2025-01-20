import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_textfield.dart';
import 'package:frenly_app/core/constants/textfield_validation.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:frenly_app/presentation/Blog/upload_blog/upload_blog_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../post/upload_post/upload_post_screen.dart';



class UploadBlogScreen extends StatefulWidget {
  const UploadBlogScreen({super.key});

  @override
  State<UploadBlogScreen> createState() => _UploadBlogScreenState();
}

class _UploadBlogScreenState extends State<UploadBlogScreen> {


  UploadBolgController controller = Get.put(UploadBolgController());
  final _formKeyLogin = GlobalKey<FormState>();


  void _addTag() {
    setState(() {
      String inputText = controller.tagcontroller.text.trim();
      if (inputText.isNotEmpty) {
        controller.tags.add(inputText);
        controller.tagcontroller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Blog'.tr,
          style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w600,fontSize:20.fSize
          ),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation:2,
      ),

      body: Padding(
        padding:  EdgeInsets.only(left:20.aw,right:20.aw),
        child: Form(
          key: _formKeyLogin,
          child: ListView(
            children: [
            SizedBox(
            height: 20.ah,),
              SizedBox(
                child: Stack(
                  children: [
                    CustomImageView(
                       radius: BorderRadius.circular(20.adaptSize),
                      imagePath: controller.coverPhoto?.path ?? "assets/icons/Frame 1171278712.png",
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                        right: 15.aw,
                        bottom: 15.ah,
                        child: InkWell(
                            onTap: () {
                              _showImagePiker();
                            },
                            child: Image.asset('assets/image/edit.png',height: 38.adaptSize,width: 38.adaptSize,fit: BoxFit.fill,))),
                  ],),
              ),
              SizedBox(height: 10,),


              Padding(
                padding:  EdgeInsets.only(left: 5.0.aw ,right:  5.aw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.ah),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text('Title'.tr,
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                        ),
                      ),
                    ),

                    SizedBox(height: 10.ah,),
                    SizedBox(child: CustomTextFormField(hintText: "enter_title".tr,controller: controller.titleController,validator: Validator.notEmpty, context: context,)),
                    SizedBox(height: 10.ah,),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text('Body'.tr,
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                        ),
                      ),
                    ),
                    SizedBox(height: 10.ah,),
                    CustomTextFormField(context: context,hintText: "enter_body".tr,controller: controller.bodyController,maxLines: 8,validator: Validator.notEmpty,),
                    SizedBox(height: 20.ah,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('tags'.tr,
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                        ),),
                    ),
                    SizedBox(height: 10.ah,),
                    DetectableTextFieldWidget(
                      detectableTextEditingController:controller.detectableCaptionTextEditingController,
                      maxLines: 2,
                      hintText: "enter_tags".tr,
                    ),

                    // Row(
                    //   children: [
                    //
                    //
                    //     // SizedBox(
                    //     //   width: 280.aw,
                    //     //   child:CustomTextFormField(context: context,hintText: "enter_tags".tr,controller: controller.tagcontroller,),
                    //     // ),
                    //     IconButton(
                    //       icon: Icon(Icons.add),
                    //       onPressed: _addTag,
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 10),
                    // Wrap(
                    //   spacing: 8.0,
                    //   children: controller.tags.map((tag) {
                    //     return Chip(
                    //       label: Text(tag,style: TextStyle(fontSize: 10),),
                    //       onDeleted: () {
                    //         setState(() {
                    //           controller.tags.remove(tag);
                    //         });
                    //       },
                    //     );
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 10),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Text('Loaction'.tr,
                    //     style: TextStyle(
                    //         color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                    //     ),),
                    // ),
                    // const SizedBox(height: 10),
                    // CustomTextFormField(buildContext: context,hintText: "Enter location",controller: controller.locationController,maxLines: 1,),
                     const SizedBox(height: 30),
                    Center(
                      child: Obx(
                        ()=> CustomPrimaryBtn1(
                          title:'Postt'.tr,
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            if (_formKeyLogin.currentState!.validate()) {
                              if(controller.coverPhoto != null){
                                controller.postBlog();
                              }else{
                                AppDialog.taostMessage("_photo_can_not_be_empty".tr);
                              }
                            }

                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Demo_deshboardPage()));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => EditBlog_Screen()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              //SizedBox(height: 50.ah),
            ],
          ),
        ),
      ),
    );
  }

  Future<CroppedFile?> imagePicker({required ImageSource source,CropAspectRatio ? cropAspectRatio}) async {
    final ImagePicker _picker = ImagePicker();
    CroppedFile  ?  _croppedFile ;
    final XFile? pickedFile = await _picker.pickImage(source: source);
    _croppedFile = await ImageCropper().cropImage(
      compressQuality: 50,
      sourcePath: pickedFile!.path,
      aspectRatio: cropAspectRatio ?? const CropAspectRatio(ratioX: 200, ratioY: 100)  ,
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
                      title:  Text('gallery'.tr),
                      onTap: () async {
                        controller.coverPhoto = await  imagePicker(source: ImageSource.gallery,);
                        Get.back();

                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title:  Text('camera'.tr),
                    onTap: () async {
                      controller.coverPhoto = await    imagePicker(source: ImageSource.camera,);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });

  }



}
