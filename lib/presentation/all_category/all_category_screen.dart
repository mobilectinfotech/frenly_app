import 'package:flutter/material.dart';
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

  bool? _isFood = false;
  bool? _isFashion = false;
  bool? _isTech = false;
  bool? _isScience = false;
  bool? _isGame = false;
  bool? _isFinance = false;
  bool? _isComedy = false;
  bool? _isSongs = false;
  bool? _isHollywood = false;
  bool? _isHumor = false;
  bool? _isAsian = false;
  bool? _isCode = false;
  bool? _isApps = false;
  bool? _isUIUX = false;

  @override
  void initState() {
    super.initState();
    // Get.delete<AllCategoryController>(force: true);
  }

  final AllCategoryController controller = Get.put(
    AllCategoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: Row(
            children: [
              Text(
                'AllCategory'.tr,
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
            InkWell(
              onTap: () {

                controller.onTapDeleteButton();
              },
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/image/delete.png',
                    height: 20.ah,
                    width: 20.aw,
                  )),
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
                      child: Text(
                        'NewCategory'.tr,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.fSize),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      return Obx(() {
                        if (controller.categoryModel.value == null) {
                          return const Center(
                            child: CircularProgressIndicator(
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
                                    _isFood = value!;
                                    String selectVal = "Food".tr;
                                    value! ? list.add(selectVal) : list.remove(selectVal);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      });
                      return ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          ListTile(
                            title: Text("Fashion".tr),
                            leading: Checkbox(
                              value: _isFashion,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isFashion = value!;
                                  String selectVal = "Fashion".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Tech".tr),
                            leading: Checkbox(
                              value: _isTech,
                              onChanged: (value) {
                                setState(() {
                                  _isTech = value!;
                                  String selectVal = "Tech";
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Science".tr),
                            leading: Checkbox(
                              value: _isScience,
                              onChanged: (value) {
                                setState(() {
                                  _isScience = value!;
                                  String selectVal = "Science".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Game".tr),
                            leading: Checkbox(
                              value: _isGame,
                              onChanged: (value) {
                                setState(() {
                                  _isGame = value!;
                                  String selectVal = "Game".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Finance".tr),
                            leading: Checkbox(
                              value: _isFinance,
                              onChanged: (value) {
                                setState(() {
                                  _isFinance = value!;
                                  String selectVal = "Finance".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Comedy".tr),
                            leading: Checkbox(
                              value: _isComedy,
                              onChanged: (value) {
                                setState(() {
                                  _isComedy = value!;
                                  String selectVal = "Comedy".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Song".tr),
                            leading: Checkbox(
                              value: _isSongs,
                              onChanged: (value) {
                                setState(() {
                                  _isSongs = value!;
                                  String selectVal = "Songs".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Hollywood".tr),
                            leading: Checkbox(
                              value: _isHollywood,
                              onChanged: (value) {
                                setState(() {
                                  _isHollywood = value!;
                                  String selectVal = "Hollywood".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Humor".tr),
                            leading: Checkbox(
                              value: _isHumor,
                              onChanged: (value) {
                                setState(() {
                                  _isHumor = value!;
                                  String selectVal = "Humor".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Asian".tr),
                            leading: Checkbox(
                              value: _isAsian,
                              onChanged: (value) {
                                setState(() {
                                  _isAsian = value!;
                                  String selectVal = "Asian".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Code".tr),
                            leading: Checkbox(
                              value: _isCode,
                              onChanged: (value) {
                                setState(() {
                                  _isCode = value!;
                                  String selectVal = "Code".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Apps".tr),
                            leading: Checkbox(
                              value: _isApps,
                              onChanged: (value) {
                                setState(() {
                                  _isApps = value!;
                                  String selectVal = "Apps";
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("UI/UX".tr),
                            leading: Checkbox(
                              value: _isUIUX,
                              onChanged: (value) {
                                setState(() {
                                  _isUIUX = value!;
                                  String selectVal = "UI/UX".tr;
                                  value! ? list.add(selectVal) : list.remove(selectVal);
                                });
                              },
                            ),
                          ),
                        ],
                      );
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
