import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
// import 'package:frenly_app/core/constants/app_dialogs.dart';
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
import 'package:auto_size_text/auto_size_text.dart';



class UploadBlogScreen extends StatefulWidget {
  const UploadBlogScreen({super.key});

  @override
  State<UploadBlogScreen> createState() => _UploadBlogScreenState();
}

class _UploadBlogScreenState extends State<UploadBlogScreen> {


  UploadBolgController controller = Get.put(UploadBolgController());
  final _formKeyLogin = GlobalKey<FormState>();
  // final HtmlEditorController htmlController = HtmlEditorController();

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

            SizedBox(height: 20.ah),
              SizedBox(
                child: Stack(
                  children: [
                    CustomImageView(
                      radius: BorderRadius.circular(20.adaptSize),
                      imagePath: controller.coverPhoto?.path ?? "assets/icons/Frame 1171278712.png",
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                        right: 15.aw, bottom: 15.ah,
                        child: InkWell(
                            onTap: () {
                              _showImagePiker();
                            },
                            child: Image.asset('assets/image/edit.png',height: 38.adaptSize,width: 38.adaptSize,fit: BoxFit.fill,))),
                  ],),
              ),

              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 5.0.aw ,right:  5.aw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20.ah),
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Text('Title'.tr,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                        ),
                      ),
                    ),

                    SizedBox(height: 10.ah,),
                    // SizedBox(child: CustomTextFormField(hintText: "enter_title".tr,controller: controller.titleController,validator: Validator.notEmpty, context: context,onChanged: controller.updatePreview(value))),
                    SizedBox(
                      child: CustomTextFormField(
                        hintText: "enter_title".tr,
                        controller: controller.titleController,
                        validator: Validator.notEmpty,
                        context: context,
                       onChanged: (value) => controller.updatePreview(value), // ✅ FIXED
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.remove, size: 20),
                    //       onPressed: controller.decreaseTitleSize,
                    //     ),
                    //     Obx(() => Text("${controller.titleFontSize.value.toInt()}", style: TextStyle(fontWeight: FontWeight.bold))),
                    //     IconButton(
                    //       icon: Icon(Icons.add, size: 20),
                    //       onPressed: controller.increaseTitleSize,
                    //     ),
                    //   ],
                    // ),

                    SizedBox(height: 10.ah,),
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Text('Body'.tr,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                        ),
                      ),
                    ),

                    SizedBox(height: 10.ah,),
                    CustomTextFormField(context: context,hintText: "enter_body".tr,controller: controller.bodyController,maxLines: 8,validator: Validator.notEmpty,),

                    // SizedBox(height: 10.ah,),
                    // CustomTextFormField(
                    //   context: context,
                    //   hintText: "enter_body".tr,
                    //   controller: controller.bodyController,
                    //   maxLines: 6,
                    //   validator: Validator.notEmpty,
                    //   onChanged: (v) => controller.updateBodyPreview(v),
                    // ),

                   /* SizedBox(height: 20.ah),
                    // BODY - RICH EDITOR (FULLY VISIBLE)
                    Container(
                      height: 400.ah, // Increased height
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: HtmlEditor(
                        controller: htmlController,
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          defaultToolbarButtons: [
                            FontButtons(clearAll: false, strikethrough: false),
                            ListButtons(listStyles: false),
                            ParagraphButtons(lineHeight: false, caseConverter: false),
                            InsertButtons(
                             // image: true,
                              video: false,
                              audio: false,
                              table: false,
                              hr: false,
                              otherFile: false,
                            ),
                          ],
                        ),
                        htmlEditorOptions: HtmlEditorOptions(
                          hint: 'Start writing your blog...',
                          shouldEnsureVisible: true,
                      //    autoFocus: false,
                        ),
                        callbacks: Callbacks(
                          onChangeContent: (String? content) {
                            controller.bodyController.text = content ?? '';
                            print("HTML Content: $content"); // For debugging
                          },
                        ),
                      ),
                    ),*/

                    // SizedBox(height: 20.ah,),
                    // Container(
                    //   height: 500.ah, // Make it tall
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey.shade300),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: HtmlEditor(
                    //     controller: htmlController,
                    //     htmlToolbarOptions: HtmlToolbarOptions(
                    //       toolbarPosition: ToolbarPosition.aboveEditor,
                    //       defaultToolbarButtons: [
                    //         FontButtons(clearAll: false),
                    //         ListButtons(),
                    //         ParagraphButtons(),
                    //         InsertButtons(table: true, video: false),
                    //       ],
                    //     ),
                    //     htmlEditorOptions: HtmlEditorOptions(
                    //       hint: 'Start writing your blog...',
                    //       shouldEnsureVisible: true,
                    //       // autoFocus: false,
                    //       // webViewJs: true, // Enable JS
                    //     ),
                    //     callbacks: Callbacks(
                    //       onInit: () {
                    //         print("Editor loaded!");
                    //       },
                    //       onChangeContent: (String? content) {
                    //         controller.bodyController.text = content ?? '';
                    //         print("Typed: $content");
                    //       },
                    //     ),
                    //   ),
                    // ),

                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(icon: Icon(Icons.remove, size: 18), onPressed: controller.decreaseBodySize),
                        Obx(()=> Text("${controller.bodyFontSize.value.toInt()}", style: TextStyle(fontWeight: FontWeight.bold))),
                        IconButton(icon: Icon(Icons.add, size: 18), onPressed: controller.increaseBodySize),
                      ],
                    ),
                SizedBox(height: 20),

                    Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title preview
                      Obx(() => AutoSizeText(
                        controller.titlePreview.value.isEmpty ? "Title preview".tr : controller.titlePreview.value,
                        style: TextStyle(
                          fontSize: controller.titleFontSize.value, // this is the preferred font size
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      )),

                      SizedBox(height: 8),

                      // Body preview
                      Obx(() => AutoSizeText(
                        controller.bodyPreview.value.isEmpty ? "Body preview".tr : controller.bodyPreview.value,
                        style: TextStyle(
                          fontSize: controller.bodyFontSize.value,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 4,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  )),

                    Obx(() => Slider(
                      min: 10, max: 48, divisions: 19,
                      value: controller.titleFontSize.value,
                      onChanged: controller.setTitleSize,
                    )),*/

                    SizedBox(height: 20.ah,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('tags'.tr,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize)),
                    ),

                    SizedBox(height: 10.ah,),
                    DetectableTextFieldWidget(
                      detectableTextEditingController:controller.detectableCaptionTextEditingController,
                      maxLines: 2,
                      hintText: "enter_tags".tr,
                    ),

                    // Row(
                    //   children: [
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


                    // 🔥 Live Preview using AutoSizeText
                    // Obx(() => AutoSizeText(
                    //   controller.previewText.isEmpty
                    //       ? "Your title will appear here"
                    //       : controller.previewText.value,
                    //   style: TextStyle(
                    //     fontSize: 20.fSize,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.black87,
                    //   ),
                    //   maxLines: 2,
                    //   minFontSize: 12,
                    //   textAlign: TextAlign.center,
                    // )),


                    const SizedBox(height: 30),
                     Center(
                      child: Obx(
                        ()=> CustomPrimaryBtn1(
                          title:'Postt'.tr,
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            if (_formKeyLogin.currentState!.validate()) {
                                controller.postBlog();
                              // if(controller.coverPhoto != null){
                              //   controller.postBlog();
                              // }
                              // else{
                              //   AppDialog.taostMessage("_photo_can_not_be_empty".tr);
                              // }
                            }

                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Demo_deshboardPage()));
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => EditBlog_Screen()));
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
                      controller.coverPhoto = await imagePicker(source: ImageSource.camera);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        }
   );
  }
}

// class QuillTestWidget extends StatelessWidget {
//   final QuillController controller = QuillController.basic();
//
//   @override
//   Widget build(BuildContext context) {
//     return QuillProvider(
//       configurations: QuillConfigurations(
//         controller: controller,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             QuillToolbar(
//               configurations: QuillToolbarConfigurations(
//                 showBoldButton: true,
//                 showItalicButton: true,
//                 showFontSize: true,
//                 fontSizeValues: {'Small': '12', 'Large': '24'},
//               ),
//               child: const SizedBox.shrink(),
//             ),
//             Expanded(
//               child: QuillEditor.basic(
//                 configurations: QuillEditorConfigurations(
//                   padding: EdgeInsets.all(12),
//                   placeholder: 'Type here...',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }