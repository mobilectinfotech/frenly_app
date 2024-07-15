import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/bottom_sheet_widgets.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Vlog/add_new_category/add_new_cateogry_bottom_sheet.dart';
import 'package:frenly_app/presentation/all_category/all_cateogry_controller.dart';
import 'package:get/get.dart';

class All_Categories extends StatefulWidget {
  const All_Categories({super.key});

  @override
  State<All_Categories> createState() => _All_CategoriesState();
}

class _All_CategoriesState extends State<All_Categories> {
  List<String> list = [];



  @override
  void initState() {
    super.initState();
    // Get.delete<AllCategoryController>(force: true);
  }
  final AllCategoryController controller = Get.put(AllCategoryController());

  void deleteCategories(
      BuildContext context,
      ) async {

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          final AllCategoryController controller = Get.put(AllCategoryController());
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('delete_categories'.tr,
                style: TextStyle(
                  color: const Color(0XFF111111),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.adaptSize,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: <Widget>[
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color:Color(0xff001649),width: 1.aw)),
                          child: Center(
                            child: Text('cancel'.tr,
                              style: TextStyle(
                                color: const Color(0XFF001649),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.aw),
                      InkWell(
                        onTap: () {
                          Get.back();
                           controller.onTapDeleteButton();
                          setState(() {
                          });

                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff001649),
                          ),
                          child: Center(
                            child: Text('Delete'.tr,
                              style: TextStyle(
                                color: const Color(0XFFFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: Row(
            children: [
              Text('AllCategory'.tr,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 32.fSize),
              ),
            ],
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 15.h),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_sharp)),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  if(controller.selectedCategory.length == 0){
                    AppDialog.taostMessage("select_categories".tr);
                  }else{
                    deleteCategories(context);
                  }

                },
                child: Image.asset('assets/image/delete.png',
                  height: 40.ah,width: 40.aw,
                ),
              ),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return const AddNewCategoryBottomSheet();
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('NewCategory'.tr,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.fSize),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      return Obx(() {
                        if (controller.categoryModel.value == null) {
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 1,
                              color: MyColor.primaryColor,
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: (controller.categoryModel.value?.categories ?? []).length,
                          itemBuilder: (context, index) {
                            var category = (controller.categoryModel.value?.categories ?? [])[index];
                            return ListTile(
                              title: Text(category.name ?? ""),
                              leading: Checkbox(
                                value: controller.selectedCategory.contains(category),
                                onChanged: (bool? value) {
                                  if (controller.selectedCategory.contains(category)) {
                                    controller.selectedCategory.remove(category);
                                  } else {
                                    controller.selectedCategory.add(category);
                                  }
                                  setState(() {
                                    String selectVal = "Food".tr;
                                    value! ? list.add(selectVal) : list.remove(selectVal);
                                  });
                                },
                              ),
                            );},
                        );
                      });
                    }),
                  ),

                  /*Center(
                      child: _list.isEmpty
                          ? Text("")
                          : RichText(
                          text: TextSpan(
                              text: "Selected Games:\n",
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${_list.toString()} ',
                                    style: TextStyle(fontSize: 16)),
                              ]))),*/
                ],
              ));
        }));
  }
}
