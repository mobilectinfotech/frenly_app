import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_textfield.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Vlog/add_new_category/add_new_cateogry_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void onTapAddNewCategory({required BuildContext context}) {
  Get.back();
  showBottomSheet(
    context:context,
    builder: (context) {
      return AddNewCategoryBottomSheet();
    },
  );
}

class AddNewCategoryBottomSheet extends StatefulWidget {
  const AddNewCategoryBottomSheet({super.key});

  @override
  State<AddNewCategoryBottomSheet> createState() => _AddNewCategoryBottomSheetState();
}

class _AddNewCategoryBottomSheetState extends State<AddNewCategoryBottomSheet> {
  @override
  void initState() {
    super.initState();
    Get.delete<AddNewCategoryController>();
  }

  @override
  Widget build(BuildContext context) {
    AddNewCategoryController controller = Get.put(AddNewCategoryController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 6.ah,
          ),
          Opacity(
            opacity: 0.50,
            child: Container(
              width: 48.aw,
              height: 5.ah,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24.ah,
          ),
          Row(
            children: [
              Text(
                "Category Name",
                style:
                GoogleFonts.roboto().copyWith(fontSize: 22.fSize, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 5.ah,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Category Name Can't be empty";
              }
            },
            context: context,
            controller: controller.textEditingController,
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              controller.onTapCategoryBtn();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.aw, vertical: 10.ah),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: MyColor.primaryColor),
              child: Text(
                "Add New Category",
                style: GoogleFonts.roboto().copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20.ah,
          )
        ],
      ),
    );
  }
}
