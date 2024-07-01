import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_textfield.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_textfield.dart';
import 'package:frenly_app/core/constants/textfield_validation.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:frenly_app/presentation/upload/post_photo_screen/post_photo_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Widgets/ImageProcessor.dart';



class PostPostScreen extends StatefulWidget {
  const PostPostScreen({super.key});

  @override
  State<PostPostScreen> createState() => _PostPostScreenState();
}

class _PostPostScreenState extends State<PostPostScreen> {


  PostPostController controller = Get.put(PostPostController());
  final _formKeyLogin = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photopost'.tr,
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
              Center(
                child: SizedBox(
                  child: Stack(
                    children: [
                      CustomImageView(
                         radius: BorderRadius.circular(20.adaptSize),
                         height: 330.aw,
                         width: 330.aw,
                         imagePath: controller.coverPhoto?.path,
                         fit: BoxFit.cover,
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
              ),
              SizedBox(height: 30.ah,),
              Padding(
                padding: const EdgeInsets.only(left:10),
                child: Text('Caption'.tr, style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize),
                ),
              ),
              SizedBox(height: 20.ah,),
              CustomTextFormField(context: context,hintText: "Enter caption",controller: controller.captionController,maxLines: 3,validator: Validator.notEmpty,),
              SizedBox(height: 60.ah,),
              Center(
                child: Obx(
                  ()=> CustomPrimaryBtn1(
                    title:'Postt'.tr,
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        if(controller.coverPhoto != null ){
                          controller.postPost();
                        }else{
                          AppDialog.taostMessage("Photo Not be Empty");
                        }
                      }

                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Demo_deshboardPage()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditBlog_Screen()));
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.ah,),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _pickAndProcessImage() async {
    final result = await ImageProcessor.pickAndProcessImage(
        ImageSource.gallery,
        const CropAspectRatio(ratioX: 1, ratioY: 1)); // You can pass CropAspectRatio if you want to crop the image, otherwise, pass null
    if (result != null) {
      setState(() {
      //  processedImage = result;
      });
    }
  }

  Future<CroppedFile?> imagePicker({required ImageSource source,CropAspectRatio ? cropAspectRatio}) async {
    final ImagePicker _picker = ImagePicker();
    CroppedFile  ?  _croppedFile ;
    final XFile? pickedFile = await _picker.pickImage(source: source);
    _croppedFile = await ImageCropper().cropImage(
      compressQuality: 50,
      sourcePath: pickedFile!.path,
      aspectRatio: cropAspectRatio ?? const CropAspectRatio(ratioX: 200, ratioY: 200)  ,
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
                      title: const Text('Gallery '),
                      onTap: () async {
                        controller.coverPhoto = await  imagePicker(source: ImageSource.gallery,);
                        Navigator.of(context).pop();

                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('Camera'),
                    onTap: () async {
                      controller.coverPhoto = await    imagePicker(source: ImageSource.camera,);
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
