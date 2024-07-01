import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_textfield.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../core/constants/my_textfield.dart';
import '../../user_profile_screen/user_profile_model.dart';
import 'edit_profile_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final GetUserByIdModel getUserByIdModel;
  const  EditProfileScreen({super.key,required this.getUserByIdModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfileController controller = Get.put(EditProfileController());

  fatchHoldValue(){
    controller.fullController.text = widget.getUserByIdModel.user?.fullName ?? "";
    controller.emailController.text =widget.getUserByIdModel.user?.email ?? "";
    controller.bioController.text =widget.getUserByIdModel.user?.bio ?? "";
    controller.handleController.text =widget.getUserByIdModel.user?.handle ?? "";

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatchHoldValue();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      body: MediaQuery.removePadding(
          removeTop: true,
          removeBottom: true,
          context: context,
          child: ListView(
            children: [
              imageView(),
              Padding(
                padding:  EdgeInsets.only(left: 28.0.aw,right: 28.aw),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45.ah,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        'fullnm'.tr,
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
                        fillColor: Colors.transparent,
                        hintText: 'fullnm'.tr, controller: controller.fullController, context: context),
                    SizedBox(
                      height: 10.ah,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        'emailn'.tr,
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
                      fillColor: Colors.transparent,
                      hintText: 'emailno'.tr, controller: controller.emailController, context: context),
                    SizedBox(
                      height: 15.ah,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        'Bio'.tr,
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
                      fillColor: Colors.transparent,
                        hintText: 'Enteruserbio'.tr, controller: controller.bioController, context: context,maxLines: 2,),
                    SizedBox(
                      height: 15.ah,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        'Username'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.fSize),
                      ),
                    ),
                    SizedBox(height: 10.ah,),

                    CustomTextFormField(fillColor: Colors.transparent, hintText: 'Enter username', controller: controller.handleController, context: context,),

                    SizedBox(height: 10.ah,),
                    Container(decoration: BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(25),),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 10,),
                            CustomImageView(
                             imagePath:  'assets/image/Accept.svg',
                              height: 20.adaptSize,
                              width: 20.adaptSize,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              'Handlle'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.fSize),
                            ),
                          const  SizedBox(width: 10,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.ah,
                    ),
                    Center(
                      child: CustomPrimaryBtn1(
                        title: 'Saveid'.tr,
                        isLoading: false,
                        onTap: () {
                          controller.editProfile();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_Screen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.ah,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),

    );
  }
  Widget imageView() {
    return SizedBox(
      height: 290+50.ah,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 217+50.ah,
            width: double.infinity,
            child: CustomImageView(
              radius: BorderRadius.only(
                  bottomRight: Radius.circular(25.adaptSize),
                  bottomLeft: Radius.circular(25.adaptSize)),
              fit: BoxFit.cover,
              imagePath: controller.coverPhoto==null ? widget.getUserByIdModel.user?.coverPhotoUrl : controller.coverPhoto!.path,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 121.aw,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child:  CustomImageView(
                  width: 140.ah,
                  height: 140.ah,
                  fit: BoxFit.cover,
                  imagePath: controller.profilePhoto==null ? widget.getUserByIdModel.user?.avatarUrl : controller.profilePhoto!.path,
                  radius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 95.ah,
            right: 30.aw,
            child:  InkWell(
                onTap:() async {
            _showPickerForCoverPhoto(context,const CropAspectRatio(ratioX: 300, ratioY: 200));
                },
                child: Image.asset('assets/image/edit.png',height:38.adaptSize,width: 38.adaptSize,fit: BoxFit.contain,)),
          ),
          Positioned(
            bottom: -1,
            left: 212.aw,
            child:  InkWell(
                onTap:() async {
                  _showPickerForProfilePhoto(context,null);
                },
                child: Image.asset('assets/image/edit.png',height:38.adaptSize,width: 38.adaptSize,fit: BoxFit.contain,)),
          ),
          SafeArea(
            child: backAndSettingIconRow(),
          ),
        ],
      ),
    );
  }
  Widget backAndSettingIconRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw,top : 60.ah),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                Get.back();
              },
              child: Image.asset('assets/image/arrow.png', height: 20.aw, width: 20.aw)),
          SizedBox(
            // 'assets/image/ic_settings_24px.png',
            height: 20.aw,
            width: 20.aw,
          ),
        ],
      ),
    );
  }


  Future<XFile?> imagePicker({required ImageSource source,CropAspectRatio ? cropAspectRatio}) async {
    final ImagePicker _picker = ImagePicker();
    CroppedFile  ?  _croppedFile ;
     XFile? pickedFile = await _picker.pickImage(source: source);
    _croppedFile = await ImageCropper().cropImage(
      compressQuality: 50,
      sourcePath: pickedFile!.path,
      aspectRatio: cropAspectRatio ?? const CropAspectRatio(ratioX: 200, ratioY: 200)  ,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (_croppedFile != null) {
      pickedFile = XFile(_croppedFile.path);
      setState(() {});
    }
    return pickedFile;
  }
  void _showPickerForCoverPhoto(context,CropAspectRatio ? cropAspectRatio) {
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
                        controller.coverPhoto = await  imagePicker(source: ImageSource.gallery,cropAspectRatio: cropAspectRatio);
                        Navigator.of(context).pop();

                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('Camera'),
                    onTap: () async {
                      controller.coverPhoto = await    imagePicker(source: ImageSource.camera,cropAspectRatio: cropAspectRatio);

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });

  }
  void _showPickerForProfilePhoto(context,CropAspectRatio ? cropAspectRatio) {
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
                        controller.profilePhoto = await  imagePicker(source: ImageSource.gallery,cropAspectRatio: cropAspectRatio);
                        Navigator.of(context).pop();

                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('Camera'),
                    onTap: () async {
                      controller.profilePhoto = await    imagePicker(source: ImageSource.camera,cropAspectRatio: cropAspectRatio);

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
